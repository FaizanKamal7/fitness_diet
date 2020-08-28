import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ConstantFtns extends BaseViewModel {
  Future<File> cropImgFile(PickedFile picked) async {
    File croppedImg = await ImageCropper.cropImage(
      sourcePath: picked.path,
      aspectRatio: CropAspectRatio(ratioX: 1.3, ratioY: 1.0),
    );
    print("---------> Cropped image inside AddDishViewModel: " +
        croppedImg.toString());
    return croppedImg;
  }

  Future<File> getImgFile(ImageSource source, Size deviceSize) async {
    setState(ViewState.Busy);
    print("-----> 'getImgFile' function reached from inside ConstantFtns");
    ImagePicker imgPick = ImagePicker();
    File croppedImageFile;
    print("image.path");
    PickedFile picked = await imgPick.getImage(
        source: source,
        maxWidth: deviceSize.width,
        // maxHeight: deviceSize.height * 0.1,
        preferredCameraDevice: CameraDevice.rear);
    if (picked != null) {
      croppedImageFile = await cropImgFile(picked);
    }
    //_navigationService.goBack();
    setState(ViewState.Idle);
    return croppedImageFile;
  }

  Future<String> uploadFile(File _filePath) async {
    var completer = Completer<String>();
    print("-----> 'uploadFile' function reached from inside ConstantFtns");
    //  String fileBasename = _filePath.path.split('/').last;

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('dishPics/$_filePath}');
    StorageUploadTask uploadTask = storageReference.putFile(_filePath);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      completer.complete(fileURL);
      print("fileURL inside 'uploadFtns inside ConstantFtns'= " +
          fileURL.toString());
      print("completer.future 'uploadFtns inside ConstantFtns'= " +
          completer.future.toString());
    });
    return completer.future;
  }
}
