import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser

  User _userFormFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user => _auth.onAuthStateChanged.map(_userFormFirebaseUser);

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFormFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  // Future registorWithEmailAndPassword(String email, String password) async {
  //   try {
  //     AuthResult result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     FirebaseUser user = result.user;

  //     // Create a new document for the user with the uid
  //     await DatabaseService(uid: user.uid)
  //         .updateCustData("Default name", "Default residence");
  //     return _userFormFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
  // Sign up

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // ------------------------------------------------------ S I G N   I N   W I T H   P H O M E  N U M B E R

  Future signInWithPhoneNumber(AuthCredential authCreds) async {
    try {
      AuthResult result = await _auth.signInWithCredential(authCreds);
      FirebaseUser user = result.user;

      if (user != null) {
        print('AUTHENTICATONI SUCCESSFULL. Id: ' + user.uid);

        //
        // Storing user logged-in status for re-launch
        //
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('userID', _userFormFirebaseUser(user).uid);
        // prefs.setBool('isLoggedIn', true);

        return _userFormFirebaseUser(user).uid;
      } else {
        print('Invalid code/invalid authentication');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signInWithOTP(smsCode, verId) {
  //   AuthCredential authCreds = PhoneAuthProvider.getCredential(
  //       verificationId: verId, smsCode: smsCode);
  //   signInWithPhoneNumber(authCreds);
  // }
}

// ----------------------:::::::|||||||| Useless Comments

//   //
//   // >>>>>>>>> S I G N   I N   W I T H   P H O M E  N U M B E R   P R O C E S S
//   //
//   Future<bool> verifyPhone(phNo, codeSent, verificationID, smsCode) async {

//     final PhoneVerificationCompleted verificationComplete =
//         (AuthCredential authResult) {
//       print('1. Auto retrieving verification code');
//       AuthService().signInWithPhoneNumber(authResult);
//     };

//     final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
//       verificationID = verID;
//       print("\n2. Auto retrieval time out");
//       return false;
//     };

//     final PhoneCodeSent smsCodeSent =
//         (String verID, [int forceCodeResend]) async {
//       verificationID = verID;
//       print("\n 3. Code Sent to " + phNo);
//       codeSent = true;
//       ChefRegisterScreen.getCodeSentStatus(codeSent);
//     };

//     final PhoneVerificationFailed verificationFailed =
//         (AuthException authException) {
//       print('${AuthException(smsCode, "message")}');
//       if (authException.message.contains('not authorized'))
//         print('App not authroized');
//       else if (authException.message.contains('Network'))
//         print('Please check your internet connection and try again');
//       else
//         print('Something has gone wrong, please try later ' +
//             authException.message);
//       return false;
//     };

//     await FirebaseAuth.instance
//         .verifyPhoneNumber(
//       phoneNumber: phNo,
//       timeout: Duration(seconds: 50),
//       verificationCompleted: verificationComplete,
//       verificationFailed: verificationFailed,
//       codeSent: smsCodeSent,
//       codeAutoRetrievalTimeout: autoRetrieve,
//     )
//         .then((value) {
//       print('PHONE VERIFIED. RETURNING TRUE');
//       return true;
//     }).catchError((error) {
//       print(error.toString());
//     });
//     return false;
//   }
// }

// Sign in anom
// Future signInAnom() async {
//   try {
//     AuthResult result = await _auth.signInAnonymously();
//     FirebaseUser user = result.user;
//     return _userFormFirebaseUser(user);
//   } catch (e) {
//     print(e.toString());
//     return null;
//   }
// }
// Create a new document for the user with the uid
// await DatabaseService(uid: user.uid)
//     .updateChefData("chefName", "chefPhNo", "chefDateOfBirth");
//   await DatabaseService(uid: user.uid).updateChefData(
//     ChefRegisterScreen().getChefName(),
//     ChefRegisterScreen().getChefPhNo(),
//     ChefRegisterScreen().getChefDateOfBirth(),
//  //   ChefData().chefName, ChefData().chefPhNo, ChefData().chefDateOfBirth,
//   );
// globals.isLoggedIn = true;
// print("globals.isLoggedIn : " + globals.isLoggedIn.toString());
// // Constants().getLoginStatus().then((result) => print(
//     "Constants().setLoginStatus(true) in AUTH Before: " +
//         result.toString()));

// Constants().setLoginStatus(true);

// Constants().getLoginStatus().then((result) => print(
//     "Constants().setLoginStatus(true) in AUTH After: " +
//         result.toString()));
