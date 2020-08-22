import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class CheckProfileViewModel extends BaseViewModel {
  Future<dynamic> userTypeIs(String userID) async {
    String user = await DatabaseService().checkUserID(userID);
    // setState(ViewState.Busy);
    print("Check User ID result: " + user.toString());
    // setState(ViewState.Busy);
    return user;
  }
}
