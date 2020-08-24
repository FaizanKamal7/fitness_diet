import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  gotToCustSignIn() {
    _navigationService.navigateTo(routes.CustSignRoute);
  }

  gotToChefSignIn() {
    _navigationService.navigateTo(routes.ChefSignRoute);
  }

  gotToFoodMenu() {
    _navigationService.navigateTo(routes.FoodMenuRoute);
  }

  Future redirectSignedInUser(String userID) async {
    // setState(ViewState.Busy);
    String user = await DatabaseService().checkUserID(userID);

    if (user.toString() == "cust") {
      print("user form inside the HomeViewModel: " + user.toString());
      _navigationService.navigateTo(routes.FoodMenuRoute);
    } else if (user.toString() == "chef") {
      print("user form inside the HomeViewModel: " + user.toString());
      _navigationService.navigateTo(routes.ChefProfileRoute);

      print("Check User ID result: " + user.toString());
    }
    // setState(ViewState.Idle);
  }
}
