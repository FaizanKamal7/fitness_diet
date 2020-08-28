import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_diet/core/constants/route_paths.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddDishViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  ImagePicker imgPick = ImagePicker();

// var fileName = "fileName.jpeg";
//   StorageUploadTask putFile =
//       storage.ref().child("folder/$fileName").putFile(_image);
//   putFile.future.catchError(onError);

//   UploadTaskSnapshot uploadSnapshot = await putFile.future;

//   print("image uploaded");

//   Map<String, dynamic> pictureData = new Map<String, dynamic>();
//   pictureData["url"] = uploadSnapshot.downloadUrl.toString();

//   DocumentReference collectionReference =
//       Firestore.instance.collection("collection").document(fileName);

//   await Firestore.instance.runTransaction((transaction) async {
//     await transaction.set(collectionReference, pictureData);
//     print("instance created");
//   }).catchError(onError);

  Future uploadFile(File _filePath) async {
    //  String fileBasename = _filePath.path.split('/').last;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('dishPics/$_filePath}');
    StorageUploadTask uploadTask = storageReference.putFile(_filePath);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      //  setState(() {
      //    _uploadedFileURL = fileURL;
      //  });
      print("fileURL = " + fileURL.toString());
      return fileURL;
    });
  }

  Future uploadDishInfo(String dishName, String dishPrice, int totalPrepTime,
      File dishPic, String dishCatg, String dishAttr) async {
    setState(ViewState.Busy);
    print("--------> Upload dish Function reached.");

    // print("dishPrice_  dishName_ " + dishPrice.toString() + " - " + dishName);
    int _dishPrice = dishPrice != null ? int.parse("0") : 0;

    // print("Num " + (_dishPrice + 10).toString());

    if (Validators().verifyNameInputFeild(dishName) &&
        Validators().verifyNameInputFeild(dishCatg) &&
        Validators().verifyNumInputFeild(_dishPrice) &&
        Validators().verifyNumInputFeild(totalPrepTime) &&
        dishPic != null) {
      print("uploaded yahooooooo");

      String _uploadedImgURL = await ConstantFtns().uploadFile(dishPic);
      print("---------> _uploadedImgURL inside AddDishViewModel : " +
          _uploadedImgURL.toString());
      String userId = await getUser;
      await DatabaseService().addNewDishData({
        'dishName': dishName,
        'dishCatg': dishCatg,
        'chefID': userId,
        'dishPrepTime': totalPrepTime,
        'dishPic': _uploadedImgURL.toString(),
        'dishPrice': dishPrice,
      });

      setState(ViewState.Idle);
      _navigationService.navigateTo(ChefProfileRoute);
    } else {
      setErrorMessage("Enter valid info");
      setState(ViewState.Idle);
    }
  }
}
