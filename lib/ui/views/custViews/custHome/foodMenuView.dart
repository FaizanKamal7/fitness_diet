import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/Header/app_drawer.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/Header/homeAppBarDelegate.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/Header/locationHeader.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/avalaibleDishes/AvaliableDishesList.dart';
import 'package:fitness_diet/ui/views/custViews/custHome/recentFoodSlider/recentFoodSlider.dart';
import 'package:fitness_diet/ui/widgets/standardHeadingNoBg.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FoodMenuView extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static List foodItemInfoList = [
    {
      'id': 0,
      'dishPic': "assets/images/biryani.jpg",
      'chefPic': "assets/images/cookUser.png",
      'location': "Mandian, Abbottabad",
      "dishName": "Seekh Kebab",
      "chefName": "Begum Uzma",
      "price": 100,
      'dishRatings': 4.3,
      'chefRatings': 4.3,
    },
    {
      'id': 1,
      'dishPic': "assets/images/biryani.jpg",
      'chefPic': "assets/images/cookUser.png",
      'location': "Supply, Abbottabad",
      "dishName": "Nihari",
      "chefName": "Humaira Jabeen",
      "price": 100,
      'dishRatings': 4.3,
      'chefRatings': 4.3,
    },
    {
      'id': 2,
      'dishPic': "assets/images/biryani.jpg",
      'chefPic': "assets/images/cookUser.png",
      'location': "Nawasher, Abbottabad",
      "dishName": "Biryani",
      "chefName": "Nudrat Habib",
      "price": 10,
      'dishRatings': 4.3,
      'chefRatings': 4.3,
    },
    {
      'id': 3,
      'dishPic': "assets/images/biryani.jpg",
      'chefPic': "assets/images/cookUser.png",
      'location': "sa",
      "dishName": "Karahi",
      "chefName": "Ali",
      "price": 100,
      'dishRatings': 4.3,
      'chefRatings': 4.3,
    },
    {
      'id': 4,
      'dishPic': "assets/images/biryani.jpg",
      'chefPic': "assets/images/cookUser.png",
      'location': "Asafdtd",
      "dishName": "Karahi",
      "chefName": "Ali",
      "price": 100,
      'dishRatings': 4.3,
      'chefRatings': 4.3,
    },
    {
      'id': 5,
      'dishPic': "assets/images/biryani.jpg",
      'chefPic': "assets/images/cookUser.png",
      'location': "Atd",
      "dishName": "Karahi",
      "chefName": "Ali",
      "price": 100,
      'dishRatings': 4.3,
      'chefRatings': 4.3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ResponsiveSafeArea(
      builder: (context, widgetSize) => Scaffold(
        key: _scaffoldKey,
        endDrawer: AppDrawer(),
        body: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                // ---------------------------------------------------- A P P   B A R   H E A D E R
                SliverPersistentHeader(
                  delegate: HomeAppBarDelegate(
                    maxExtent: widgetSize.height * 0.36,
                    minExtent: widgetSize.height * 0.05,
                  ),
                  pinned: false,
                  floating: false,
                ),
// ---------------------------------------------------- R E C E N T   F O O D   C O U R S A L   S L I D E R
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //
                      // >>>>>>>>> R E C E N T  Heading
                      //
                      Container(
                        // * To align the text container to the left
                        alignment: Alignment.bottomLeft,

                        padding: EdgeInsets.all(widgetSize.width * 0.022),

                        child: StandardHeadingNoBg(
                          deviceSize: deviceSize,
                          passedText: "Recent",
                        ),
                      ),
                      // SizedBox(
                      //   height: widgetSize.height * 0.01,
                      // ),
                      Container(
                        height: widgetSize.height * 0.13,
                        child: RecentFoodSlider(),
                      ),
                      SizedBox(
                        height: widgetSize.height * 0.017,
                      ),
                    ],
                  ),
                ),

                // ---------------------------------------------------- A V A L A I B L E    D I S H E S    L I S T
                SliverToBoxAdapter(
                  child: Container(
                    // * To align the text container to the left
                    alignment: Alignment.bottomLeft,

                    padding: EdgeInsets.all(widgetSize.width * 0.022),

                    child: StandardHeadingNoBg(
                      deviceSize: deviceSize,
                      passedText: "Available dishes",
                    ),
                  ),
                ),

                SliverFixedExtentList(
                  itemExtent: widgetSize.height * 0.195,
                  delegate: SliverChildListDelegate(
                    [
                      ...foodItemInfoList.map(
                        (itemNo) => AvailableDishesList(
                          foodItem: itemNo, // Containing food item info
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ---------------------------------------------------- A P P   B A R   H E A D E R

            LocationHeader(),

            //  ---------------------------------------------------- M E N U   D R A W E R
            Container(
              //color: Colors.amber,
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(
                top: widgetSize.height * 0.0001,
                left: widgetSize.width * 0.09,
                bottom: widgetSize.height * 0.93,
              ),
              child: IconButton(
                // color: Colors.white,
                icon: Icon(
                  Icons.menu,
                  size: widgetSize.height * 0.033,
                  color: Colors.black.withOpacity(0.7),
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
