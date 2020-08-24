import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:flutter/cupertino.dart';

class CustRegViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  dynamic verifiedUserID;

  Future register(String phoneNo) async {
    print("---------> CustRegViewModel reached");
    var updatedPhoneNo = phoneNo.replaceFirst(RegExp(r'0'), '+92');

    setState(ViewState.Busy);
    String phoneNoAlreadyRegistered =
        await DatabaseService().isPhoneNoAlreadyRegistered(phoneNo);
    //
    // >>>>>>>>>>>>> Validate phone no
    //
    if (Validators().verifyPhoneNumber(phoneNo) == false) {
      setErrorMessage('  Enter valid phone no i.e 03xxxxxxxxx');
      setState(ViewState.Idle);
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
      setErrorMessage(
          '  This phone no is already registered. \n  Try again with new number');
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
          await DatabaseService(uid: verifiedUserID).updateCustData({
            'custPhNo': updatedPhoneNo,
          });
          print(
              "PhoneNo verified and added to DB (Message from within 'CustRegViewmodel')");
          _navigationService.navigateTo(routes.CustReg2Route);

          setState(ViewState.Idle);
        } else {
          print(
              "Updated the data in databse - ELSE ___________________________________" +
                  verifiedUserID.toString());
          setErrorMessage(
              "   Something went wrong while\n   verification. Please try again");
          setState(ViewState.Idle);
        }
      } else {
        setErrorMessage(
            "   Phone no is already registered\n   Please try again with new number");
        setState(ViewState.Idle);
      }
    }
  }

  // Future<dynamic> verifyPhone(phoneNo) async {
  //   final DialogService _dialogService = locator<DialogService>();
  //   var completer = Completer<dynamic>();
  //   print("‎ Verify Phone reached __________________");
  //   String smsCode;
  //   dynamic newUserResult;

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
  //     newUserResult = await AuthService().signInWithPhoneNumber(authCred);

  //     print("Why the fuck are you running?");
  //     if (newUserResult != null) {
  //       print("Phone no is : " + phoneNo);
  //       print("__Result: " + newUserResult.toString());
  //       print("AuthCredential : _______ " + authCred.toString());

  //       // --- Proceeding to screen 2 of chef registration
  //     }
  //     completer.complete(newUserResult);
  //   };
  //   //
  //   ///  >>>>>>>>>>>>> On Timeout
  //   //
  //   final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
  //     print("\n2. Auto retrieval time out");
  //     completer.complete(newUserResult);
  //   };

  //   // >>>>>>>>>>>>>  On manual code verification

  //   final PhoneCodeSent smsCodeSent =
  //       (String verID, [int forceCodeResend]) async {
  //     print(" --------------> Code sent reached ");

  //     // ignore: non_constant_identifier_names
  //     var OTPDialogResult = await getOTPresult();

  //     print("OTP entered by user: " + OTPDialogResult.toString());
  //     AuthCredential authCred = PhoneAuthProvider.getCredential(
  //         verificationId: verID, smsCode: OTPDialogResult);
  //     print("SMS code sent reached OTP is : " + OTPDialogResult.toString());

  //     newUserResult = AuthService().signInWithPhoneNumber(authCred);
  //     completer.complete(newUserResult);
  //   };

  //   final PhoneVerificationFailed verificationFailed =
  //       (AuthException authException) {
  //     print('${AuthException(smsCode, "message")}');

  //     if (authException.message.contains('not authorized'))
  //       print('   App not authroized');
  //     // UIHelper().showErrorButtomSheet(context, '   App not authroized');
  //     else if (authException.message.contains('Network'))
  //       print('   Please check your internet \n    connection and try again ');
  //     else
  //       print('Something has gone wrong, please try later ' +
  //           authException.message);
  //     setState(ViewState.Idle);
  //     completer.complete(newUserResult);
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
