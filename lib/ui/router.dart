import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/ui/views/chefViews/authVIews/chefRegView_1.dart';
import 'package:fitness_diet/ui/views/chefViews/authVIews/chefRegView_2.dart';
import 'package:fitness_diet/ui/views/chefViews/authVIews/chefSignInView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefProfile.dart';
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

const String initialRoute = routes.SplashRoute;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routes.HomeRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
      case routes.SplashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());

      // Customer Routes
      case routes.CustReg1Route:
        return MaterialPageRoute(builder: (_) => CustRegView_1());
      case routes.CustReg2Route:
        return MaterialPageRoute(builder: (_) => CustRegView_2());
      case routes.CustSignRoute:
        return MaterialPageRoute(builder: (_) => CustSigninView());
      case routes.FoodMenuRoute:
        return MaterialPageRoute(builder: (_) => FoodMenuView());
      case routes.CusProfileRoute:
        return MaterialPageRoute(builder: (_) => CustProfile());

      // Chef Routes
      case routes.ChefReg1Route:
        return MaterialPageRoute(builder: (_) => ChefRegView_1());
      case routes.ChefReg2Route:
        return MaterialPageRoute(builder: (_) => ChefRegView_2());
      case routes.ChefSignRoute:
        return MaterialPageRoute(builder: (_) => ChefSignInView());
      case routes.ChefProfileRoute:
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
