import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';

class ChefDishesViewmodel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  gotTodishMenu() {
    _navigationService.navigateTo(routes.SoleDishRoute);
  }
}
