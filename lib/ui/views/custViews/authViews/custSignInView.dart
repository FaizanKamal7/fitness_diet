import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/widgets/authBtnStyle.dart';
import 'package:fitness_diet/ui/widgets/authHeader.dart';
import 'package:fitness_diet/ui/widgets/textFeildWithPrefix.dart';
import 'package:flutter/material.dart';

class CustSigninView extends StatefulWidget {
  @override
  _CustSigninViewState createState() => _CustSigninViewState();
}

class _CustSigninViewState extends State<CustSigninView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ResponsiveSafeArea(
      builder: (context, widgetSize) => Scaffold(
        body: Material(
          type: MaterialType.card,
          //  color: Color(0xffD4EBD3),
          child: Stack(
            children: <Widget>[
              //
              // >>>>>>>>> Registor background image
              //
              custAuthBg(),

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
                    controller: _controller,
                    deviceSize: deviceSize,
                    isTypeInt: true,
                    preIcon: Icons.phone,
                    hintText: "Enter phone no",
                  ),

                  SizedBox(height: widgetSize.height * 0.02),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      onPressed: null,
                      child: AuthBtnStyle(
                        deviceSize: deviceSize,
                        passedText: "Verify",
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
                            fontSize: widgetSize.height * 0.025,
                            fontFamily: 'Uni-Sans',
                            color: Colors.brown,
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            print("Tapped");
                            Navigator.pushNamed(context, 'custReg_1');
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: widgetSize.height * 0.025,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget custAuthBg() {
    return Opacity(
      opacity: 0.4,
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(custBGImage_1),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.blue.withOpacity(0.9),
              BlendMode.overlay,
            ),
          ),
        ),
      ),
    );
  }
}
