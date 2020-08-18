import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class CustRegViewModel extends BaseViewModel {
  String errorMessage;
  final AuthService _authService = locator<AuthService>();
  dynamic newUserResult;
  final DialogService _dialogService = locator<DialogService>();
  
  
  Future<bool> register(String phoneNo, BuildContext context) async {
    var updatedPhoneNo = phoneNo.replaceFirst(RegExp(r'0'), '+92');
    print("Registered reached __________________");
    setState(ViewState.Busy);

    //
    // >>>>>>>>>>>>> Validate phone no
    //
    if (verifyPhoneNumber(phoneNo) == false) {
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
      await verifyPhone(updatedPhoneNo, context);
      logger.wtf("Why the fuck are you running_?");
      if (newUserResult != null) {
        logger.i(
            "Updated the data in databse - IF ___________________________________" +
                newUserResult.toString());

        await DatabaseService(uid: newUserResult).updateCustData({
          'custPhNo': updatedPhoneNo,
        });
        setState(ViewState.Idle);
        return true;
      } else {
        logger.i(
            "Updated the data in databse - ELSE ___________________________________" +
                newUserResult.toString());
        errorMessage =
            "   Something went wrong while\n   verification. Please try again";
        setState(ViewState.Idle);
        return false;
      }
    }
  }

  /// Below function will return the userID upon successfull phone verification
  // ignore: missing_return
  Future<dynamic> verifyPhone(phoneNo, context) async {
    print("‎ Verify Phone reached __________________");
    String smsCode;

    Future<String> getOTPresult() async {
      logger.i("Dialog shown");

      var dialogResult =
          await _dialogService.showDialog(dialogType: Dialog_Types.OTP);

      return dialogResult.userText;
    }

    //
    //  >>>>>>>>>>>>> On verification complete
    //
    final PhoneVerificationCompleted verificationComplete =
        (AuthCredential authCred) async {
      // AuthResult newUserResult =
      //     await FirebaseAuth.instance.signInWithCredential(authCred);
      // FirebaseUser user = newUserResult.user;
      // User(uid: user.uid);

      newUserResult = await _authService.signInWithPhoneNumber(authCred);
      logger.wtf("Why the fuck are you running?");
      if (newUserResult != null) {
        print("Phone no is : " + phoneNo);
        print("__Result: " + newUserResult.toString());
        print("AuthCredential : _______ " + authCred.toString());

        // --- Proceeding to screen 2 of chef registration
        setState(ViewState.Idle);
      }
    };
    //
    ///  >>>>>>>>>>>>> On Timeout
    //
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
      print("\n2. Auto retrieval time out");
      setState(ViewState.Idle);
    };

    // >>>>>>>>>>>>>  On manual code verification

    final PhoneCodeSent smsCodeSent =
        (String verID, [int forceCodeResend]) async {
      print(" --------------> Code sent reached ");
      // ignore: non_constant_identifier_names
      var OTPDialogResult = await getOTPresult();

      AuthCredential authCred = PhoneAuthProvider.getCredential(
          verificationId: verID, smsCode: OTPDialogResult);
      logger.d("SMS code sent reached OTP is : " + OTPDialogResult.toString());
     
      newUserResult = await AuthService().signInWithPhoneNumber(authCred);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('${AuthException(smsCode, "message")}');

      if (authException.message.contains('not authorized'))
        UIHelper().showErrorButtomSheet(context, '   App not authroized');
      else if (authException.message.contains('Network'))
        UIHelper().showErrorButtomSheet(context,
            '   Please check your internet \n    connection and try again ');
      else
        UIHelper().showErrorButtomSheet(
            context, '   Something has gone wrong, \n    Please try later ');
      print('Something has gone wrong, please try later ' +
          authException.message);
      setState(ViewState.Idle);
    };

    await FirebaseAuth.instance
        .verifyPhoneNumber(
          phoneNumber: phoneNo,
          timeout: Duration(seconds: 50),
          verificationCompleted: verificationComplete,
          verificationFailed: verificationFailed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: autoRetrieve,
        )
        .then((value) =>
            logger.d("then newuser Reslut: " + newUserResult.toString()))
        .catchError((error) {
      print(error.toString());
    });

    logger.wtf("New user result at the end : " + newUserResult.toString());
  }

  //
  // >>>>>>>>> S I G N   I N   W I T H   P H O M E  N U M B E R   P R O C E S S
  //

  /// Below function will return the userID upon successfull phone verification
  // ignore: missing_return
  // Future<String> verifyPhone(phoneNo, context) async {
  //  // final deviceSize = MediaQuery.of(context).size;
  //   print("‎ Verify Phone reached __________________");
  //   String smsCode;
  //   dynamic newUserResult;
  //   print("object");
  //   //
  //   //  >>>>>>>>>>>>> On verification complete
  //   //
  //   final PhoneVerificationCompleted verificationComplete =
  //       (AuthCredential authCred) async {
  //     newUserResult = await AuthService().signInWithPhoneNumber(authCred);

  //     if (newUserResult != null) {
  //       print("Phone no is : " + phoneNo);
  //       print("__Result: " + newUserResult.toString());
  //       print("AuthCredential : _______ " + authCred.toString());

  //       // --- Proceeding to screen 2 of chef registration
  //       setState(ViewState.Idle);
  //       return newUserResult;
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
  //   PhoneCodeSent smsCodeSent = (String verID, [int forceCodeResend]) async  {

  //     print("SMS code Sent reached ____________");
  //     String smsCode =  UIHelper().showOTPDialog(
  //         context); // <--- Show OTP dialog and return entered otp value

  //     AuthCredential authCred = PhoneAuthProvider.getCredential(
  //         verificationId: verID, smsCode: smsCode);
  //     newUserResult = await AuthService().signInWithPhoneNumber(authCred);

  //     setState(ViewState.Idle);
  //     return newUserResult;
  //   };

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
  //     phoneNumber: phoneNo,
  //     timeout: Duration(seconds: 50),
  //     verificationCompleted: verificationComplete,
  //     verificationFailed: verificationFailed,
  //     codeSent: smsCodeSent,
  //     codeAutoRetrievalTimeout: autoRetrieve,
  //   )
  //       .catchError((error) {
  //     print("Error in FirebaseAuth.instance.verifyPhoneNumber: " +
  //         error.toString());
  //   });
  //   print("Returning newUserResult: " + newUserResult.toString());
  //   return newUserResult;
  // }
}
