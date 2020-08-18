import 'package:device_preview/device_preview.dart';
import 'package:fitness_diet/core/managers/dialogManager.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  // runApp(MyApp());
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      create: (BuildContext context) => locator<AuthService>().user,
      child: MaterialApp(
        locale: DevicePreview.of(context).locale, // <--- Add the locale
        builder: (context, widget) => Navigator(
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
              child: widget,
            ),
          ),
        ),
        //  builder: DevicePreview.appBuilder, // To be commented
        title: 'Fitness Diet',
        theme: ThemeData(),
        initialRoute: 'splash',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
