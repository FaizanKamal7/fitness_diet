import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/viewmodels/checkProfileViewModel.dart';
import 'package:fitness_diet/core/viewmodels/custRegViewModel.dart';
import 'package:fitness_diet/core/viewmodels/homeViewModel.dart';
import 'package:fitness_diet/core/viewmodels/loginViewModel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

// * This is where we register all our services and models
void setupLocator() {
  // * Lazy -  There will be only one instance of the service and
  //           will only be created once the service is required for the first time

  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DialogService());
  // locator.registerLazySingleton(() => Api());

  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => CustRegViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => CheckProfileViewModel());

  // locator.registerFactory(() => CommentsModel());
}
