import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/auth/custReg2ViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/authHeader.dart';
import 'package:fitness_diet/ui/widgets/custAuthBg.dart';
import 'package:fitness_diet/ui/widgets/dateOfBirthSelector.dart';
import 'package:fitness_diet/ui/widgets/stepHeaderWithBg.dart';
import 'package:fitness_diet/ui/widgets/textFeildWithPrefix.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class CustRegView_2 extends StatelessWidget {
  DateTime dateOfBirth;
  final TextEditingController custPassContr = TextEditingController();
  final TextEditingController custNameContr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<CustReg2ViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Material(
          child: Stack(
            children: <Widget>[
              //
              // >>>>>>>>> Registor background image
              //
              CustAuthBg(),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  // ------------------------------------------------------   T I T L E
                  Container(
                    margin: EdgeInsets.only(
                        left: widgetSize.width * 0.05,
                        top: widgetSize.height * 0.25),
                    child: AuthHeader(
                      firstText: "Hello",
                      secondText: "There.",
                      processText: "register",
                      deviceSize: deviceSize,
                    ),
                  ),
                  SizedBox(height: widgetSize.height * 0.02),
                  StepHeaderWithBG(
                      stepsText: "Step 2 of 2", deviceSize: deviceSize),
                  SizedBox(height: widgetSize.height * 0.02),

                  // ------------------------------------------------------   T E X T   F E I L D S   A N D   B U T T O N S
                  Container(
                    margin: EdgeInsets.only(left: widgetSize.width * 0.05),
                    child: Text(
                      "Add info ",
                      style: TextStyle(
                        fontSize: widgetSize.height * 0.02,
                        fontFamily: 'Montserrat',
                        color: Colors.brown,
                      ),
                    ),
                  ),
                  SizedBox(height: widgetSize.height * 0.01),
                  // :::::::>>>||||--------------------------------------------------   Phone verification initiated

                  TextFeildWithPrefix(
                    controller: custNameContr,
                    deviceSize: deviceSize,
                    isTypeInt: false,
                    preIcon: Icons.person,
                    isObscureText: false,
                    hintText: "Enter your name",
                  ),
                  SizedBox(height: widgetSize.height * 0.01),
                  // TextFeildWithPrefix(
                  //   controller: custPassContr,
                  //   deviceSize: deviceSize,
                  //   isTypeInt: false,
                  //   isObscureText: true,
                  //   preIcon: Icons.lock,
                  //   hintText: "Enter your password",
                  // ),
                  // SizedBox(height: widgetSize.height * 0.01),

                  DateOfBirthSelector(
                    deviceSize: deviceSize,
                    onDateTimeChanged: (newDateTime) {
                      dateOfBirth = newDateTime;
                    },
                  ),

                  SizedBox(height: widgetSize.height * 0.01),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      onPressed: () async {
                        bool isCustDataSuccess = await model.addCustData(
                          custNameContr.text,
                          dateOfBirth,
                        );
                        print(
                            "isCustDataSuccess ______________________________" +
                                isCustDataSuccess.toString());
                        isCustDataSuccess
                            ? Navigator.pushNamed(context, 'custReg_2')
                            : UIHelper().showErrorButtomSheet(
                                context, model.errorMessage);
                      },
                      child: AuthBtnStyle(
                        deviceSize: deviceSize,
                        passedText: "Register",
                      ),
                    ),
                  ),
                  SizedBox(height: widgetSize.height * 0.04),
                  // ------------------------------------------------------    T E X T    W I T H    R E G I S T E R    B U T T O N
                  Container(
                    margin: EdgeInsets.only(left: widgetSize.width * 0.05),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: widgetSize.height * 0.02,
                            fontFamily: 'Uni-Sans',
                            color: Colors.brown,
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            print("Tapped");
                            Navigator.pushNamed(context, 'custSignIn');
                          },
                          child: Text(
                            "Sign-in",
                            style: TextStyle(
                              fontSize: widgetSize.height * 0.02,
                              fontFamily: 'Uni-Sans',
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              model.state == ViewState.Busy ? Loading() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
