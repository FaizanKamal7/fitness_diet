import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/widgets/foodSliderItem.dart';
import 'package:fitness_diet/ui/widgets/standardHeadingNoBg.dart';
import 'package:fitness_diet/ui/widgets/standardHeadingwithBGandRoundCorner.dart';
import 'package:fitness_diet/ui/widgets/standardInfoDisplayWithBullets.dart';
import 'package:flutter/material.dart';

class CustInfo extends StatelessWidget {
  static List FoodCatgSectionItemList = [
    {'Name': "Biryani", "Pic": "lib/assets/images/biryani.jpg"},
    {'Name': "Nihari", "Pic": "lib/assets/images/nihari.jpg"},
    {'Name': "Kebab", "Pic": "lib/assets/images/kebab.jpg"},
    {'Name': "Chicken", "Pic": "lib/assets/images/cover.jpg"},
  ];
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ResponsiveSafeArea(
      builder: (context, widgetSize) => Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: widgetSize.width * 0.02),
              child: Text(
                "Following 23 chefs",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "UniSansSemiBold",
                  fontSize: widgetSize.height * 0.044,
                  color: Color(0xff2a6427).withOpacity(0.75),
                ),
              ),
            ),
            SizedBox(
              height: widgetSize.height * 0.06,
            ),
            Container(
              margin: EdgeInsets.only(left: widgetSize.width * 0.1),
              child: Column(
                children: <Widget>[
                  standardInfDisplaywithBullets(
                      'Data of birth :', ' 07-01-1998', deviceSize),
                  standardInfDisplaywithBullets(
                      'Location :', ' Shimla Hill,\nAbbottabad ', deviceSize),
                ],
              ),
            ),
            SizedBox(
              height: widgetSize.height * 0.02,
            ),
            standardHeadingWithBGAndRoundCorner('Body Measurement', deviceSize),
            SizedBox(
              height: widgetSize.height * 0.02,
            ),
            Container(
              margin: EdgeInsets.only(left: widgetSize.width * 0.1),
              child: Column(
                children: <Widget>[
                  standardInfDisplaywithBullets(
                      'Weight :', ' 65.0 ' + 'Kg', deviceSize),
                  standardInfDisplaywithBullets(
                      'Height :', ' 5 7 ', deviceSize),
                ],
              ),
            ),
            SizedBox(height: widgetSize.height * 0.06),
            standardHeadingWithBGAndRoundCorner('Favourites', deviceSize),

            SizedBox(
              height: widgetSize.height * 0.02,
            ),

            //>>>>>>> F  A V O RU R I T E S --- D I S H E S I

            Container(
              height: widgetSize.height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: FoodCatgSectionItemList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: widgetSize.width * 0.4,
                    margin: index == 0
                        ? EdgeInsets.only(left: deviceSize.width * 0.025)
                        : EdgeInsets.only(left: deviceSize.width * 0.015),
                    child: foodSliderItem(FoodCatgSectionItemList[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
