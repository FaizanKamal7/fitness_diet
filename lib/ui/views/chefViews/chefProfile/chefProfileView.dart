import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/chefViews/authVIews/chefRegView_1.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/ChefSliverAppBar.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefAppDrawer.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefDish/chefDishesView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefInfo/chefInfo.dart';
import 'package:fitness_diet/ui/widgets/ProfileHeaderText.dart';
import 'package:fitness_diet/ui/widgets/tabBarBtnStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChefProfileView extends StatefulWidget {
  @override
  _ChefProfileViewState createState() => _ChefProfileViewState();
}

class _ChefProfileViewState extends State<ChefProfileView>
    with SingleTickerProviderStateMixin {
  int pageViewIndex = 0;
  PageController _pgController = PageController();
  List pageContent = [ChefDishes(), ChefInfo()];
  ScrollController _scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _tabController;
  int widgetCountBeforeSliverOverlapAbsorber = 1;
  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 2);
  }

  static List foodItemInfoList = [
    {
      'id': 0,
      'dishPic': "assets/images/kebab.jpg",
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
      'dishPic': "assets/images/nihari.jpg",
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
    }
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _chefData = Provider.of<ChefData>(context);


    return ResponsiveSafeArea(
      builder: (context, widgetSize) => Scaffold(
        key: _scaffoldKey,
        endDrawer: ChefAppDrawer(),
        body: Stack(
          fit: StackFit.loose,
          children: [
            NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  //
                  // >>>>>>>>>>> Header content
                  //

                  SliverPersistentHeader(
                    delegate: ChefSliverAppBar(
                      maxExtent: deviceSize.height * 0.3,
                      minExtent: deviceSize.height * 0.26,
                      chefData: _chefData,
                    ),
                    pinned: true,
                    floating: false,
                  ),
                  //
                  // >>>>>>>>>>> Space between tabbar and header
                  //
                  SliverToBoxAdapter(
                    child: Container(
                      child: SizedBox(
                        height: deviceSize.height * 0.02,
                      ),
                    ),
                  ),
                  //
                  // >>>>>>>>>>> Tabbars
                  //

                  SliverPersistentHeader(
                    delegate: tabsDelegate(
                      _tabController,
                      deviceSize.height * 0.051, // MaxExtent
                      deviceSize.height * 0.050, // MinExtent
                    ),
                    pinned: true,
                    floating: false,
                  ),
                ];
              },
              //
              // >>>>>>>>>>> Tabbars display
              //
              body: TabBarView(
                children: [
                  ChefDishes(),
                  ChefInfo(),
                ],
                controller: _tabController,
              ),
            ),
            //  ----------------------------------------------------   D R A W E R

            Container(
              margin: EdgeInsets.only(
                  left: deviceSize.height * 0.03,
                  top: deviceSize.height * 0.018),
              //   color: Colors.red,
              child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  // >>>>>>>>> B A C K   I C O N
                  //

                  // RawMaterialButton(
                  //   onPressed: () {},
                  //   elevation: 2.0,
                  //   fillColor: Colors.white,
                  //   child: Icon(
                  //     Icons.arrow_back_ios,
                  //     size: deviceSize.height * 0.025,
                  //   ),
                  //   //    padding: EdgeInsets.all(deviceSize.height * 0.0),
                  //   shape: CircleBorder(),
                  // ),

                  //
                  // >>>>>>>>> P R O F I L E   T E X T
                  //
                  ProfielHeaderText(),

                  Spacer(),
                  // FlatButton(
                  //   onPressed: () {
                  //     AuthService().signOut();
                  //   },
                  //   child: Text(
                  //     "Sign out",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: MediaQuery.of(context).size.height * 0.02,
                  //     ),
                  //   ),
                  // ),
                  IconButton(
                    // color: Colors.white,
                    icon: Icon(
                      Icons.menu,
                      size: widgetSize.height * 0.033,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState.openEndDrawer();
                    },
                  ),
                  // Container(
                  //   //color: Colors.amber,
                  //   alignment: Alignment.topRight,
                  //   margin: EdgeInsets.only(
                  //     top: widgetSize.height * 0.0001,
                  //     left: widgetSize.width * 0.09,
                  //     bottom: widgetSize.height * 0.93,
                  //   ),
                  //   child:
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class tabsDelegate extends SliverPersistentHeaderDelegate {
  final double maxextent;
  final double minextent;
  double temp = 0;
  tabsDelegate(this._tabController, this.maxextent, this.minextent);

  TabController _tabController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // temp = maxExtent / 1.1 - shrinkOffset;
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      // decoration: BoxDecoration(
      color: Colors.white,
      //   borderRadius: BorderRadius.circular(deviceSize.height * 0.4),
      // ),
      child: TabBar(
        // indicatorWeight: 2,
        //   indicatorColor: Colors.brown,
        labelPadding:
            EdgeInsets.symmetric(horizontal: deviceSize.width * 0.003),
        //  unselectedLabelColor: Colors.redAccent,
        //  indicatorSize: TabBarIndicatorSize.label,
        //   dragStartBehavior: DragStartBehavior.start,
        indicator: BoxDecoration(
            // borderRadius: BorderRadius.circular(deviceSize.height * 0.1),
            // //    color: Color(0xff4E7A0B),
            // border: Border.all(
            //   width: deviceSize.width * 0.005,
            //   color: Color(0xff4E7A0B),
            // ),
            ),
        labelStyle: TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w700,
          fontSize: deviceSize.height * 0.02,
          // color: Color(0xff2a6427),
        ),
        labelColor: Color(0xff2a6427),
        tabs: <Tab>[
          Tab(child: TabBarBtnStyle(deviceSize: deviceSize, btnText: "Dishes")),
          Tab(child: TabBarBtnStyle(deviceSize: deviceSize, btnText: "Info")),
        ],
        controller: _tabController,
      ),
    );
  }

  @override
  bool shouldRebuild(tabsDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => maxextent;

  @override
  double get minExtent => minextent;
}