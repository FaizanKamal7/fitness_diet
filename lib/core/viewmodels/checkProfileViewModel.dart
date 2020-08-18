import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class CheckProfileViewModel extends BaseViewModel {
  dynamic userID;
  CheckProfileViewModel({this.userID});

  Future<dynamic> userTypeIs(String userID) async {
    String user = await DatabaseService().checkUserID(userID);
    print("Check User ID result: " + user.toString());
    return user;
  }
}
