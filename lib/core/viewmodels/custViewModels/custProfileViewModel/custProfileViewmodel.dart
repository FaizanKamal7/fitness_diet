import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;

class CustProfileViewModel extends BaseViewModel {
  // CustData _custData;
  final NavigationService _navigationService = locator<NavigationService>();

  // Future <CustData> fetchCustData(String userID) async{

  //    Stream xyz =   DatabaseService(uid: userID).getCustData,

  //     // stream: ,
  //     // builder: (context, snapshot) {
  //     //   if (snapshot.hasData && !snapshot.hasError) {
  //     //     _custData = snapshot.data;
  //     //     return _custData;
  //     //   }
  //     // },

  //   // Stream<CustData> fetchData(String userID) {
  //   //   setState(ViewState.Busy);

  //   //   Stream<CustData> custData = DatabaseService(uid: userID).getCustData;
  //   //   setState(ViewState.Idle);
  //   //   print("Custdata from Stream: " + custData.toString());
  //   //   return custData;
  //   // }
  // }

  goToStartPlan() {
    print('fuck you control is in there ');
    _navigationService.navigateTo(routes.CustStartPlanRoute);
  }
}
