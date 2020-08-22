import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/recentFoodSlider/recentFoodItem.dart';
import 'package:flutter/material.dart';

class RecentFoodSlider extends StatelessWidget {
  // List for testing
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
              child: RecentFoodItem(FoodCatgSectionItemList[index]),
            );
          },
        ),
      ),
    );
  }
}

//  height: widgetSize.height * 0.1,
//  width: deviceSize.width,
// color: Colors.amber,
//   margin: EdgeInsets.symmetric(horizontal: deviceSize.height * 0.01),
//   child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemCount: FoodCatgSectionItemList.length, // Total no of food items
//     itemBuilder: (context, index) {
//       return FoodCategorysectionItem(FoodCatgSectionItemList[index]);
//     },
//   ),
