import 'dart:async';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';


class ChefRegViewModel extends BaseViewModel {
  String errorMessage;

  dynamic verifiedUserID;
  dynamic newUserResult;

  Future<bool> register(String phoneNo) async {
    var updatedPhoneNo = phoneNo.replaceFirst(RegExp(r'0'), '+92');
    print("Registered reached __________________");
    setState(ViewState.Busy);
    String phoneNoAlreadyRegistered =
        await DatabaseService().isPhoneNoAlreadyRegistered(phoneNo);
    //
    // >>>>>>>>>>>>> Validate phone no
    //
    if (Validators().verifyPhoneNumber(phoneNo) == false) {
      errorMessage = '  Enter valid phone no i.e 03xxxxxxxxx';
      print("Error: " + errorMessage);
      setState(ViewState.Idle);
      return false;
    }
    //
    // >>>>>>>>>>>>> Check if user already registered
    //

    else if (await DatabaseService()
            .isPhoneNoAlreadyRegistered(updatedPhoneNo) !=
        null) {
      print("Already exist ______________" +
          DatabaseService()
              .isPhoneNoAlreadyRegistered(updatedPhoneNo)
              .toString());
      errorMessage =
          '  This phone no is already registered. \n  Try again with new number';
      setState(ViewState.Idle);
      return false;
    } else {
      //
      // >>>>>>>>>>>>> Upon successful authentication
      //
      if (phoneNoAlreadyRegistered == null) {
        verifiedUserID = await AuthService().verifyPhone(updatedPhoneNo);
        print("New user result at the end : " + verifiedUserID.toString());

        if (verifiedUserID != null) {
          await DatabaseService(uid: verifiedUserID).updateChefData({
            'chefPhNo': updatedPhoneNo,
          });
          setState(ViewState.Idle);
          return true;
        } else {
          print(
              "Updated the data in databse - ELSE ___________________________________" +
                  newUserResult.toString());
          errorMessage =
              "   Something went wrong while\n   verification. Please try again";
          setState(ViewState.Idle);
          return false;
        }
      } else {
        errorMessage =
            "   Phone no is already registered\n   Please try again with new number";
        setState(ViewState.Idle);
        return false;
      }
    }
  }
}
