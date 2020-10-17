import 'dart:io';
import 'package:fitness_diet/core/constants/route_paths.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/DatabaseServices/dbHelperFtns.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class AddDishViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

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

  // extractSingleFeildListFromProviderList() {}

  // Future uploadFile(File _filePath) async {
  //   //  String fileBasename = _filePath.path.split('/').last;
  //   StorageReference storageReference =
  //       FirebaseStorage.instance.ref().child('dishPics/$_filePath}');
  //   StorageUploadTask uploadTask = storageReference.putFile(_filePath);
  //   await uploadTask.onComplete;
  //   print('File Uploaded');
  //   storageReference.getDownloadURL().then((fileURL) {
  //     //  setState(() {
  //     //    _uploadedFileURL = fileURL;
  //     //  });
  //     print("fileURL = " + fileURL.toString());
  //     return fileURL;
  //   });
  // }

  Future uploadDishInfo(String dishName, int dishPrice, int totalPrepTime,
      File dishPic, String dishCatg, String dishAttr) async {
    setState(ViewState.Busy);
    print("--------> Upload dish Function reached.");

    if (Validators().verifyNameInputFeild(dishName) &&
        Validators().verifyNameInputFeild(dishCatg) &&
        Validators().verifyNumInputFeild(dishPrice) &&
        Validators().verifyNumInputFeild(totalPrepTime) &&
        dishPic != null) {
      print("uploaded yahooooooo");
      String userId =  getUser;
// ---------- Check if attribute name already exists then add accordingly
      if (dishAttr != null) {
        bool attrNameAlreadyExist = await DBHelperFtns().feildExistInCollection(
            DatabaseService().dishAttrCollection, 'attrID', dishAttr);
        if (attrNameAlreadyExist) await DatabaseService().addAttrData(dishAttr);
      }

// ---------- Converting attrName to ID
      String attrID = await DBHelperFtns().documentNameToID(
        DatabaseService().dishAttrCollection,
        "attrName",
        "attrID",
        dishAttr,
      );
// ---------- Converting ctgName to ID
      String ctgID = await DBHelperFtns().documentNameToID(
        DatabaseService().dishCtgCollection,
        "ctgName",
        "ctgID",
        dishCatg,
      );

      String _chefName = await DBHelperFtns().documentIDToName(
        DatabaseService().chefCollection,
        "chefID",
        "chefName",
        userId,
      );
      print(
          "---------> ChefID and extracted ChefName inside AddDishViewModel : " +
              userId.toString() +
              " " +
              _chefName);

      print("---------> attrID inside AddDishViewModel : " + attrID.toString());

      String _uploadedImgURL = await ConstantFtns().uploadFile(dishPic);

      await DatabaseService().addNewDishData({
        'dishName': dishName,
        'dishCatg': dishCatg,
        'chefID': userId,
        'dishPrepTime': totalPrepTime,
        'dishPic': _uploadedImgURL.toString(),
        'dishPrice': dishPrice,
        'attrID': attrID,
        'chefName': _chefName,
        'ctgID': ctgID
      });

      setState(ViewState.Idle);
      _navigationService.navigateTo(ChefProfileRoute);
    } else {
      setErrorMessage("Enter valid info");
      setState(ViewState.Idle);
    }
  }
}
