import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:intl/intl.dart';

class CustInfoViewModel extends BaseViewModel {
  String parseDate(DateTime firebasedate) {
    var newFormat = DateFormat("dd-MMM-yyyy");
    return newFormat.format(firebasedate);
  }

  void removeAddress(String custID, String title) {
    print('********** inside remove address in profile view model :');
    DatabaseService().removeCustAddress(custID, title);
  }
}
