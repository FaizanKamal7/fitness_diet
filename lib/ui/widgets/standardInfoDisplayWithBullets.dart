import 'package:flutter/material.dart';

Widget standardInfDisplaywithBullets(
    String text1, String text2, Size deviceSize) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: deviceSize.height * 0.015),
        height: deviceSize.height * 0.02,
        width: deviceSize.width * 0.02,
        decoration: BoxDecoration(
          color: Color(0xff000000),
          border: Border.all(
            width: 1.00,
            color: Color(0xff000000),
          ),
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: deviceSize.width * 0.04),
      Text(
        text1,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: deviceSize.height * 0.030,
          color: Color(0xff4D3814),
          shadows: [
            Shadow(
              offset: Offset(0.00, 3.00),
              color: Color(0xff000000).withOpacity(0.16),
              blurRadius: 6,
            ),
          ],
        ),
      ),
      Container(
        child: Text(
          text2,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: deviceSize.height * 0.030,
            color: Color(0xff2A6427),
            shadows: [
              Shadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
