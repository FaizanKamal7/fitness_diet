import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/DatabaseServices/dbHelperFtns.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class ChefDishesViewmodel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  var _currentUser;

  Future getChefName(String _chefID) async {
    String _chefName = await DBHelperFtns().documentIDToName(
        DatabaseService().chefCollection, "chefID", "chefName", _chefID);
    return _chefName;
  }

  Future isDishAvalaible() async {
    setState(ViewState.Busy);
    _currentUser = await getUser;
    bool _chefHaveDishes = await DBHelperFtns().feildExistInCollection(
        DatabaseService().dishCollection, "chefID", _currentUser);
    setState(ViewState.Idle);
    return _chefHaveDishes;
  }

  gotTodishMenu() {
    _navigationService.navigateTo(routes.SoleDishRoute);
  }
}
