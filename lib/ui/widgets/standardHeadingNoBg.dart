import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardHeadingNoBg extends StatelessWidget {
  Size deviceSize;
  String passedText;
  StandardHeadingNoBg({this.deviceSize, @required this.passedText});
  @override
  Widget build(BuildContext context) {
    return Text(
      passedText,
      style: TextStyle(
        fontFamily: "Montserrat",
        fontSize: deviceSize.height * 0.024,
        color: Color(0xff4d3814).withOpacity(0.71),
      ),
    );
  }
}
