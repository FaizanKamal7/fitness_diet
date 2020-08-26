import 'dart:math';
import 'dart:ui';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/auth.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/constants.dart';
import 'package:fitness_diet/ui/widgets/standardBtnWhitishRound.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChefSliverAppBar extends SliverPersistentHeaderDelegate {
  ChefSliverAppBar(
      {@required this.maxExtent, @required this.minExtent, this.chefData});
  final double maxExtent;
  final double minExtent;
  double animationVal = 0;
  ChefData chefData;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final deviceSize = MediaQuery.of(context).size;
    final _chefData = Provider.of<ChefData>(context);

    void _showEditBottomSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 20,
        builder: (context) {
          //  return ChefProfileEdit();
        },
      );
    }

    animationVal = 10.0 - max(10.0, shrinkOffset * 10) / maxExtent;
    // debugPrint("-=-=-==-=-=--=-= SHRINK OFF: " +
    //     shrinkOffset.toString() +
    //     " ---- " +
    //     animationVal.toString() +
    //     " --- Calculations :  " +
    //     (animationVal * deviceSize.width / 30).toString());
    return ResponsiveSafeArea(
      builder: (context, widgetSize) => Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
// ---------------------------------------------------- B A C K G R O U N D    B L U R Y    I M A G E    C O V E R

            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(widgetSize.height * 0.2),
                bottomRight: Radius.circular(widgetSize.height * 0.2),
              ),
              child: Container(
                height: widgetSize.height * 0.94,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/chef2.JPG",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
// ---------------------------------------------------- H E A D E R   T E X T

// ---------------------------------------------------- C H E F   I N F O

            Column(
              children: <Widget>[
                //
                // >>>>>>>>> C H E F   P R O F I L E   P I C
                //
                Container(
                  margin: EdgeInsets.only(
                    top: widgetSize.height * 0.27,
                    // left: animationVal < 9.5
                    //     ? (animationVal > 6.2
                    //         ? animationVal * widgetSize.width * 0.8 / 30
                    //         : 85.8)
                    //     : 1
                  ),
                  //   alignment: animationVal > 9.5 ? Alignment.center : null,
                  alignment: Alignment.center,

                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/chef2.JPG",
                      height: animationVal > 7.2
                          ? widgetSize.height * 0.08 * animationVal / 2
                          : widgetSize.height * 0.08 * 7.2 / 2,
                      width: animationVal > 7.2
                          ? widgetSize.height * 0.08 * animationVal / 2
                          : widgetSize.height * 0.08 * 7.2 / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //
                // >>>>>>>>> C H E F   N A M E
                //
                Container(
                  margin: EdgeInsets.only(
                    top: widgetSize.height * 0.01,
                    // left: animationVal < 9.5 && animationVal > 6.2
                    //     ? animationVal * widgetSize.width / 30
                    //     : 1
                  ),
                  child: Text(
                    "_chefData.chefName",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: animationVal > 7.2
                          ? widgetSize.height * 0.025 * sqrt(animationVal)
                          : widgetSize.height * 0.025 * sqrt(13.2),
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
                //
                // >>>>>>>>> C H E F   F O L L O W E R S
                //
                Text(
                  "10K Followers",
                  style: TextStyle(
                    color: Color(0xffAAB825),
                    fontSize: animationVal > 7.2
                        ? widgetSize.height * 0.018 * sqrt(animationVal)
                        : widgetSize.height * 0.018 * sqrt(13.2),
                    fontFamily: "Uni-Sans",
                  ),
                ),
              ],
            ),
// ---------------------------------------------------- E D I T   A N D   C H A T
            Container(
              margin: EdgeInsets.only(
                  top: widgetSize.height * 0.84, left: widgetSize.width * 0.06),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                      onPressed: () => _showEditBottomSheet(),
                      child:
                          StandardBtnWhitishRound(passedText: "Edit Profile")),
                  Spacer(),
                  //
                  // >>>>>>>>> M E S S A G E   I C O N
                  //
                  FlatButton(
                    onPressed: null,
                    child: Container(
                        margin: EdgeInsets.only(right: widgetSize.width * 0.06),
                        height: deviceSize.height * 0.18,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.00, 4.00),
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(
                          FlevaIcons.message_circle,
                          color: Colors.tealAccent,
                          size: widgetSize.height * 0.16,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
