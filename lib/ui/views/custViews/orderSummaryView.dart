import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/enums/orderStatus.dart';
import 'package:fitness_diet/ui/widgets/orderSingleStage.dart';
import 'package:fitness_diet/ui/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class OrderSummaryView extends StatelessWidget {
  String orderID;
  List orderStatus;
  OrderSummaryView({@required this.orderID, @required this.orderStatus});
  @override
  Widget build(BuildContext context) {
    print("orderStatus : " + orderStatus.toString());
    return
        // WillPopScope(
        //   onWillPop: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => MainDataProvider(),
        //       ),
        //     );
        //   },
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
        backgroundColor: Colors.lightGreen.withOpacity(0.3),
      ),
      body: ListView(
        children: [
          Container(
            height: 60,
            color: Colors.pink.withOpacity(0.1),
            child: Center(
              // >>>>>>>>>>>>>>>>>>>>>>>>>>>> O R D E R   I D   A N D   T I M E
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "ESTIMATED TIME",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        "30 mins",
                      ),
                    ],
                  ),
                  // SizedBox(width: 15),
                  Column(
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Order ID",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        orderID.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // >>>>>>>>>>>>>>>>>>>>>>>>>>>> O R D E R  T R A C K I N G
          Timeline(
            children: <Widget>[
              OrderSingleStage(
                primaryText: "Order Placed",
                secondaryText: "We have received your order",
                passedIcon: FontAwesomeIcons.receipt,
                isDone: orderStatus.contains(ConstantFtns()
                        .getEnumValue(Order_Status.ORDER_PLACED.toString()))
                    ? true
                    : false,
              ),
              OrderSingleStage(
                primaryText: "Order Confirmed",
                secondaryText: "Your order has been confirmed",
                passedIcon: FontAwesomeIcons.handshake,
                isDone: orderStatus.contains(ConstantFtns()
                        .getEnumValue(Order_Status.ORDER_CONFIRMED.toString()))
                    ? true
                    : false,
              ),
              OrderSingleStage(
                primaryText: "Order Processed",
                secondaryText: "We are prepearing your order",
                passedIcon: FontAwesomeIcons.gift,
                isDone: orderStatus.contains(ConstantFtns()
                        .getEnumValue(Order_Status.ORDER_PROCESSED.toString()))
                    ? true
                    : false,
              ),
              OrderSingleStage(
                primaryText: "Order Dispatched",
                secondaryText:
                    "Your order is dispatched and will be ready for pick up",
                passedIcon: FontAwesomeIcons.truckPickup,
                isDone: orderStatus.contains(ConstantFtns()
                        .getEnumValue(Order_Status.ORDER_DISPATCHED.toString()))
                    ? true
                    : false,
              ),
              OrderSingleStage(
                primaryText: "Order Completed",
                secondaryText: "Order completed successfully",
                passedIcon: FontAwesomeIcons.thumbsUp,
                isDone: false,
              ),
            ],
            indicators: <Widget>[
              Icon(
                FontAwesomeIcons.checkCircle,
                color: orderStatus.contains(ConstantFtns()
                        .getEnumValue(Order_Status.ORDER_PLACED.toString()))
                    ? Colors.blueAccent
                    : Colors.redAccent.withOpacity(0.4),
              ),
              Icon(
                FontAwesomeIcons.checkCircle,
                color: orderStatus.contains(ConstantFtns()
                        .getEnumValue(Order_Status.ORDER_CONFIRMED.toString()))
                    ? Colors.blueAccent
                    : Colors.redAccent.withOpacity(0.4),
              ),
              Icon(
                FontAwesomeIcons.checkCircle,
                color: orderStatus.contains(ConstantFtns()
                        .getEnumValue(Order_Status.ORDER_PROCESSED.toString()))
                    ? Colors.blueAccent
                    : Colors.redAccent.withOpacity(0.4),
              ),
              Icon(
                FontAwesomeIcons.checkCircle,
                color: orderStatus.contains(ConstantFtns()
                        .getEnumValue(Order_Status.ORDER_DISPATCHED.toString()))
                    ? Colors.blueAccent
                    : Colors.redAccent.withOpacity(0.4),
              ),
              Icon(
                FontAwesomeIcons.checkCircle,
                color: orderStatus.contains(ConstantFtns()
                        .getEnumValue(Order_Status.ORDER_COMPLETED.toString()))
                    ? Colors.blueAccent
                    : Colors.redAccent.withOpacity(0.4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class Example10Vertical extends StatelessWidget {
//   const Example10Vertical({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Container(
//         color: Colors.white,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TimelineTile(
//               alignment: TimelineAlign.start,
//               isFirst: true,
//               indicatorStyle: IndicatorStyle(
//                 width: 40,
//                 color: Colors.purple,
//                 padding: const EdgeInsets.all(8),
//                 iconStyle: IconStyle(
//                   color: Colors.white,
//                   iconData: Icons.insert_emoticon,
//                 ),
//               ),
//               endChild: Container(
//                 constraints: const BoxConstraints(
//                   minHeight: 120,
//                 ),
//                 // color: Colors.amberAccent,
// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     Text(
//       "Order placed",
//       style: TextStyle(fontSize: 16),
//     ),
//     Text(
//       "We have received your order",
//       style: TextStyle(fontSize: 12),
//     ),
//   ],
// ),
//               ),
//             ),
//             TimelineTile(
//               alignment: TimelineAlign.start,
//               isLast: true,
//               indicatorStyle: IndicatorStyle(
//                 width: 30,
//                 color: Colors.red,
//                 indicatorXY: 0.7,
//                 iconStyle: IconStyle(
//                   color: Colors.white,
//                   iconData: Icons.thumb_up,
//                 ),
//               ),
//               endChild: Container(
//                 constraints: const BoxConstraints(
//                   minHeight: 80,
//                 ),
//                 color: Colors.lightGreenAccent,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
