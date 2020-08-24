import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  String _errorMessage;
  ViewState get state => _state;
 // final NavigationService navigationService = locator<NavigationService>();

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  String get errorMessage => _errorMessage;
  bool get hasErrorMessage => _errorMessage != null && _errorMessage.isNotEmpty;
  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  FirebaseUser baseUser;

  Future<String> get getUser async {
    baseUser = await FirebaseAuth.instance.currentUser();
    return baseUser.uid;
  }

//  dynamic x = AuthService().user;

  // void setUser(String user) {
  //   _userID = user;
  //   notifyListeners();
  // }

}
