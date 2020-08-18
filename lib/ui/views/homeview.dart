import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/viewmodels/checkProfileViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/imagesURLs.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/skip_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<CheckProfileViewModel>(builder: (context, model, child) {
      if (user == null) {
        return ResponsiveSafeArea(
          builder: (context, widgetSize) => Scaffold(
            body: Stack(
              children: [
                Row(
                  children: [
                    Expanded(child: custBgImage1Ftn()),
                    Expanded(child: chefBgImage1Ftn()),
                  ],
                ),
//
                // >>>>>>>>>> H E A D E R   T E X T
                //
                Container(
                  margin: EdgeInsets.only(
                    top: widgetSize.height * 0.22,
                    left: widgetSize.width * 0.03,
                  ),
                  child: Text(
                    "Fitness",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: widgetSize.height * 0.1,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: widgetSize.height * 0.3,
                    left: widgetSize.width * 0.03,
                  ),
                  child: Text(
                    "DIET",
                    style: TextStyle(
                      fontFamily: "Lemon-Milk",
                      fontSize: widgetSize.height * 0.1,
                      color: Color(0xff05355a),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                    top: widgetSize.height * 0.3,
                    left: widgetSize.width * 0.03,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              startAsText(deviceSize),
                              FlatButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, 'custHome'),
                                child:
                                    startAsButtonStyle("Customer", deviceSize),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              startAsText(deviceSize),
                              FlatButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, 'custHome'),
                                child: startAsButtonStyle("Chef", deviceSize),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                //
                // >>>>>>>>>> "S T A R T   A S"   B U T T O N S  D E L I V E R Y
                //
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(bottom: widgetSize.height * 0.07),
                  padding:
                      EdgeInsets.symmetric(horizontal: widgetSize.width * 0.04),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Start as",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widgetSize.height * 0.02,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        " Delivery Guy",
                        style: TextStyle(
                          fontFamily: "BigNoodle",
                          fontSize: widgetSize.height * 0.026,
                          color: Color(0xff7A400B),
                        ),
                      ),
                      Spacer(),
                      // >>>>>>>>>>>>>>>>>>>> S K I P
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, 'foodMenu'),
                        child: SkipBtn(
                          passedText: "SKIP",
                          deviceSize: deviceSize,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        dynamic _returnedUser = model.userTypeIs(user.uid);
        if (_returnedUser.toString() == "cust") {
          Navigator.pushNamed(context, "cust");
        } else if (_returnedUser.toString() == "chef") {
          Navigator.pushNamed(context, "chef");
        } else {
          return Container(
            child: Center(
              child: FlatButton(
                onPressed: () => AuthService().signOut(),
                child: Text("Signout"),
              ),
            ),
          );
        }

        print(
            "Returend user: " + _returnedUser + " and user id is: " + user.uid);
        Navigator.pushNamed(context, _returnedUser.toString());
      }
    });
  }

  Widget custBgImage1Ftn() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(custBGImage_1),
          colorFilter: new ColorFilter.mode(
            Colors.lightBlue.withOpacity(0.6),
            BlendMode.srcOver,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget chefBgImage1Ftn() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(chefBGImage_1),
            colorFilter: ColorFilter.mode(
              Colors.lightBlue.withOpacity(0.6),
              BlendMode.srcATop,
            ),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget startAsText(Size widgetSize) {
    return Text(
      "Start as",
      style: TextStyle(
        fontFamily: "Montserrat",
        fontSize: widgetSize.height * 0.02,
        color: Color(0xffffffff),
        shadows: [
          Shadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
      ),
    );
  }

  Widget startAsButtonStyle(String _passedText, Size widgetSize) {
    return Container(
      height: widgetSize.height * 0.04,
      width: widgetSize.width * 0.4,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Colors.black.withOpacity(0.8),
            blurRadius: 6,
          ),
        ],
        color: Color(0xff28F5FA),
        borderRadius: BorderRadius.all(
          Radius.circular(widgetSize.height * 0.03),
        ),
      ),
      child: Center(
        child: Text(
          _passedText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: widgetSize.height * 0.023,
            color: Color(0xff020000),
          ),
        ),
      ),
    );
  }
}
