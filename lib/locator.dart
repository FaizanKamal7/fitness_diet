import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/auth/chefReg2ViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/auth/chefRegViewModel.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/auth/chefSignInViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/auth/custReg2ViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/auth/custRegViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/auth/custSignInViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custAppDrawerViewModel.dart';
import 'package:fitness_diet/core/viewmodels/homeViewModel.dart';
import 'package:fitness_diet/core/viewmodels/loginViewModel.dart';
import 'package:get_it/get_it.dart';

import 'core/viewmodels/custViewModels/custProfileViewModel/custProfileViewmodel.dart';

GetIt locator = GetIt.instance;

// * This is where we register all our services and models
void setupLocator() {
  // * Lazy -  There will be only one instance of the service and
  //           will only be created once the service is required for the first time

  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  // locator.registerLazySingleton(() => Api());

  locator.registerFactory(() => LoginViewModel());

  locator.registerFactory(() => HomeViewModel());

  // Customer
  locator.registerFactory(() => CustRegViewModel());
  locator.registerFactory(() => CustReg2ViewModel());
  locator.registerFactory(() => CustSignInViewModel());
  locator.registerFactory(() => CustProfileViewModel());
  locator.registerFactory(() => CustAppDrawerViewModel());

  // Chef
  locator.registerFactory(() => ChefRegViewModel());
  locator.registerFactory(() => ChefReg2ViewModel());
  locator.registerFactory(() => ChefSignInViewModel());
}
