import 'dart:io';
import 'dart:ui';

import 'package:fitness_diet/core/constants/route_paths.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
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

  Future<File> cropImgFile(PickedFile picked) async {
    File croppedImg = await ImageCropper.cropImage(
      sourcePath: picked.path,
      aspectRatio: CropAspectRatio(ratioX: 1.3, ratioY: 1.0),
    );
    print("---------> Cropped image inside AddDishViewModel: " +
        croppedImg.toString());
    // if (croppedImg != null) {
    //   return croppedImg;
    // }
    return croppedImg;
  }

  Future<File> getImgFile(ImageSource source, Size deviceSize) async {
    setState(ViewState.Busy);
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

  Future uploadDishInfo(String dishName, String dishPrice, int totalPrepTime,
      File dishPic, String dishCatg, String dishAttr) async {
    print("--------> Upload dish Function reached.");
    String userId = await getUser;
    await DatabaseService().updateDishData({
      'dishName': dishName,
      'dishCatg': dishCatg,
      'chefID': userId,
      'dishPrepTime': totalPrepTime,
    });
    setState(ViewState.Idle);
    _navigationService.navigateTo(ChefProfileRoute);
    // if (Validators().verifyNameInputFeild(
    //                                     _dishNameContr.text) &&
    //                                 Validators()
    //                                     .verifyNameInputFeild(dishCatg) &&
    //                                 Validators().verifyNameInputFeild(
    //                                     _priceContr.toString()) &&
    //                                 prepTimeMin != null &&
    //                                 dishPic != null) {
    //                               print("uploaded yahooooooo");
    //                               await DatabaseService(uid: user.uid)
    //                                   .updateDishData({
    //                                 'chefDishName': _dishNameContr,
    //                                 'chefdishCatg': dishCatg,
    //                               });
  }
}
