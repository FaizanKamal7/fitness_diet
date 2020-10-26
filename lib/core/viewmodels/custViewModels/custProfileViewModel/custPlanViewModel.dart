import 'package:age/age.dart';
import 'package:fitness_diet/core/constants/route_paths.dart' as routes;
import 'package:fitness_diet/core/datamodel/alert_response.dart';
import 'package:fitness_diet/core/enums/dialogTypes.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/exercise.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/services/navigationService.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:intl/intl.dart';

class CustPlanViewModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  double _weightDifference;
  String errorMessage;
  final NavigationService _navigationService = locator<NavigationService>();
  startPlan(String gender, String custheight, String custWeight,
      String custgoalWeight, DateTime dateOfBirth, double activityLevel) async {
    print('function reached........................');
    print('gender........................' + gender);
    print('height........................' + custheight);
    print('weight........................' + custWeight);
    print('goal weight........................' + custgoalWeight);
    print('date of birth ........................' + dateOfBirth.toString());
    print('activity level ........................' + activityLevel.toString());
    bool dataValidated;

    Validators().verifySmallNumberField(custheight) &&
            Validators().verifySmallNumberField(custWeight) &&
            Validators().verifySmallNumberField(custgoalWeight)
        ? dataValidated = true
        : dataValidated = false;

    if (dataValidated) {
      double height = double.parse(custheight);
      double weight = double.parse(custWeight);
      double goalWeight = double.parse(custgoalWeight);
      int age = ageCalculator(dateOfBirth);
      List<double> reqmacroNutrients;
      // print('age is *************' + age.toString());

      // B   M  R  CALCULATED  ***********
      // TDEE IS TOTAL DAILY ENERGY EXPENDACTURE
      //

      double tdee = calculateBMR(age, gender, convertToPounds(weight),
          convertToInches(height), activityLevel);
      int currentTdee = tdee.round();
      int check = checkGoal(weight, goalWeight);
      print('TDEE calculated is *********************:' + tdee.toString());

      if (check == 0) {
        print('user want to mantain weight');
        // TDEE IS THE DAILY CALORIES RECOMENDATION
        print(
            'Daily calories need for mantaining weight is ' + tdee.toString());

        reqmacroNutrients = calculateMacronutrients(tdee);
      } else if (check == 1) {
        // IF GOAL IS  TO GAIN WEIGHT

        // print('user want to gain weight');
        // print('Daily calories need for gaining ' +
        //     (goalWeight - weight).toString() +
        //     ' weight is ' +
        //     tDEEValueToGainWeight(tdee).toString());
        tdee = tDEEValueToGainWeight(tdee);
        reqmacroNutrients = calculateMacronutrients(tdee);

        print('list of protein carbs and fats ' +
            calculateMacronutrients(2392).toList().toString());
      } else {
        // IF GOAL IS TO LOSE WEIGHT

        // print('user want to lose weight');
        // print('Daily calories need for losing  ' +
        //     (goalWeight - weight).toString() +
        //     ' weight is ' +
        //     tDEEValueToloseWeight(tdee).toString());

        // print('list of protein carbs and fats ' +
        //     calculateMacronutrients(2392).toList().toString());
        tdee = tDEEValueToloseWeight(tdee);
        reqmacroNutrients = calculateMacronutrients(tdee);
      }

      // upload data function call
      uploadData(gender, height, weight, goalWeight, tdee, reqmacroNutrients);
      //
      //
      String _custGoal;
      if (check == 0) _custGoal = " maintain ";
      if (check == 1)
        _custGoal = " gain " + _weightDifference.toString() + ' Kg';
      if (check == -1)
        _custGoal = " loss " + _weightDifference.toString() + 'Kg';

      var dialogResult = await _dialogService.showDialog(
          title: "You've set a new goal! ",
          description:
              "Your current Calories consumption is $currentTdee \n You need to consume " +
                  tdee.round().toString() +
                  " calories daily  to $_custGoal weight in " +
                  timeToAchiveGoal(weight, goalWeight) +
                  " Weeks. \n Best of Luck ",
          buttonTitle: "Lets go",
          dialogType: Dialog_Types.PLAN_SUCCESS);

      print("--------> AlertResponse().confirmed inside CustPlanViewModel : " +
          AlertResponse().confirmed.toString());

      if (dialogResult.confirmed == true)
        _navigationService.navigateTo(routes.CustProfileRoute);
    } else {
      setErrorMessage(' Invalid data in height and weight ');
      print('invalid data in height and weight *****************************');
    }
  }

//**************************************** U  P  L   O  A  D --   D  A  T  A */
  Future uploadData(String gender, double height, double weight,
      double goalWeight, double reqkcal, List<double> regMacroNutrients) async {
    String userID = await getUser;

    print('inside plan data upload function ****************************');
    setState(ViewState.Busy);

    DatabaseService(uid: userID).addPlanData(
      ({
        'custGender': gender,
        'custHeight': height,
        'custWeight': weight,
        'custGoalWeight': goalWeight,
        'custReqKcl': double.parse(reqkcal.toStringAsFixed(3)),
        'custReqProtein':
            double.parse(regMacroNutrients.elementAt(0).toStringAsFixed(3)),
        'custReqFats':
            double.parse(regMacroNutrients.elementAt(1).toStringAsFixed(3)),
        'custReqCarbs':
            double.parse(regMacroNutrients.elementAt(2).toStringAsFixed(3)),
      }),
    );

    setState(ViewState.Idle);
  }

//************************** */

// A  G  E  ----C  A  L  C  U  L A  T  O  R ******************
//
//
  int ageCalculator(DateTime dateOfBirth) {
    int age;

    // Find out your age
    return age = Age.dateDifference(
            fromDate: dateOfBirth, toDate: DateTime.now(), includeToDate: false)
        .years;
  }

// B  M  R   ----C  A  L  C  U  L A  T  O  R ******************
//
//
  double calculateBMR(int age, String gender, double bodyWeight,
      double bodyHeight, double activityLevel) {
    print('inslide Calculating BMR function**************');
    double bmr;
    if (gender == 'Male') {
      bmr = ((6.23 * bodyWeight) + (12.7 * bodyHeight)) - (age * 6.8) + 66;

      print('bmr withot activity level ' + bmr.toString());
      bmr = bmr * activityLevel;

      return bmr;
    } else {
      bmr = ((4.35 * bodyWeight) + (4.7 * bodyHeight)) - (30 * 4.7) + 655;

      print('bmr withot activity level ' + bmr.toString());

      bmr = bmr * activityLevel;

      return bmr;
    }
  }

// B A S I C C O N V E R S I O N
//

  double convertToPounds(double weightInkG) {
    return weightInkG * 2.20462;
  }

  double convertToInches(double heightInCM) {
    return heightInCM * 0.393701;
  }

//////////////////
//
// C H E C K -- G  O  A  L
//

  int checkGoal(double currentWeight, double goalweight) {
    if (goalweight == currentWeight) {
      return 0;
    } else if (goalweight > currentWeight) {
      _weightDifference = goalweight - currentWeight;
      return 1;
    } else {
      _weightDifference = currentWeight - goalweight;
      return -1;
    }
  }

// CALCULATE TIME TO ACHIVE GOAL

  String timeToAchiveGoal(double currentweight, double goalWEight) {
    double goalDifference = goalWEight - currentweight;
    double _timeToAcheive = goalDifference / 0.4;
    _timeToAcheive < 0 ? _timeToAcheive *= -1 : _timeToAcheive = _timeToAcheive;
    return _timeToAcheive.toStringAsFixed(1);
  }

// W E I G H T --- L  O  S  S  -- C   A   L  C  U  L  A  T  I  O  N
//

  double tDEEValueToloseWeight(double tdeeValue) {
    double tdeedeficit = tdeeValue * 0.20;
    return tdeeValue - tdeedeficit;
  }

  // W E I G H T --- G  A  I  N  -- C   A   L  C  U  L  A  T  I  O  N
//

  double tDEEValueToGainWeight(double tdeeValue) {
    double tdeedeficit = tdeeValue * 0.20;
    return tdeeValue + tdeedeficit;
  }

  //*********************  C A L C U L A T E ------------------- M   A  C  R  O  N  U  T  R  I  E  N  T  S  */

// returns value of macronutrients in grams
  List<double> calculateMacronutrients(double tdeeValue) {
    double protein = (tdeeValue / 3.230) / 4;

    double fats = (tdeeValue / 2.875) / 9;
    double carbs = (tdeeValue - (protein * 4 + fats * 9)) / 4;

    List<double> macronutrients = [protein, fats, carbs];

    return macronutrients;
  }

  double getProteinvalue(double tdeeValue) {
    return (tdeeValue / 3.230) / 4;
  }

  double getFatsValue(double tdeeValue) {
    return (tdeeValue / 2.875) / 9;
  }

  double getCarbsVlaue(double tdeeValue) {
    double protein = (tdeeValue / 3.230) / 4;

    double fats = (tdeeValue / 2.875) / 9;
    return (tdeeValue - (protein * 4 + fats * 9)) / 4;
  }

  goToStartPlan() {
    _navigationService.navigateTo(routes.CustStartPlanRoute);
  }

  //-------------------------- E  X  E  R  C  I  S  E
  //

  double getExerciseCalories(double custWeight, Exercise exercise) {
    double exerciseCalories = 0;

    if (custWeight >= 48 && custWeight < 59) {
      exerciseCalories = double.parse(exercise.weight_48_59);
    } else if (custWeight >= 59 && custWeight < 70) {
      exerciseCalories = double.parse(exercise.weight_59_70);
    } else if (custWeight >= 70 && custWeight < 82) {
      exerciseCalories = double.parse(exercise.weight_70_82);
    } else if (custWeight >= 82 && custWeight < 93) {
      exerciseCalories = double.parse(exercise.weight_82_93);
    } else if (custWeight >= 93 && custWeight < 104) {
      exerciseCalories = double.parse(exercise.weight_93_104);
    } else if (custWeight >= 104 && custWeight < 116) {
      exerciseCalories = double.parse(exercise.weight_104_116);
    } else if (custWeight >= 116 && custWeight < 127) {
      exerciseCalories = double.parse(exercise.weight_116_127);
    }

    return exerciseCalories / 60;
  }

  void addExercise(
    String planID,
    String exerciseName,
    String calories,
    String duration,
  ) {
    Map<String, dynamic> planData = {};
    double cal = double.parse(calories);
    planData.addAll({"custburntKcal": double.parse(cal.toStringAsFixed(2))});
    planData.addAll(
      {
        "custburntProtein":
            double.parse(getProteinvalue(cal).toStringAsFixed(2)),
      },
    );
    planData.addAll(
      {
        "custBurntFats": double.parse(getFatsValue(cal).toStringAsFixed(2)),
      },
    );
    planData.addAll(
      {
        "custBurntCarbs": double.parse(getCarbsVlaue(cal).toStringAsFixed(2)),
      },
    );

    DatabaseService().updatePLanData(planData, planID);
    print('------------ add exercise in plan view model  ');
    DatabaseService()
        .updateCustExercise(planID, exerciseName, calories, duration);
  }

  String formateDate(String date) {
    //--------- for displaying

    // var newFormat = DateFormat("dd-MM-yyyy");

    DateTime newDate = DateTime.parse(date);
// EEE,d,
    var newFormat = DateFormat("EEE,d, ");
    return newFormat.format(newDate);
    // 2020-10-25 08:03:18.068031
  }

  String formateDateForDifference(String date) {
    // var newFormat = DateFormat("dd-MM-yyyy");

    DateTime newDate = DateTime.parse(date);

    var newFormat = DateFormat("dd-MM-yyyy");
    // DateTime formatedDate = DateTime.parse(newFormat.format(newDate));
    return newFormat.format(newDate);
  }

// geting excercise list of the same day exercises
  Map<String, dynamic> getExerciseList(
    String day,
    Map<String, dynamic> exerciseList,
  ) {
    Map<String, dynamic> newList = {};
    exerciseList.forEach((key, value) {
      if (formateDateForDifference(key) == formateDateForDifference(day)) {
        newList[key] = value;
      }
    });
    return newList;
  }

  //geting count of slider

  int getUnigueDateCount(Map<String, dynamic> exerciseList) {
    int count = 0;
    if (exerciseList.length != 0) {
      count = 1;

      String previousdate = exerciseList.keys.elementAt(0);

      exerciseList.forEach((key, value) {
        if (formateDateForDifference(previousdate) ==
            formateDateForDifference(key)) {
        } else {
          count = count + 1;
        }
      });
    }
    return count;
  }
}
