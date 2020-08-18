import 'dart:async';

import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/homeview.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

// TIMER FOR SPLASH SCREEN
  startTimer() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => HomeView()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context, deviceSize) {
        return Material(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  overflow: Overflow.clip,
                  children: [
                    Container(
                      //   margin: EdgeInsets.only(top: 40),
                      child: Text(
                        "Diet",
                        style: TextStyle(
                          fontFamily: "Lemon-Milk",
                          fontSize: deviceSize.height * 0.15,
                          color: Color(0xffbc6e6e),
                        ),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(bottom: 60),
                      child: Text(
                        "fitness",
                        style: TextStyle(
                          fontFamily: "Curved-Square",
                          fontSize: deviceSize.height * 0.05,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              ],
            )
            // child: Stack(
            //   children: <Widget>[
            //     //______________________________________________________
            //     Positioned.fill(
            //       child: Image(
            //         image: AssetImage('assets/images/home1.jpg'),
            //         fit: BoxFit.fill,
            //       ),
            //     ),
            //     //______________________________________________________
            //     Container(
            //       width: deviceSize.width,
            //       height: deviceSize.height * 0.3,
            //       margin: EdgeInsets.symmetric(vertical: deviceSize.height * 0.32),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Image(
            //             image: AssetImage('assets/images/chef1.png'),
            //           ),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Text(
            //                 "Home",
            //                 style: TextStyle(
            //                   fontFamily: "Potra",
            //                   fontSize: 50,
            //                   color: Color(
            //                       0xff00FFFB), // Replace color "#" in color code with "0*ff"
            //                   decoration: TextDecoration.none,
            //                 ),
            //               ),
            //               Text(
            //                 "Crisp",
            //                 style: TextStyle(
            //                   fontFamily: "Potra",
            //                   fontSize: 50,
            //                   color: Color(0xff00FFFB),
            //                   decoration: TextDecoration.none,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //     //______________________________________________________
            //   ],
            // ),
            );
      },
    );
  }
}
