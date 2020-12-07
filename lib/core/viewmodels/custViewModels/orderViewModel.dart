import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import '../../../locator.dart';

class OrderViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  goToSignIn() {
    _navigationService.navigateToWithoutReplacement(routes.HomeRoute);
  }

  Future<String> createOrder(
    String custID,
    String custName,
    Map<String, dynamic> shippAddress,
    String phoneNO,
    List orderStatus,
    Map<String, dynamic> items,
    List<Dish> allDishes,
    double total,
    String cartID,
    Plan custPlan,
  ) async {
    print('----> inside create order   in orderview model...' +
        allDishes.length.toString());
    if (shippAddress != null) {
      //-------------------------------- UPDATING EATEN NUTRITIENTS
      //
      List<double> nutritientslist =
          calculateEatenNutritients(items, allDishes);
      // double eatenKcl = calculateEatenCalories(items, allDishes);
      // double eatenProtein = calculateEatenProtein(items, allDishes);
      // double eatenfats = calculateEatenFats(items, allDishes);
      // double eatenCarbs = calculateEatenCarbs(items, allDishes);
      if (custPlan != null) {
        print('------------------- eaten calories ' +
            nutritientslist[0].toString());
        Map<String, dynamic> planData = {};
        planData.addAll(
            {"custEatenKcal": (nutritientslist[0] + custPlan.custEatenKcal)});
        planData.addAll(
          {
            "custEatenProtein":
                (nutritientslist[1] + custPlan.custEatenProtein),
          },
        );
        planData.addAll(
          {
            "custEatenFats": (nutritientslist[2] + custPlan.custEatenFats),
          },
        );
        planData.addAll(
          {
            "custEatenCarbs": (nutritientslist[3] + custPlan.custEatenCarbs),
          },
        );

        DatabaseService().updatePLanData(planData, custPlan.planID);

        items.forEach((key, value) {
          Dish dish = getDishData(key, allDishes);
          DatabaseService().updateCustMeals(
              custPlan.planID, dish.dishName, dish.dishKcal.toString());
        });
      }

      /// ------>   C  R  E  A   T  I  N  G -- O  R  D  E   R
      ///
      ///
      String chefID = getShefID(items.keys.elementAt(0), allDishes);

      String orderId = await DatabaseService().createOrder(custID, custName,
          chefID, shippAddress, phoneNO, orderStatus, items, total);

      /// ------------> D  E  L  E  T  I  N  G  -- C  A  R  T  -- I  T  E  M
      ///

      DatabaseService().deleteallCartItems(cartID, items);

      return orderId;
    } else {
      setErrorMessage("    Add address first");
      return '';
    }
  }

  Dish getDishData(String dishID, List<Dish> allDishes) {
    for (int i = 0; i < allDishes.length; i++) {
      if (dishID == allDishes[i].dishID) {
        return allDishes[i];
      }
    }
  }

  String getShefID(String dishID, List<Dish> allDishes) {
    for (int i = 0; i <= allDishes.length; i++) {
      if (dishID == allDishes[i].dishID) {
        return allDishes[i].chefID;
      }
    }
  }

  List<double> calculateEatenNutritients(
    Map<String, dynamic> items,
    List<Dish> allDishes,
  ) {
    print('----> inside calculateCalories   in orderview model...' +
        items.length.toString());

    double kcalofOrder = 0;
    double proteinofOrder = 0;
    double fatsofOrder = 0;
    double carbsofOrder = 0;

    // for (int i = 0; i <= 9; i++) {
    // items.forEach((key, value) {
    //   if (key == allDishes[i].dishID) {
    //     kcalofOrder += double.parse(allDishes[i].dishKcal);
    //   }
    // });

    // }
    items.forEach((key, value) {
      for (int i = 0; i < allDishes.length; i++) {
        if (key == allDishes[i].dishID) {
          print('----------------inside for loop ' +
              allDishes[i].dishCarb.toString());
          kcalofOrder = kcalofOrder + allDishes[i].dishKcal;
          proteinofOrder = proteinofOrder + allDishes[i].dishProtein;
          fatsofOrder = fatsofOrder + allDishes[i].dishFat;
          carbsofOrder = carbsofOrder + allDishes[i].dishCarb;
        }
      }
    });
    print('----> inside calculateCalories   in orderview model...' +
        kcalofOrder.toString());

    List<double> nutritientslist = [
      kcalofOrder,
      proteinofOrder,
      fatsofOrder,
      carbsofOrder
    ];
    return nutritientslist;
  }
}
