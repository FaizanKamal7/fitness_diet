import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class ChefSignInViewModel extends BaseViewModel {
  String errorMessage;
  dynamic verifiedUserID;

  Future<bool> signInChef(String phNo) async {
    setState(ViewState.Busy);
    bool dataValidated;
    var updatedPhoneNo = phNo.replaceFirst(RegExp(r'0'), '+92');
    String phoneNoAlreadyRegistered = await DatabaseService().isPhoneNoAlreadyRegistered(updatedPhoneNo);
    Validators().verifyPhoneNumber(phNo)
        ? dataValidated = true
        : dataValidated = false;

    if (phoneNoAlreadyRegistered == "chef") {
      verifiedUserID = await AuthService().verifyPhone(updatedPhoneNo);
      if (dataValidated) {
        if (verifiedUserID != null) {
          setState(ViewState.Idle);
          return true;
        } else {
          setState(ViewState.Idle);
          errorMessage =
              "   Something went wrong while\n   verification. Please try again";
          return false;
        }
      } else {
        setState(ViewState.Idle);
        errorMessage = "     Enter valid phone no i.e 03xxxxxxxxx";
        return false;
      }
    } else {
      setState(ViewState.Idle);
      errorMessage = "     Try again with different number\n     Not registered by any chef";
      return false;
    }
  }
}
