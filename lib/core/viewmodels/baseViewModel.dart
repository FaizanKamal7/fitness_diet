import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
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
