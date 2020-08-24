import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class ChefReg2ViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String errorMessage;

  Future addChefData(String chefName, DateTime dateOfBirth) async {
    // String userUID = await getUser;
    setState(ViewState.Busy);
    String userID = await getUser;
    bool dataValidated;

    Validators().verifyNameInputFeild(chefName) && dateOfBirth != null
        ? dataValidated = true
        : dataValidated = false;

    if (dataValidated) {
      print("--------------User().getUid in CustReg2ViewModel: " + userID);
      await DatabaseService(uid: userID).updateChefData({
        'chefName': chefName,
        'chefDateOfBirth': dateOfBirth,
      });
      _navigationService.navigateTo(routes.ChefProfileRoute);
      setState(ViewState.Idle);
    } else {
      errorMessage = "   Registration failed\n   Add valid info";
      setState(ViewState.Idle);
    }
  }
}
