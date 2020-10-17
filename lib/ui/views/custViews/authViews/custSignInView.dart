import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:fitness_diet/core/constants/route_paths.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/auth/custSignInViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/authHeader.dart';
import 'package:fitness_diet/ui/widgets/Buttons/custAuthBg.dart';
import 'package:fitness_diet/ui/widgets/showErrorMessage.dart';
import 'package:fitness_diet/ui/widgets/TextFeilds/textFeildWithPrefix.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animator/animator.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CustSigninView extends StatefulWidget {
  @override
  _CustSigninViewState createState() => _CustSigninViewState();
}

class _CustSigninViewState extends State<CustSigninView> {
  bool timeComplete = true;
  final TextEditingController _phNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Countdown(
      seconds: 2,
      build: (BuildContext context, double time) => Text(time.toString()),
      interval: Duration(milliseconds: 100),
      onFinished: () {
        setState(() {
          timeComplete = false;
        });
      },
    );

    return BaseView<CustSignInViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Scaffold(
          resizeToAvoidBottomPadding: false,
          body: StreamProvider<CustData>.value(
            value: DatabaseService().getCustData,
            child: Material(
              type: MaterialType.card,
              //  color: Color(0xffD4EBD3),
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
                            top: widgetSize.height * 0.35),
                        child: AuthHeader(
                          firstText: "Welcome",
                          secondText: "Back.",
                          processText: "login",
                          deviceSize: deviceSize,
                        ),
                      ),
                      SizedBox(height: widgetSize.height * 0.02),

                      // ------------------------------------------------------   T E X T   F E I L D S   A N D   B U T T O N S
                      Container(
                        margin: EdgeInsets.only(left: widgetSize.width * 0.05),
                        child: Text(
                          "Verify phone ",
                          style: TextStyle(
                            fontSize: widgetSize.height * 0.025,
                            fontFamily: 'Montserrat',
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      SizedBox(height: widgetSize.height * 0.01),
                      // :::::::>>>||||--------------------------------------------------   Phone verification initiated

                      TextFeildWithPrefix(
                        controller: _phNoController,
                        deviceSize: deviceSize,
                        isTypeInt: true,
                        preIcon: Icons.phone,
                        isObscureText: false,
                        hintText: "Enter phone no",
                      ),

                      SizedBox(height: widgetSize.height * 0.02),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: FlatButton(
                          onPressed: () {
                            model.signInCust(_phNoController.text);

                            // bool signInResult =
                            //     await model.signInCust(_phNoController.text);
                            // signInResult
                            //     ? Navigator.popAndPushNamed(
                            //         context, FoodMenuRoute)
                            //     : UIHelper().showErrorButtomSheet(
                            //         context, model.errorMessage);
                          },
                          child: AuthBtnStyle(
                            deviceSize: deviceSize,
                            passedText: "Login",
                          ),
                        ),
                      ),
                      SizedBox(height: widgetSize.height * 0.1),
                      // ------------------------------------------------------    T E X T    W I T H    R E G I S T E R    B U T T O N
                      Container(
                        margin: EdgeInsets.only(left: widgetSize.width * 0.05),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: widgetSize.height * 0.02,
                                fontFamily: 'Uni-Sans',
                                color: Colors.brown,
                              ),
                            ),
                            InkResponse(
                              onTap: () {
                                model.goToCustReg1();
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: widgetSize.height * 0.02,
                                  fontFamily: 'Uni-Sans',
                                  color: Colors.brown,
                                ),
                              ),
                              // InkResponse(
                              //   onTap: () {
                              //     print("Tapped");
                              //     Navigator.pushNamed(context, 'custReg_1');
                              //   },
                              //   child: Text(
                              //     "Register",
                              //     style: TextStyle(
                              //       fontSize: widgetSize.height * 0.02,
                              //       fontFamily: 'Uni-Sans',
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.brown,
                              //     ),
                              //   ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // tempBool
                  //     ? showBottomSheet(
                  //         context: context,
                  //         builder: (context) => UIHelper()
                  //             .showErrorButtomSheet(context, "errorText"))
                  // Animator<double>(
                  //       tween: Tween<double>(begin: 0, end: 300),
                  //       cycles: 0,
                  //       builder: (context, animatorState, child) => Center(
                  //         child: Container(
                  //           margin: EdgeInsets.symmetric(vertical: 10),
                  //           height: animatorState.value,
                  //           width: animatorState.value,
                  //           child: FlutterLogo(),
                  //         ),
                  //       ),
                  //     )
                  //  : Container(),

                  // Countdown(
                  //     seconds: 10,
                  //     build: (BuildContext context, double time) =>
                  //         TranslationAnimatedWidget(
                  //             enabled:
                  //                 timeComplete, //update this boolean to forward/reverse the animation
                  //             values: [
                  //               Offset(0, -40), // disabled value value
                  //               Offset(0, 400), //intermediate value
                  //               Offset(0, -40) //enabled value
                  //             ],
                  //             child: Text("feds")),
                  //     interval: Duration(milliseconds: 1000),
                  //     onFinished: () {
                  //       //timeComplete= false;
                  //     },
                  //   )
                  model.hasErrorMessage
                      ? Container(
                          color: Colors.red,
                          child: Text(
                            model.errorMessage,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Container(),

                  model.state == ViewState.Busy ? Loading() : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
