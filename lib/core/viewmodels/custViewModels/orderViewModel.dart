import 'package:fitness_diet/core/models/dish.dart';
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
      String cartID) async {
    print('----> inside create order   in orderview model...');

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
  }

  String getShefID(String dishID, List<Dish> allDishes) {
    for (int i = 0; i <= allDishes.length; i++) {
      if (dishID == allDishes[i].dishID) {
        return allDishes[i].chefID;
      }
    }
  }
}
