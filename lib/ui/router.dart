import 'package:fitness_diet/ui/views/chefViews/authVIews/chefRegView_1.dart';
import 'package:fitness_diet/ui/views/chefViews/authVIews/chefRegView_2.dart';
import 'package:fitness_diet/ui/views/chefViews/authVIews/chefSignInView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile.dart';
import 'package:fitness_diet/ui/views/custViews/authViews/custRegView_1.dart';
import 'package:fitness_diet/ui/views/custViews/authViews/custRegView_2.dart';
import 'package:fitness_diet/ui/views/custViews/authViews/custSignInView.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/foodMenuView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custProfile.dart';
import 'package:fitness_diet/ui/views/homeview.dart';
import 'package:fitness_diet/ui/views/splashView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custProfileMain.dart';
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
      case 'custReg_1':
        return MaterialPageRoute(builder: (_) => CustRegView_1());
      case 'custReg_2':
        return MaterialPageRoute(builder: (_) => CustRegView_2());
      case 'custSignIn':
        return MaterialPageRoute(builder: (_) => CustSigninView());
      case 'cust':
        return MaterialPageRoute(builder: (_) => FoodMenuView());
      case 'foodMenu':
        return MaterialPageRoute(builder: (_) => FoodMenuView());
      case 'custProfile':
        return MaterialPageRoute(builder: (_) => CustProfile());

      // Chef Routes
      case 'chefReg_1':
        return MaterialPageRoute(builder: (_) => ChefRegView_1());
      case 'chefReg_2':
        return MaterialPageRoute(builder: (_) => ChefRegView_2());
      case 'chefSignIn':
        return MaterialPageRoute(builder: (_) => ChefSignInView());
      case 'chefProfile':
        return MaterialPageRoute(builder: (_) => ChefProfile());
      case 'parent':
        return MaterialPageRoute(builder: (_) => CustProfileMain());
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
