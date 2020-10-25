import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/enums/orderStatus.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/dialogService.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/orderViewModel.dart';
import 'package:fitness_diet/locator.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/orderSummaryView.dart';
import 'package:fitness_diet/ui/views/custViews/orderView.dart';
import 'package:fitness_diet/ui/widgets/Buttons/bigLightGreenBtn.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardReceiptBigText.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardReceptSmallText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ReceiptContainer extends StatefulWidget {
  bool isCartViewReceipt;
  Map<String, dynamic> shippingAddr;
  ReceiptContainer({@required this.isCartViewReceipt, this.shippingAddr});
  @override
  _ReceiptContainerState createState() => _ReceiptContainerState();
}

double deliveryFee = 60;

class _ReceiptContainerState extends State<ReceiptContainer> {
  DialogService _dialogService = locator<DialogService>();
  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<Cart>(context);
    final _dishData = Provider.of<List<Dish>>(context);
    // final _dishData = Provider.of<List<Product>>(context);
    final _custData = Provider.of<CustData>(context);

    double subtotal = ConstantFtns().getTotal(_custData, _cart, _dishData);
    Widget navigateToOrderViewBtn = InkWell(
      onTap: () {
        // bool check =
        //     verifyinvetory(_cart.items, _dishData, _custData.cartID);
        // if (check) {
        print(
            '----------------------- go to Order view from receipt container --------------');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OrderView(),
          ),
        );
        // } else {
        //   _dialogService.showDialog(
        //       title: 'Alert :(',
        //       description:
        //           "we are sory the product is not available in the quantity you requested ...",
        //       buttonTitle: "its ok ",
        //       dialogType: Dialog_Types.PLAN_SUCCESS);
        // }
      },
      child: BigLightGreenBtn(
        passedText: "Checkout",
        isDisabled: false,
      ),
    );

    return BaseView<OrderViewModel>(
      onModelReady: (model) {
        // model.verifyInventory(_cart.items, _dishData, _cart.cartid);
      },
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, deviceSize) => Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: deviceSize.height * 0.25,
            width: deviceSize.width,
            padding: EdgeInsets.symmetric(horizontal: 27),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.00, 3.00),
                  color: Colors.black,
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(42),
                topRight: Radius.circular(42),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StandardReceiptSmallText(
                  passedText: "Sub-total: ",
                  passedPrice: subtotal.toString(),
                ),
                // StandardReceiptSmallText(
                //   passedText: "Total Saved:",
                //   passedPrice:
                //       getTotalSaved(_custData, _cart, _cart, _dishData)
                //           .toString(),
                // ),
                StandardReceiptSmallText(
                  passedText: "Delivery fee: ",
                  passedPrice: subtotal > 4000 ? '0' : deliveryFee.toString(),
                ),
                StandardReceiptBigText(
                  passedText: "Total",
                  passedPrice: (subtotal + deliveryFee).toString(),

                  // subtotal -
                  //             getTotalSaved(
                  //                 _custData, _cart, _cart, _dishData) >
                  //         4000
                  //     ? (subtotal -
                  //             getTotalSaved(
                  //                 _custData, _cart, _cart, _dishData))
                  //         .toString()
                  //     : ((subtotal -
                  //                 getTotalSaved(_custData, _cart, _cart,
                  //                     _dishData)) +
                  //             deliveryFee)
                  //         .toString(),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 5.0,
                ),
                // Divider(
                //   height: 10.0,
                //   indent: 3.0,
                //   endIndent: 20.0,
                //   thickness: 2.0,
                //   color: Colors.grey[300],
                // ),
                SizedBox(height: 3.0),
                _custData != null
                    ? _cart.items.length != 0
                        ? widget.isCartViewReceipt
                            ? navigateToOrderViewBtn
                            : InkWell(
                                onTap: () async {
                                  // await model.verifyInventory(
                                  //     _cart.items, _dishData, _cart.cartid);

                                  print(
                                      '---------------->user cart items after verify inventory in order view ' +
                                          _cart.items.length.toString());

                                  double _total = subtotal + deliveryFee;
                                  // subtotal > 4000
                                  // ? (subtotal -
                                  //     getTotalSaved(_custData, _cart,
                                  //         _cart, _dishData))
                                  // : ((subtotal -
                                  //         getTotalSaved(_custData, _cart,
                                  //             _cart, _dishData)) +
                                  //     deliveryFee);
                                  print(
                                      " ===> widget.shippingAddr inside OrderView : " +
                                          widget.shippingAddr.toString());
                                  // _custData.address.keys.

                                  if (widget.shippingAddr != null &&
                                      _custData.custPhNo != null) {
                                    // bool check = verifyinvetory(_cart.items,
                                    //     _dishData, _custData.cartID);
                                    // if (check == false) {
                                    //   _dialogService.showDialog(
                                    //       title: 'Alert :(',
                                    //       description:
                                    //           "we are sory the product is not available in the quantity you requested ...",
                                    //       buttonTitle: "its ok ",
                                    //       dialogType:
                                    //           Dialog_Types.PLAN_SUCCESS);
                                    // } else {
                                    String orderID = await model.createOrder(
                                      _custData.custId,
                                      _custData.custName,
                                      widget.shippingAddr,
                                      _custData.custPhNo,
                                      [
                                        ConstantFtns().getEnumValue(Order_Status
                                            .ORDER_PLACED
                                            .toString())
                                      ],
                                      _cart.items,
                                      _dishData,
                                      _total,
                                      _custData.cartID,
                                    );

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderSummaryView(
                                          orderID: orderID,
                                          orderStatus: [
                                            ConstantFtns().getEnumValue(
                                                Order_Status.ORDER_PLACED
                                                    .toString())
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    if (widget.shippingAddr == null) {
                                      // _showAlert(context, 'Address ',
                                      // 'Address not found Kindly enter a valid address');
                                    } else {
                                      // _showAlert(context, 'Contact Number',
                                      //     'contact number not found ,Enter a valid contact number ');
                                    }
                                  }
                                },
                                child: BigLightGreenBtn(
                                  passedText: "Place order",
                                  isDisabled: false,
                                ),
                              )
                        : BigLightGreenBtn(
                            passedText: "Add items first",
                            isDisabled: true,
                          )
                    : _cart.items.length != 0
                        ? widget.isCartViewReceipt
                            ? navigateToOrderViewBtn
                            : BigLightGreenBtn(
                                passedText: "Sign-in required",
                                isDisabled: true,
                              )
                        : BigLightGreenBtn(
                            passedText: "Place order",
                            isDisabled: true,
                          ),
                // Row(
                //   children: [
                //     Container(
                //       width: 50.0,
                //     ),
                //     Expanded(
                //       child: Container(
                //         height: 40.0,
                //         decoration: BoxDecoration(
                //           color: Colors.green,
                //           borderRadius: BorderRadius.circular(50.0),
                //         ),
                //         child: Center(
                //           child: InkWell(
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => OrderView()),
                //               );
                //               // model..goToOrderView(),
                //             },
                //             child: Text(
                //               'Checkout',
                //               overflow: TextOverflow.ellipsis,
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 20.0,
                //                 fontWeight: FontWeight.w400,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     Container(
                //       width: 50.0,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}