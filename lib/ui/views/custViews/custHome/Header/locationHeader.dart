import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:flutter/material.dart';
class LocationHeader extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ResponsiveSafeArea(
      builder: (context, widgetSize) => Container(
        color: Colors.white,
        height: widgetSize.height * 0.06,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // ---------------------------------------------------- DeliveryMan L O G O
            Container(
              padding: EdgeInsets.all(widgetSize.height * 0.007),
              child: Image.asset("assets/images/delivery-man.png"),
            ),

            Container(
              padding: EdgeInsets.all(widgetSize.height * 0.01),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    " Deliver to",
                    style: TextStyle(fontSize: widgetSize.height * 0.012),
                  ),
                  //
                  // >>>>>>>>> C U R R E N T   L O C A T I O N
                  //
                  InkResponse(
                    onTap: null,
                    child: Row(
                      children: <Widget>[
                       Icon(
                          Icons.location_on,
                          size: widgetSize.height * 0.015,
                          color: Colors.black54,
                        ), Text(
                          "Current location",
                          style: TextStyle(fontSize: widgetSize.height * 0.014),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            //
            // >>>>>>>>> Notification
            //

            InkResponse(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => null,
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(
                    right: widgetSize.width * 0.1,
                    top: widgetSize.height * 0.009),
                child: Icon(
                  Icons.notifications,
                  color: Colors.black54,
                  size: widgetSize.width * 0.05,
                ),
              ),
            ),

            // ---------------------------------------------------- M E N U   D R A W E R
            // Scaffold(
            //   key: _scaffoldKey,
            //   endDrawer: AppDrawer(),
            //   drawer: Container(
            //     alignment: Alignment.topRight,
            //     child: IconButton(
            //       color: Colors.white,
            //       icon: Icon(
            //         Icons.menu,
            //         size: widgetSize.height * 0.03,
            //         color: Colors.black.withOpacity(0.7),
            //       ),
            //       onPressed: () {
            //         _scaffoldKey.currentState.openEndDrawer();
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class DrawerStack extends StatelessWidget {
//   final GlobalKey<DrawerControllerState> _drawerKey =
//       GlobalKey<DrawerControllerState>();
//   final drawerScrimColor = Color.fromARGB(90, 100, 100, 128);
//   final double drawerEdgeDragWidth = null;
//   final DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start;

//   final Widget body;
//   final Drawer drawer;

//   DrawerStack({Key key, this.body, this.drawer}) : super(key: key);

//   void openDrawer() {
//     _drawerKey.currentState?.open();
//   }

//   @override
//   Widget build(BuildContext context) => Stack(
//         children: [
//           // body
//           body,

//           DrawerController(
//             key: _drawerKey,
//             alignment: DrawerAlignment.end,
//             child: AppDrawer(),
//             drawerCallback: (_) {},
//             dragStartBehavior: drawerDragStartBehavior,
//             //widget.drawerDragStartBehavior,
//             scrimColor: drawerScrimColor,
//             edgeDragWidth: drawerEdgeDragWidth,
//           ),
//         ],
//       );
// }
