import 'package:fitness_diet/ui/views/chefViews/authVIews/chefSignInView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile.dart';
import 'package:fitness_diet/ui/views/custViews/authViews/custRegView_1.dart';
import 'package:fitness_diet/ui/views/custViews/authViews/custRegView_2.dart';
import 'package:fitness_diet/ui/views/custViews/authViews/custSignInView.dart';
import 'package:fitness_diet/ui/views/foodMenuView.dart';
import 'package:fitness_diet/ui/views/homeview.dart';
import 'package:fitness_diet/ui/views/splashView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const String initialRoute = "splash";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'splash':
        return MaterialPageRoute(builder: (_) => SplashView());

      // Customer Routes
      case 'custHome':
        return MaterialPageRoute(builder: (_) => CustSigninView());
      case 'custReg_1':
        return MaterialPageRoute(builder: (_) => CustRegView_1());
      case 'custReg_2':
        return MaterialPageRoute(builder: (_) => CustRegView_2());
      case 'custSignIn':
        return MaterialPageRoute(builder: (_) => CustSigninView());
      case 'cust':
        return MaterialPageRoute(builder: (_) => FoodMenuView());

      // Chef Routes
      case 'chefHome':
        return MaterialPageRoute(builder: (_) => ChefSignInView());

      // case 'post':
      //   var post = settings.arguments as Post;
      //   return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
