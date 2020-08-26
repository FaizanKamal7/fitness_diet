import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StandardHeadingNoBg extends StatelessWidget {
  String passedText;
  StandardHeadingNoBg({@required this.passedText});
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Text(
      passedText,
      style: TextStyle(
        fontFamily: "Montserrat",
        fontSize: _deviceSize.height * 0.024,
        color: Color(0xff4d3814).withOpacity(0.71),
      ),
    );
  }
}
