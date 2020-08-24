import 'package:fitness_diet/core/constants/route_paths.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/auth/custSignInViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/shared/ui_helpers.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/authHeader.dart';
import 'package:fitness_diet/ui/widgets/custAuthBg.dart';
import 'package:fitness_diet/ui/widgets/textFeildWithPrefix.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustSigninView extends StatefulWidget {
  @override
  _CustSigninViewState createState() => _CustSigninViewState();
}

class _CustSigninViewState extends State<CustSigninView> {
  final TextEditingController _phNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    bool tempBool = true;
    return BaseView<CustSignInViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Scaffold(
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
//                    : Container(),
                  model.hasErrorMessage
                      ? Container(
                          child: Text(model.errorMessage),
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
