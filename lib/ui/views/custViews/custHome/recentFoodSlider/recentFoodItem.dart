import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:flutter/material.dart';

class RecentFoodItem extends StatelessWidget {
  RecentFoodItem(this.foodCtgItem);
  final Map
      foodCtgItem; // List of item categories. I used "Map" instead of "List" becuase I have category list in the form of map
  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context, deviceSize) => Container(
        margin: EdgeInsets.symmetric(vertical: deviceSize.height * 0.04),
        decoration: BoxDecoration(
          color: Color(0xffe4d7cb),
          boxShadow: [
            BoxShadow(
              offset: Offset(2.00, 3.00),
              color: Color(0xff000000).withOpacity(0.16),
              blurRadius: 9,
            ),
          ],
          borderRadius: BorderRadius.circular(deviceSize.width * 0.14),
        ),
        child: Column(
          children: <Widget>[
            // ------------------------------------ First Column (Dish Info)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // >>>>>>>>>>> Recent food picture
                Container(
                  //  color: Colors.red,
                  margin: EdgeInsets.only(
                    top: deviceSize.height * 0.24,
                    left: deviceSize.width * 0.05,
                  ),
                  height: deviceSize.height * 0.4,
                  width: deviceSize.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(foodCtgItem['Pic']),
                        fit: BoxFit.cover),
                    border: Border.all(
                      width: 2.00,
                      color: Color(0xff707070).withOpacity(0.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 3.00),
                        color: Color(0xff000000).withOpacity(0.16),
                        blurRadius: 6,
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: deviceSize.width * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // >>>>>>>>>>> Recent food Name
                      Text(
                        foodCtgItem['Name'],
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: deviceSize.height * 0.2,
                          color: Color(0xff4e7a0b),
                        ),
                      ),
                      // >>>>>>>>>>> Recent food chef
                      Text(
                        "By Ali Khan",
                        style: TextStyle(
                          fontFamily: "UniSansRegular",
                          fontSize: deviceSize.height * 0.12,
                          color: Color(0xff000000),
                        ),
                      ),
                      // >>>>>>>>>>> Recent food ratings
                      Container(
                        height: deviceSize.height * 0.12,
                        width: deviceSize.width * 0.5,
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_half,
                              color: Colors.green,
                              size: deviceSize.height * 0.1,
                            ),
                            Text(
                              " (4.3)",
                              style: TextStyle(
                                fontSize: deviceSize.height * 0.1,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ------------------------------------ Second Column ( Calories + Price )
            Container(
              margin: EdgeInsets.symmetric(vertical: deviceSize.height * 0.03),
              height: deviceSize.height * 0.2,
              width: deviceSize.width * 0.8,
              child: Row(
                children: <Widget>[
                  Container(
                    width: deviceSize.width * 0.3,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff).withOpacity(0.55),
                      border: Border.all(
                        width: 1.00,
                        color: Color(0xffc48551).withOpacity(0.55),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.09),
                          blurRadius: 6,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(7.00),
                    ),
                    child: Center(
                      child: Text(
                        "280 Kcal",
                        style: TextStyle(
                          fontFamily: "Tahoma",
                          fontSize: deviceSize.height * 0.08,
                          color: Color(0xff38631d),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Rs1000",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Lemon-Milk",
                      fontSize: deviceSize.height * 0.15,
                      color: Color(0xff030300),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//...FoodCategorysectionList.map((itemNo)=>FoodCategorysectionItem(foodCtgItem: itemNo),);
