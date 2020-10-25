import 'package:fitness_diet/core/models/exercise.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custPlanViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../../../baseView.dart';

class AddMealView extends StatefulWidget {
  @override
  _AddMealViewState createState() => _AddMealViewState();
}

var _controller = TextEditingController();
String selectedValue;

class _AddMealViewState extends State<AddMealView> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _exerciseData = Provider.of<List<Exercise>>(context);
    final _planData = Provider.of<Plan>(context);

    return BaseView<CustPlanViewModel>(
        builder: (context, model, child) => Scaffold(
              body: Stack(
                children: [
                  Container(
                    height: deviceSize.height * 0.2,
                    width: double.infinity,
                    color: Colors.pinkAccent,
                    child: Center(
                      child: Container(
                        width: deviceSize.width * 0.9,
                        height: deviceSize.height * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(deviceSize.height * 0.05))),
                        child: SearchableDropdown.single(
                          value: selectedValue,
                          hint: "Select Exercise",
                          searchHint: "Select Exercise",
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                              print("Selected value is : $selectedValue");
                            });
                          },
                          isExpanded: true,
                          items: _exerciseData.map((value) {
                            print(
                                "---> Inside _productsList.map and value  : " +
                                    value.toString() +
                                    " and pic : " +
                                    value.exerciseName.toString());
                            return DropdownMenuItem<String>(
                              value: value.exerciseName,
                              child: Card(
                                margin:
                                    EdgeInsets.all(deviceSize.height * 0.03),
                                child: Container(
                                  color: Color(0xffFFFBF3),
                                  padding:
                                      EdgeInsets.all(deviceSize.height * 0.03),
                                  child: InkWell(
                                    onTap: () {
                                      print('ink well pressed go to solo ');

                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => AddMealSolo(
                                      //       selectedExercise: value,
                                      //     ),
                                      //   ),
                                      // );
                                      // Navigator.of(context).pop();
                                    },
                                    child: ListTile(
                                      // leading: CircleAvatar(
                                      //   backgroundImage: NetworkImage(
                                      //       "https://firebasestorage.googleapis.com/v0/b/storeifie-e72e3.appspot.com/o/images%2F20-09-23%3A36%3A81.png?alt=media&token=6f622754-994f-47ed-b683-d3c3c673f444"),
                                      // ),
                                      subtitle: Text('30 minutes'
                                          // model
                                          //   .getExerciseCalories(
                                          //       _planData.custWeight, value)
                                          //   .toString()
                                          ),
                                      title: Text(
                                        value.exerciseName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  // Center(
                  //   child: Text(
                  //     _exerciseData[1].exerciseName,
                  //   ),
                  // )
                ],
              ),
            ));
  }
}
