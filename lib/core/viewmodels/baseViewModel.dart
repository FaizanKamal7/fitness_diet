import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../locator.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;


  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  dynamic newUserResult;
  var logger = Logger();


  bool verifyPhoneNumber(String PhoneNumber) {
    if (PhoneNumber != "") {
      if (PhoneNumber[0] == "0" &&
          PhoneNumber[1] == "3" &&
          PhoneNumber.length == 11) {
        print("Phone Number verified (Via constant function)");
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //
  // >>>>>>>>> S I G N   I N   W I T H   P H O M E  N U M B E R   P R O C E S S
  //

  // /// Below function will return the userID upon successfull phone verification
  // // ignore: missing_return
  // Future<void> verifyPhone(phoneNo, context) async {
  //   print("‎ Verify Phone reached __________________");
  //   String smsCode;
  //   Future<String> getOTPresult() async {
  //     logger.i("Dialog shown");

  //     var dialogResult =
  //         await _dialogService.showDialog(dialogType: Dialog_Types.OTP);

  //     return dialogResult.userText;
  //   }

  //   //
  //   //  >>>>>>>>>>>>> On verification complete
  //   //
  //   final PhoneVerificationCompleted verificationComplete =
  //       (AuthCredential authCred) async {
  //     // AuthResult newUserResult =
  //     //     await FirebaseAuth.instance.signInWithCredential(authCred);
  //     // FirebaseUser user = newUserResult.user;
  //     // User(uid: user.uid);

  //     newUserResult = await _authService.signInWithPhoneNumber(authCred);

  //     if (newUserResult != null) {
  //       print("Phone no is : " + phoneNo);
  //       print("__Result: " + newUserResult.toString());
  //       print("AuthCredential : _______ " + authCred.toString());

  //       // --- Proceeding to screen 2 of chef registration
  //       setState(ViewState.Idle);
  //     }
  //   };
  //   //
  //   ///  >>>>>>>>>>>>> On Timeout
  //   //
  //   final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
  //     print("\n2. Auto retrieval time out");
  //     setState(ViewState.Idle);
  //   };
  //   //
  //   /// >>>>>>>>>>>>>  On manual code verification
  //   //
  //   // final PhoneCodeSent smsCodeSent =
  //   //     (String verID, [int forceCodeResend]) async {
  //   //   print(" --------------> Code sent reached ");
  //   //   // ignore: non_constant_identifier_names
  //   //   var OTPDialogResult = await getOTPresult();

  //   //   AuthCredential authCred = PhoneAuthProvider.getCredential(
  //   //       verificationId: verID, smsCode: OTPDialogResult);
  //   //   logger.d("SMS code sent reached OTP is : " + OTPDialogResult.toString());
  //   //   newUserResult = await AuthService().signInWithPhoneNumber(authCred);
  //   // };

  //   final PhoneVerificationFailed verificationFailed =
  //       (AuthException authException) {
  //     print('${AuthException(smsCode, "message")}');

  //     if (authException.message.contains('not authorized'))
  //       UIHelper().showErrorButtomSheet(context, '   App not authroized');
  //     else if (authException.message.contains('Network'))
  //       UIHelper().showErrorButtomSheet(context,
  //           '   Please check your internet \n    connection and try again ');
  //     else
  //       UIHelper().showErrorButtomSheet(
  //           context, '   Something has gone wrong, \n    Please try later ');
  //     print('Something has gone wrong, please try later ' +
  //         authException.message);
  //     setState(ViewState.Idle);
  //   };

  //   await FirebaseAuth.instance
  //       .verifyPhoneNumber(
  //         phoneNumber: phoneNo,
  //         timeout: Duration(seconds: 50),
  //         verificationCompleted: verificationComplete,
  //         verificationFailed: verificationFailed,
  //         codeSent: (String verID, [int forceCodeResend]) async {
  //           print(" --------------> Code sent reached ");
  //           // ignore: non_constant_identifier_names
  //           var OTPDialogResult = await getOTPresult();

  //           AuthCredential authCred = PhoneAuthProvider.getCredential(
  //               verificationId: verID, smsCode: OTPDialogResult);
  //           logger.d(
  //               "SMS code sent reached OTP is : " + OTPDialogResult.toString());
  //           newUserResult = await AuthService().signInWithPhoneNumber(authCred);
  //         },
  //         codeAutoRetrievalTimeout: autoRetrieve,
  //       )
  //       .then((value) =>
  //           logger.d("then newuser Reslut: " + newUserResult.toString()))
  //       .catchError((error) {
  //     print(error.toString());
  //   });

  //   logger.wtf("New user result at the end : " + newUserResult.toString());
  // }


}
