import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    print("---------> Navigation Service reached and navigating to  : " +
        routeName.toString());
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
