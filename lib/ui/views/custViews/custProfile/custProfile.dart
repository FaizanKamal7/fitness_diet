import 'dart:ui';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custProfileViewmodel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/authViews/custSignInView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custinfo/custInfo.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custFurther/custplan/custPlan.dart';
import 'package:flutter/material.dart';
import 'package:fitness_diet/ui/shared/app_colors.dart';

import 'package:provider/provider.dart';
import 'custProfileEdit.dart';

class CustProfile extends StatefulWidget {
  @override
  _CustProfileState createState() => _CustProfileState();
}

class _CustProfileState extends State<CustProfile>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;

  void _showEditBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 20,
      builder: (context) {
        return null;
      },
    );
  }

  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 2);
  }
// static BuildContext _context;
//   User user = Provider.of<User>(_context,listen: false);
//   Stream<CustData> stream;
//   @override
//   void initState() {
//     super.initState();
//     print("User: + ${user.uid}");
//     stream = DatabaseService(uid: user.uid).getCustData;

  Future<void> someApi() {
    return Future(() {
      throw "FirstError()";
    }).catchError((error, stackTrace) {
      print("inner: $error");
      // although `throw SecondError()` has the same effect.
      return Future.error("SecondError()");
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // final deviceSize = MediaQuery.of(context).size;

    return StreamBuilder<CustData>(
      stream: DatabaseService(uid: user.uid).getCustData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Snapshot error ;;;;;;;;;;;;2: " + snapshot.error.toString());
        }

        if (snapshot.hasData && !snapshot.hasError) {
          print("It have data YES");
          CustData _custData = snapshot.data;

          return Material(
            child: ResponsiveSafeArea(
              builder: (context, deviceSize) => DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        // ---------------------------------------------------- B A C K G R O U N D    B L U R Y    I M A G E    C O V E R
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          child: Container(
                            height: deviceSize.height * 0.26,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/cust2.JPG",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        // ---------------------------------------------------- H E A D E R   T E X T
                        Container(
                          margin: EdgeInsets.only(
                              left: deviceSize.height * 0.03,
                              top: deviceSize.height * 0.013),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //
                              // >>>>>>>>> B A C K   I C O N
                              //
                              Image.asset(
                                "assets/images/AppIcons/back_white.png",
                                height: 25,
                                width: 25,
                              ),

                              // >>>>>>>>> P R O F I L E   T E X T
                              //
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Profile",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              ),
                              Spacer(),
                              //
                              // >>>>>>>>> S I G N   O U T   B U T T O N
                              //
                              // InkResponse(
                              //   onTap: () async {
                              //     await _auth.signOut();
                              //   },
                              //   child: Container(
                              //     margin:
                              //         EdgeInsets.only(right: deviceSize.width * 0.1),
                              //     child: Text(
                              //       "Sign out",
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 15,
                              //         fontFamily: "Uni-Sans",
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        // ---------------------------------------------------- U S E R   I N F O
                        Container(
                          margin: EdgeInsets.only(
                              top: deviceSize.height * 0.1,
                              left: deviceSize.width * 0.07),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //
                              // >>>>>>>>> U S E R   I M A G E
                              //
                              ClipOval(
                                child: Image.asset(
                                  "assets/images/cust2.JPG",
                                  height: deviceSize.height * 0.1,
                                  width: deviceSize.height * 0.1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // >>>>>>>>> U S E R   N A M E --A N D -- L O C A T I O N
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: deviceSize.width * 0.03),
                                    //

                                    //_custData.custName,
                                    child: Text(
                                      _custData.custName,
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: deviceSize.height * 0.042,
                                        color: standardprofileNameColor,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0.00, 6.00),
                                            color: Color(0xff000000)
                                                .withOpacity(0.16),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: deviceSize.width * 0.03),
                                      //

                                      //
                                      child: new Text(
                                        "Supply. Abbottabad",
                                        style: TextStyle(
                                          fontFamily: "UniSansRegular",
                                          fontSize: 20,
                                          color: standardprofileLocationColor,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(
                              top: deviceSize.height * 0.22,
                              right: deviceSize.width * 0.03),
                          child: Row(
                            children: <Widget>[
                              //
                              // >>>>>>>>> "E D I T"   B U T T O N
                              //onPressed: () => _showEditBottomSheet(),
                              SizedBox(
                                width: deviceSize.width * 0.1,
                              ),
                              Container(
                                height: deviceSize.height * 0.06,
                                width: deviceSize.width * 0.35,
                                decoration: BoxDecoration(
                                  color: Color(0xffe4d7cb),
                                  borderRadius: BorderRadius.circular(50.00),
                                ),
                                child: Center(
                                  child: Text(
                                    "Edit Profile",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "UniSansRegular",
                                      fontSize: deviceSize.height * 0.030,
                                      color: standarDishDisplayBGColor,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              //
                              // >>>>>>>>> M E S S A G E   B U T T O N
                              //
                              FlatButton(
                                onPressed: null,
                                child: Container(
                                  // margin: EdgeInsets.only(right: deviceSize.width * 0.003),
                                  height: deviceSize.height * 0.055,
                                  child: Image.asset(
                                    "assets/images/AppIcons/message.png",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //
                    // >>>>>>>>> I N F O   B A R
                    //
                    SizedBox(
                      height: deviceSize.height * 0.02,
                    ),
                    TabBar(
                      controller: _tabController,
                      tabs: <Tab>[
                        Tab(
                          child: Container(
                            height: deviceSize.height * 0.06,
                            width: deviceSize.width * 0.48,
                            decoration: BoxDecoration(
                              color: standardButtonBGColor,
                              border: Border.all(
                                width: 1.00,
                                color: Color(0xff2a6427),
                              ),
                              borderRadius: BorderRadius.circular(22.00),
                            ),
                            child: Center(
                              child: Text(
                                "Plan",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                  fontSize: deviceSize.height * 0.034,
                                  color: Color(0xff2a6427),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Spacer(),
                        Tab(
                          child: Container(
                            height: deviceSize.height * 0.06,
                            width: deviceSize.width * 0.48,
                            decoration: BoxDecoration(
                              color: standardButtonBGColor,
                              border: Border.all(
                                width: 1.00,
                                color: Color(0xff2a6427),
                              ),
                              borderRadius: BorderRadius.circular(22.00),
                            ),
                            child: Center(
                              child: Text(
                                "Info",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                  fontSize: deviceSize.height * 0.034,
                                  color: Color(0xff2a6427),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //
                    // >>>>>>>>> D Y N A M I C   S C R E E N
                    Expanded(
                      flex: 1,
                      child: Container(
                        //height: deviceSize.height * 0.625,
                        width: deviceSize.width,
                        margin: EdgeInsets.only(top: deviceSize.height * 0.02),
                        child: TabBarView(
                          children: [
                            CustPlan(),
                            CustInfo(),
                          ],
                          controller: _tabController,
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            child: Center(
                child: Text("No data in snapshot" + user.uid.toString())),
          );
        }
      },
    );
  }
}
