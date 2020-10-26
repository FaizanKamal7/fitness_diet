import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/chefOrdersViewmodel.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/orderViewModel.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeading.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardLinkText.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText1.dart';
import 'package:fitness_diet/ui/widgets/circularIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SoleOrderView extends StatefulWidget {
  Order singleOrder;

  SoleOrderView({@required this.singleOrder});
  @override
  _SoleOrderViewState createState() => _SoleOrderViewState();
}

class _SoleOrderViewState extends State<SoleOrderView> {
  // Stream<List<Order>> _orderInfoStream;
  List _updatedStatusList;
  List<int> _statusListValues = [1, 2, 3, 4, 5, 6];
  List<String> _statusListText = [
    "Order Placed   ",
    "Order Processed   ",
    "Order Dispatched   ",
    "Order Completed   ",
    "Order Cancelled   ",
    "Order Failed   ",
  ];
  GlobalKey<SimpleGroupedChipsState<int>> chipKey =
      GlobalKey<SimpleGroupedChipsState<int>>();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<ChefOrdersViewModel>(
      // onModelReady: (model) async {
      //   _orderInfoStream = model.getSingleOrderInfo(widget.singleOrderID);
      // },
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Loading()
          : Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        // ----------------------------------- B A C K G R O U N D    I M A G E
                        Container(
                          margin: EdgeInsets.only(bottom: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(150),
                              bottomRight: Radius.circular(150),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2.00, 3.00),
                                color: Colors.black45,
                                blurRadius: 5,
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/20190503-delish-pineapple-baked-salmon-horizontal-ehg-450-1557771120.jpg?crop=0.669xw:1.00xh;0.173xw,0&resize=640:*",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // ----------------------------------- A P P   B A R   I C O N S
                        Container(
                          margin: EdgeInsets.only(top: 50, left: 30, right: 30),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CircularIcon(
                                  passedIcon: FontAwesomeIcons.chevronLeft,
                                  passedColor: Colors.black87,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                child: CircularIcon(
                                  passedIcon: FontAwesomeIcons.shareAlt,
                                  passedColor: Colors.black87,
                                ),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                child: CircularIcon(
                                  passedIcon: FontAwesomeIcons.solidHeart,
                                  passedColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ----------------------------------- D I S H   H E A D I N G
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 120,
                            width: deviceSize.width,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            padding:
                                EdgeInsets.only(left: 25, top: 20, right: 25),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2.00, 3.00),
                                  color: Colors.black45,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.singleOrder.orderID.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: fontMontserratBold,
                                  ),
                                ),
                                Text(
                                  "Avalaible for order now",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: fontUniSans,
                                  ),
                                ),
                                Row(
                                  children: [
                                    FlutterRatingBarIndicator(
                                      rating: 3.5,
                                      itemCount: 5,
                                      itemSize: deviceSize.height * 0.015,
                                      emptyColor: Colors.brown.withOpacity(0.5),
                                      fillColor: Colors.brown,
                                    ),
                                    Text(
                                      "(3.5)",
                                      style: TextStyle(
                                        fontSize: deviceSize.height * 0.015,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Rs " + widget.singleOrder.total.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: fontLemonMilk,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: ListView(
                        children: [
                          SizedBox(height: 10),

                          // >>>>>>>>>>>>>>>>>>>>>>>>>>  O R D E R   I N F O
                          StandardHeading(passedText: "Order Info"),
                          Divider(thickness: 2),
                          Row(
                            children: [
                              StandardText1(
                                passedDescText: "Order time: ",
                                fontWeight: FontWeight.bold,
                              ),
                              StandardText1(
                                  passedDescText:
                                      widget.singleOrder.orderDate.toString()),
                            ],
                          ),
                          Row(
                            children: [
                              StandardText1(
                                passedDescText: "Address: ",
                                fontWeight: FontWeight.bold,
                              ),
                              StandardText1(
                                passedDescText: widget.singleOrder
                                            .shippingAddress.length ==
                                        0
                                    ? ' '
                                    : widget.singleOrder.shippingAddress["home"]
                                            [0] +
                                        ", " +
                                        widget.singleOrder
                                            .shippingAddress["home"][1] +
                                        ", " +
                                        widget.singleOrder
                                            .shippingAddress["home"][2]
                                            .toString(),
                              ),
                            ],
                          ),

                          // >>>>>>>>>>>>>>>>>>>>>>>>>>  O R D E R   S T A T U S
                          StandardHeading(passedText: "Order Status"),
                          Divider(thickness: 2),
                          StandardText1(
                              passedDescText: "Update order status: "),
                          SimpleGroupedChips<int>(
                            isMultiple: true,
                            preSelection: model.getOrderStatusPreSelectedList(
                                widget.singleOrder),
                            key: chipKey,
                            isScrolling: false,
                            values: _statusListValues,
                            itemTitle: _statusListText,
                            backgroundColorItem: Colors.black26,
                            onItemSelected: (selected) {
                              print("selected " + selected.toString());
                              setState(() {
                                _updatedStatusList = selected;
                              });
                              // _updatedStatusList.add(selected);

                              print(
                                  "---> _updatedStatusList inside checkBox: " +
                                      _updatedStatusList.toString());
                            },
                          ),
                          _updatedStatusList != null
                              ? InkWell(
                                  onTap: () async {
                                    print("--- _updatedStatusList : " +
                                        _updatedStatusList.toString());
                                    bool result = await model.updateOrderStatus(
                                        _updatedStatusList,
                                        widget.singleOrder.orderID);

                                    if (result) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Order status updated successfully ",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Order status updation failed ",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: StandardLinkText(
                                    passedText: "Update status",
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
