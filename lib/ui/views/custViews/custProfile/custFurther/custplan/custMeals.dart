import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:flutter/material.dart';

class CustMeals extends StatefulWidget {
  @override
  _CustMealsState createState() => _CustMealsState();
}

class _CustMealsState extends State<CustMeals> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context, widgetSize) => Container(
        height: widgetSize.height * 0.8,
        width: widgetSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: widgetSize.height * 0.1,
              width: widgetSize.width,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.16),
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(widgetSize.height * 0.05),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "lib/assets/images/AppIcons/left-arrow.png",
                    height: widgetSize.height * 0.05,
                    width: widgetSize.height * 0.05,
                  ),
                  Text(
                    "TODAY, AUGUST 8",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: widgetSize.height * 0.05,
                      color: Color(0xff4d3814).withOpacity(0.71),
                    ),
                  ),
                  Image.asset(
                    "lib/assets/images/AppIcons/right-arrow.png",
                    height: widgetSize.height * 0.05,
                    width: widgetSize.height * 0.05,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: widgetSize.height * 0.01,
            ),
            Container(
              height: widgetSize.height * 0.15,
              width: widgetSize.width,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.16),
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(widgetSize.height * 0.05),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "lib/assets/images/AppIcons/breakfast.png",
                    height: widgetSize.height * 0.20,
                    width: widgetSize.height * 0.20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add breakfast",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widgetSize.height * 0.045,
                          color: Color(0xff4d3814),
                        ),
                      ),
                      Text(
                        "Recommended 774 - 1032 Kcal",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widgetSize.height * 0.035,
                          color: Color(0xff4d3814).withOpacity(0.38),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: widgetSize.height * 0.01,
            ),

            Container(
              height: widgetSize.height * 0.15,
              width: widgetSize.width,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.16),
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(widgetSize.height * 0.05),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "lib/assets/images/AppIcons/lunch.png",
                    height: widgetSize.height * 0.20,
                    width: widgetSize.height * 0.20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Lunch",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widgetSize.height * 0.045,
                          color: Color(0xff4d3814),
                        ),
                      ),
                      Text(
                        "Recommended 774 - 1032 Kcal",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widgetSize.height * 0.035,
                          color: Color(0xff4d3814).withOpacity(0.38),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: widgetSize.height * 0.01,
            ),
            //
            //
            Container(
              height: widgetSize.height * 0.15,
              width: widgetSize.width,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.16),
                    blurRadius: 6,
                  ),
                ],
                borderRadius: BorderRadius.circular(widgetSize.height * 0.05),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "lib/assets/images/AppIcons/snacks.png",
                    height: widgetSize.height * 0.20,
                    width: widgetSize.height * 0.20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Snacks",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widgetSize.height * 0.045,
                          color: Color(0xff4d3814),
                        ),
                      ),
                      Text(
                        "Recommended 774 - 1032 Kcal",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: widgetSize.height * 0.035,
                          color: Color(0xff4d3814).withOpacity(0.38),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
