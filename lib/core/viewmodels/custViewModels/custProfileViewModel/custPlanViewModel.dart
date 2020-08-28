import 'dart:ffi';

import 'package:age/age.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/services/validators.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';

class CustPlanViewModel extends BaseViewModel {
  String errorMessage;

  startPlan(String gender, String custheight, String custWeight,
      String custgoalWeight, DateTime dateOfBirth, double activityLevel) {
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

    } else {
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
        'custReqKcl': reqkcal.toStringAsFixed(3),
        'custReqProtein': regMacroNutrients.elementAt(0).toStringAsFixed(3),
        'custReqFats': regMacroNutrients.elementAt(1).toStringAsFixed(3),
        'custReqCarbs': regMacroNutrients.elementAt(2).toStringAsFixed(3),
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
      return 1;
    } else {
      return -1;
    }
  }

// CALCULATE TIME TO ACHIVE GOAL

  double timeToAchiveGoal(double currentweight, double goalWEight) {
    double goalDifference = goalWEight = currentweight;

    return goalDifference / 0.4;
  }

// W E I G H T --- L  O  S  S  -- C   A   L  C  U  L  A  T  I  O  N
//

  double tDEEValueToloseWeight(double tdeeValue) {
    double tdeedeficit = tdeeValue * 0.20;
    return tdeeValue - tdeedeficit;
  }

  // W E I G H T --- L  O  S  S  -- C   A   L  C  U  L  A  T  I  O  N
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
}

// String userID = await getUser;
// bool dataValidated;
// print("height " + height.toString());

// print("weight " + weight.toString());

// print("goalweight " + goalweight.toString());
// setState(ViewState.Busy);
// Validators().verifySmallNumberField(height) &&
//         Validators().verifySmallNumberField(weight) &&
//         Validators().verifySmallNumberField(goalweight)
//     ? dataValidated = true
//     : dataValidated = false;

// if (dataValidated) {
//   print(
//       "data is validated and is about to upload --------------User().getUid: " +
//           userID);
//   DatabaseService(uid: userID).addPlanData(
//     ({
//       'custGender': gender,
//       'custHeight': height,
//       'custWeight': height,
//       'custGoalWeight': height,
//     }),
//   );
//   setState(ViewState.Idle);
//   return true;
// } else {
//   errorMessage = "   Registration failed\n   Add valid info";
//   print(errorMessage);
//   setState(ViewState.Idle);

//   return false;
// }
