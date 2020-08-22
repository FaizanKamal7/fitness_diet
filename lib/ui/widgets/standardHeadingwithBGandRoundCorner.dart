import 'package:fitness_diet/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

Widget standardHeadingWithBGAndRoundCorner(String text, Size deviceSize) {
  return Container(
    height: deviceSize.height * 0.06,
    width: deviceSize.width,
    decoration: BoxDecoration(
      color: standardButtonBGColor,
      border: Border.all(
        width: 1.00,
        color: Color(0xffffffff),
      ),
      borderRadius: BorderRadius.circular(23.00),
    ),
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 20,
          color: Color(0xff2a6427),
        ),
      ),
    ),
  );
}
