import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class CustReg2ViewModel extends BaseViewModel {
  String errorMessage;

  Future<bool> addCustData(String custName, DateTime dateOfBirth) async {
    // String userUID = await getUser;
    String userID = await getUser;
    bool dataValidated;
    setState(ViewState.Busy);
    Validators().verifyNameInputFeild(custName) && dateOfBirth != null
        ? dataValidated = true
        : dataValidated = false;

    if (dataValidated) {
      print("--------------User().getUid: " + userID);
      await DatabaseService(uid: userID).updateCustData({
        'custName': custName,
        'custDateOfBirth': dateOfBirth,
      });
      setState(ViewState.Idle);
      return true;
    } else {
      errorMessage = "   Registration failed\n   Add valid info";
      setState(ViewState.Idle);

      return false;
    }
  }
}
