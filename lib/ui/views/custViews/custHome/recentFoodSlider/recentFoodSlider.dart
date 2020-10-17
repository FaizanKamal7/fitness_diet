import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/widgets/foodSliderItem.dart';
import 'package:flutter/material.dart';

class RecentFoodSlider extends StatelessWidget {
  // List for testing
  // ignore: non_constant_identifier_names
  static List FoodCatgSectionItemList = [
    {'Name': "Biryani", "Pic": "assets/images/biryani.jpg"},
    {'Name': "Nihari", "Pic": "assets/images/nihari.jpg"},
    {'Name': "Kebab", "Pic": "assets/images/kebab.jpg"},
    {'Name': "Chicken", "Pic": "assets/images/cover.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context, widgetSize) => Container(
        height: widgetSize.height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: FoodCatgSectionItemList.length,
          itemBuilder: (context, index) {
            return Container(
              width: widgetSize.width * 0.4,
              margin: index == 0
                  ? EdgeInsets.only(left: widgetSize.width * 0.025)
                  : EdgeInsets.only(left: widgetSize.width * 0.015),
              child: FoodSliderItem(FoodCatgSectionItemList[index]),
            );
          },
        ),
      ),
    );
  }
}
