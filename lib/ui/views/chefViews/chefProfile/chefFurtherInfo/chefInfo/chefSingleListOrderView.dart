import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadinNoBgSmall.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingSmall.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardLinkText.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChefSingleListOrderView extends StatelessWidget {
  Order singleOrder;
  ChefSingleListOrderView({@required this.singleOrder});
  
  @override
  Widget build(BuildContext context) {
    // final _dishData = Provider.of<List<Dish>>(context);
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(2.00, 3.00),
            color: Colors.black45,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StandardHeadingNoBgSmall(
                  passedText: "Order ID : " + singleOrder.orderID.toString(),
                ),
                Text(
                  "by Customer name here",
                  style: TextStyle(
                    fontFamily: fontUniSans,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text("Order time: 12:10am",
                        style: TextStyle(fontFamily: fontBahnschrift)),
                    Spacer(),
                    StandardHeadingSmall(
                      passedText: singleOrder
                          .orderStatus[singleOrder.orderStatus.length - 1],
                    ),
                  ],
                ),
                StandardLinkText(passedText: "Check order detail"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
