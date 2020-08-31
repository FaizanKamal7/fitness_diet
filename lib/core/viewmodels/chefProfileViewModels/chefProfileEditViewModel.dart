import 'dart:io';

import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/constants/route_paths.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class ChefProfileEditViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future updateChefData(String chefName, String chefLocation,
      DateTime chefdateOfBirth, File chefProfilePic) async {
    setState(ViewState.Busy);
    String _currentUserID = await getUser;
    Map<String, dynamic> chefdataMap = {};

    if (Validators().verifyNameInputFeild(chefName))
      chefdataMap.addAll({"chefName": chefName});
    if (Validators().verifyNameInputFeild(chefLocation))
      chefdataMap.addAll({"chefLocation": chefLocation});
    if (chefdateOfBirth != null)
      chefdataMap.addAll({"chefDateOfBirth": chefdateOfBirth});
    if (chefProfilePic != null) {
      String _uploadedImgURL = await ConstantFtns().uploadFile(chefProfilePic);
      chefdataMap.addAll({"chefPic": _uploadedImgURL});
    }
    print(
        "---------> ChefdataMap of user '$_currentUserID' Map inside ChefProfileEditViewModel : " +
            chefdataMap.toString());

    await DatabaseService().updateChefData(chefdataMap, _currentUserID);
    print("------> ChefData UPLOADED.");
    setState(ViewState.Idle);
    _navigationService.navigateTo(ChefProfileRoute);
  }
}
