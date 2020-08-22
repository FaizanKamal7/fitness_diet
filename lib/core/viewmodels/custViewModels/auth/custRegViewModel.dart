import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class CustRegViewModel extends BaseViewModel {
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

        print("Why the fuck are you running_?");
        if (verifiedUserID != null) {
          //print(
          // "Updated the data in databse - IF ___________________________________" +
          //     newUserResult.toString());

          await DatabaseService(uid: verifiedUserID).updateCustData({
            'custPhNo': updatedPhoneNo,
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

  /// Below function will return the userID upon successfull phone verification
  // ignore: missing_return
  // Future<dynamic> verifyPhone(phoneNo) async {
  //   var completer = Completer<bool>();
  //   print("‎ Verify Phone reached __________________");
  //   String smsCode;

  //   Future<String> getOTPresult() async {
  //     print("Dialog shown");
  //     setState(ViewState.Idle);
  //     var dialogResult =
  //         await _dialogService.showDialog(dialogType: Dialog_Types.OTP);

  //     return dialogResult.userText;
  //   }

  //   //
  //   //  >>>>>>>>>>>>> On verification complete
  //   //
  //   final PhoneVerificationCompleted verificationComplete =
  //       (AuthCredential authCred) async {
  //     newUserResult = await _authService.signInWithPhoneNumber(authCred);

  //     print("Why the fuck are you running?");
  //     if (newUserResult != null) {
  //       print("Phone no is : " + phoneNo);
  //       print("__Result: " + newUserResult.toString());
  //       print("AuthCredential : _______ " + authCred.toString());

  //       // --- Proceeding to screen 2 of chef registration
  //     }
  //     completer.complete(true);
  //   };
  //   //
  //   ///  >>>>>>>>>>>>> On Timeout
  //   //
  //   final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
  //     print("\n2. Auto retrieval time out");
  //     completer.complete(false);
  //   };

  //   // >>>>>>>>>>>>>  On manual code verification

  //   final PhoneCodeSent smsCodeSent =
  //       (String verID, [int forceCodeResend]) async {
  //     print(" --------------> Code sent reached ");
  //     // ignore: non_constant_identifier_names
  //     var OTPDialogResult = await getOTPresult();

  //     AuthCredential authCred = PhoneAuthProvider.getCredential(
  //         verificationId: verID, smsCode: OTPDialogResult);
  //     print("SMS code sent reached OTP is : " + OTPDialogResult.toString());

  //     newUserResult = AuthService().signInWithPhoneNumber(authCred);
  //     completer.complete(true);
  //   };

  //   final PhoneVerificationFailed verificationFailed =
  //       (AuthException authException) {
  //     print('${AuthException(smsCode, "message")}');

  //     // if (authException.message.contains('not authorized'))
  //     //   UIHelper().showErrorButtomSheet(context, '   App not authroized');
  //     // else if (authException.message.contains('Network'))
  //     //   UIHelper().showErrorButtomSheet(context,
  //     //       '   Please check your internet \n    connection and try again ');
  //     // else
  //     //   UIHelper().showErrorButtomSheet(
  //     //       context, '   Something has gone wrong, \n    Please try later ');
  //     // print('Something has gone wrong, please try later ' +
  //     //     authException.message);
  //     // setState(ViewState.Idle);
  //     // completer.complete(false);
  //   };

  //   await FirebaseAuth.instance
  //       .verifyPhoneNumber(
  //         phoneNumber: phoneNo,
  //         timeout: Duration(seconds: 50),
  //         verificationCompleted: verificationComplete,
  //         verificationFailed: verificationFailed,
  //         codeSent: smsCodeSent,
  //         codeAutoRetrievalTimeout: autoRetrieve,
  //       )
  //       .then((value) =>
  //           print("then newuser Reslut: " + newUserResult.toString()))
  //       .catchError((error) {
  //     print(error.toString());
  //   });
  //   print("New user result at the end : " + newUserResult.toString());
  //   return completer.future;
  // }

}
