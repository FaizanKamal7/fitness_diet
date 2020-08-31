import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custInfoViewModel/custInfoViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/foodSliderItem.dart';
import 'package:fitness_diet/ui/widgets/standardHeadingwithBGandRoundCorner.dart';
import 'package:fitness_diet/ui/widgets/standardInfoDisplayWithBullets.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CustInfo extends StatelessWidget {
  static List FoodCatgSectionItemList = [
    {'Name': "Biryani", "Pic": "assets/images/biryani.jpg"},
    {'Name': "Nihari", "Pic": "assets/images/nihari.jpg"},
    {'Name': "Kebab", "Pic": "assets/images/biryani.jpg"},
    {'Name': "Chicken", "Pic": "assets/images/cover.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _custData = Provider.of<CustData>(context);
    final _planData = Provider.of<Plan>(context);
    return BaseView<CustInfoViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Container(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: widgetSize.width * 0.02),
                child: Text(
                  "Following " + _custData.custFollowing.toString() + " chefs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "UniSansSemiBold",
                    fontSize: widgetSize.height * 0.044,
                    color: Color(0xff2a6427).withOpacity(0.75),
                  ),
                ),
              ),
              SizedBox(
                height: widgetSize.height * 0.03,
              ),
              Container(
                margin: EdgeInsets.only(left: widgetSize.width * 0.1),
                child: Column(
                  children: <Widget>[
                    standardInfDisplaywithBullets('Data of birth : ',
                        model.parseDate(_custData.custDateOfBirth), deviceSize),
                    standardInfDisplaywithBullets(
                        'Location :', '_custData.custLocation', deviceSize),
                  ],
                ),
              ),

              SizedBox(height: widgetSize.height * 0.06),
              standardHeadingWithBGAndRoundCorner(passedText: "Favourites"),

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
                      child: FoodSliderItem(FoodCatgSectionItemList[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
