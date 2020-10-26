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
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              height: 110,
              child: Image(
                image: NetworkImage(
                  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/20190503-delish-pineapple-baked-salmon-horizontal-ehg-450-1557771120.jpg?crop=0.669xw:1.00xh;0.173xw,0&resize=640:*",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StandardHeadingNoBgSmall(passedText: "Order Name here"),
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
                          StandardHeadingSmall(passedText: "Active"),
                        ],
                      ),
                      StandardLinkText(passedText: "Check order detail"),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
