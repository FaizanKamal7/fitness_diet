import 'package:fitness_diet/core/constants/ConstantFtns.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/orderViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/shared/fonts.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/ReceiptContainer.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/addAddressView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/addPhoneNoViewSheet.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingBig.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingSmall.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText1.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText2.dart';
import 'package:fitness_diet/ui/widgets/radioItemCustom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

void _showAddressBottomSheet(BuildContext _context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: _context,
    isScrollControlled: true,
    elevation: 20,
    builder: (context) {
      return AddAddressView();
    },
  );
}

void _showphoneBottomSheet(BuildContext _context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: _context,
    isScrollControlled: true,
    elevation: 20,
    builder: (context) {
      return AddPhoneNoSheet();
    },
  );
}

class _OrderViewState extends State<OrderView> {
  String _addrSelectedTitle;
  @override
  Widget build(BuildContext context) {
    final _custdata = Provider.of<CustData>(context);
    final _cart = Provider.of<Cart>(context);
    final _dishData = Provider.of<List<Dish>>(context);
    // final _productData = Provider.of<List<Product>>(context);
    // final _cart = Provider.of<Cart>(context);

    // double subtotal = ConstantFtns().getTotal(_custdata, _cart, _dishData);

    // int deliveryFee = 60;
    print("---> _custdata inside OrderView :" + _custdata.toString());
    print('---------------------------address length ' +
        _custdata.custaddress.length.toString());
    return BaseView<OrderViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, deviceSize) => Material(
          color: Color(0xffF5F5F5),
          child: Stack(
            children: [
              // Container(
              // margin: EdgeInsets.only(
              //     bottom: deviceSize.height * 0.25, left: 10, right: 10),
              // ----------------------------------------- O R D E R   C O N T E N T  F O R   S I G N E D - I N  U S E R S
              _custdata != null
                  ? ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        SizedBox(height: 70),
                        StandardHeadingBigBlack(
                            passedText: "You're almost \nthere"),
                        StandardText1(passedDescText: "Confirm your info"),
                        SizedBox(height: 27),
                        StandardHeadingSmall(passedText: "SHIPPING DETAILS"),
                        Divider(
                          thickness: 1,
                          color: Color(0xff69AA6C),
                        ),
                        // >>>>>>>>>>>>>>>>>>>>> Customer details
                        Row(
                          children: [
                            StandardText2(
                              passedDescText: "Name: ",
                              fontWeight: FontWeight.bold,
                            ),
                            StandardText2(
                              passedDescText: _custdata.custName,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                        SizedBox(height: 0),
                        Row(
                          children: [
                            StandardText2(
                              passedDescText: "Contact: ",
                              fontWeight: FontWeight.bold,
                            ),
                            _custdata.custPhNo != ''
                                ? StandardText2(
                                    passedDescText: _custdata.custPhNo,
                                    fontWeight: FontWeight.normal)
                                : InkWell(
                                    onTap: () {
                                      print('add address presed :');
                                      _showphoneBottomSheet(context);
                                    },
                                    child: Text(
                                      "Add contact no",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: fontUniSans,
                                        fontSize: 12,
                                        color: Color(0xff0e8fff),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        StandardText2(
                          passedDescText: "Shipping address: ",
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 10),
                        // >>>>>>>>>>>>>>>>>>>>>>> Address radio buttons

                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _custdata.custaddress.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                _addrSelectedTitle =
                                    _custdata.custaddress.keys.elementAt(index);
                              });
                              print("------> _addrSelectedTitle: " +
                                  _addrSelectedTitle.toString());
                            },
                            child: RadioItemCustom(
                              addrTitle:
                                  _custdata.custaddress.keys.elementAt(index),
                              addrText: _custdata.custaddress.values
                                  .elementAt(index)
                                  .toString(),
                              isSelected: _addrSelectedTitle ==
                                      _custdata.custaddress.keys
                                          .elementAt(index)
                                  ? true
                                  : false,
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        Text(
                          "Edit existing",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: fontUniSans,
                            fontSize: 12,
                            color: Color(0xff0e8fff),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(height: 5),
                        InkWell(
                          onTap: () {
                            print('add address presed :');
                            _showAddressBottomSheet(context);
                          },
                          child: Text(
                            "Add new address",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: fontUniSans,
                              fontSize: 12,
                              color: Color(0xff0e8fff),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        // >>>>>>>>>>>>>>>>>>>>> Payment details
                        // SizedBox(height: 15),
                        // StandardHeadingSmall(passedText: "PAYMENT DETAILS"),
                        // Divider(
                        //   thickness: 1,
                        //   color: Color(0xff69AA6C),
                        //   endIndent: 30,
                        // ),
                        // SizedBox(height: 5),
                        // StandardText2(
                        //   passedDescText:
                        //       "Payment will be received via cash on delivery",
                        //   fontWeight: FontWeight.normal,
                        // ),
                        // SizedBox(height: 15),

                        //>>>>>>>>>>>>>>>>>>>>>>>>>>>>  O R D E R I T E M

                        SizedBox(height: 15),
                        StandardHeadingSmall(passedText: "YOUR ORDER"),
                        Divider(
                          thickness: 1,
                          color: Color(0xff69AA6C),
                          endIndent: 30,
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.center,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _dishData.length,
                            itemBuilder: (context, index) => _cart.items.keys
                                    .contains(_dishData[index].dishID)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StandardText2(
                                        passedDescText:
                                            _dishData[index].dishName,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      StandardText2(
                                        passedDescText: ConstantFtns()
                                            .getquantity(_cart.items,
                                                _dishData[index].dishID)
                                            .toString(),
                                        fontWeight: FontWeight.normal,
                                      ),
                                      StandardText2(
                                        passedDescText: _dishData[index]
                                            .dishPrice
                                            .toString(),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 0.0,
                                  ),
                          ),
                        ),

                        SizedBox(height: 15),
                      ],
                    )
                  // ----------------------------------------- O R D E R   C O N T E N T  F O R   O F F L I N E  U S E R S
                  : ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        SizedBox(height: 70),
                        StandardHeadingBigBlack(
                            passedText: "You're almost \nthere"),
                        StandardText1(passedDescText: "Confirm your info"),
                        SizedBox(height: 27),
                        StandardHeadingSmall(passedText: "SHIPPING DETAILS"),
                        Divider(
                          thickness: 1,
                          color: Color(0xff69AA6C),
                        ),
                        SizedBox(height: 27),
                        Center(
                          child: StandardText2(
                            passedDescText:
                                "ّYou must sign-in before placing an order",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () => model.goToSignIn(),
                          child: Text(
                            "Sign-in now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: fontUniSans,
                              fontSize: 12,
                              color: Color(0xff0e8fff),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
              // ),
              // ----------------------------------------- R E C E I P T
              Align(
                alignment: Alignment.bottomCenter,
                child:
                    // Container(
                    //   height: deviceSize.height * 0.25,
                    //   width: deviceSize.width,
                    //   padding: EdgeInsets.symmetric(horizontal: 27),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         offset: Offset(0.00, 3.00),
                    //         color: Colors.black,
                    //         blurRadius: 6,
                    //       ),
                    //     ],
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(42),
                    //       topRight: Radius.circular(42),
                    //     ),
                    //   ),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       StandardReceiptSmallText(
                    //         passedText: "Sub-total: ",
                    //         passedPrice: subtotal.toString(),
                    //       ),
                    //       StandardReceiptSmallText(
                    //         passedText: "Total Saved: ",
                    //         passedPrice: getTotalSaved(
                    //                 _custdata, _cart, _cart, _dishData)
                    //             .toString(),
                    //       ),
                    //       StandardReceiptSmallText(
                    //         passedText: "Delivery fee: ",
                    //         passedPrice:
                    //             subtotal > 4000 ? '0' : deliveryFee.toString(),
                    //       ),
                    //       StandardReceiptBigText(
                    //         passedText: "Total: ",
                    //         passedPrice: subtotal -
                    //                     getTotalSaved(_custdata, _cart, _cart,
                    //                         _productData) >
                    //                 4000
                    //             ? (subtotal -
                    //                     getTotalSaved(_custdata, _cart, _cart,
                    //                         _productData))
                    //                 .toString()
                    //             : ((subtotal -
                    //                         getTotalSaved(_custdata, _cart,
                    //                             _cart, _productData)) +
                    //                     deliveryFee)
                    //                 .toString(),
                    //       ),
                    //       SizedBox(height: 10),
                    //       _custdata != null
                    //           ? InkWell(
                    //               onTap: () {
                    //                 Map<String, dynamic> _shippingAddr = {
                    //                   _addrSelectedTitle:
                    //                       _custdata.address[_addrSelectedTitle]
                    //                 };
                    //                 double _total = subtotal > 4000
                    //                     ? (subtotal -
                    //                         getTotalSaved(_custdata, _cart,
                    //                             _cart, _productData))
                    //                     : ((subtotal -
                    //                             getTotalSaved(_custdata, _cart,
                    //                                 _cart, _productData)) +
                    //                         deliveryFee);
                    //                 print(
                    //                     " ===> _shippingAddr inside OrderView : " +
                    //                         _shippingAddr.toString());
                    //                 // _custdata.address.keys.

                    //                 if (_addrSelectedTitle != null &&
                    //                     _custdata.custPhNo != null) {
                    //                   model.createOrder(
                    //                       _custdata.custId,
                    //                       _custdata.custName,
                    //                       _shippingAddr,
                    //                       _custdata.custPhNo,
                    //                       [
                    //                         getEnumValue(Order_Status.ORDER_PLACED
                    //                             .toString())
                    //                       ],
                    //                       _cart.items,
                    //                       _total,
                    //                       _custdata.cartID);

                    //                   Navigator.pushReplacement(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                       builder: (context) => OrderSummaryView(),
                    //                     ),
                    //                   );
                    //                 } else {
                    //                   if (_addrSelectedTitle == null) {
                    //                     _showAlert(context, 'Address ',
                    //                         'Address not found Kindly enter a valid address');
                    //                   } else {
                    //                     _showAlert(context, 'Contact Number',
                    //                         'contact number not found ,Enter a valid contact number ');
                    //                   }
                    //                 }
                    //               },
                    //               child: BigLightGreenBtn(
                    //                 passedText: "Place order",
                    //                 isDisabled: false,
                    //               ),
                    //             )
                    //           : BigLightGreenBtn(
                    //               passedText: "Place order",
                    //               isDisabled: true,
                    //             ),
                    //     ],
                    //   ),
                    // ),

                    ReceiptContainer(
                  isCartViewReceipt: false,
                  shippingAddr: _custdata != null
                      ? {
                          _addrSelectedTitle:
                              _custdata.custaddress[_addrSelectedTitle]
                        }
                      : {},
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     height: deviceSize.height * 0.25,
                //     width: deviceSize.width,
                //     padding: EdgeInsets.symmetric(horizontal: 27),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //           offset: Offset(0.00, 3.00),
                //           color: Colors.black,
                //           blurRadius: 6,
                //         ),
                //       ],
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(42),
                //         topRight: Radius.circular(42),
                //       ),
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         StandardReceiptSmallText(
                //           passedText: "Sub-total: ",
                //           passedPrice: subtotal.toString(),
                //         ),
                //         StandardReceiptSmallText(
                //           passedText: "Total Saved: ",
                //           passedPrice: getTotalSaved(
                //                   _custdata, _cart, _cart, _productData)
                //               .toString(),
                //         ),
                //         StandardReceiptSmallText(
                //           passedText: "Delivery fee: ",
                //           passedPrice:
                //               subtotal > 4000 ? '0' : deliveryFee.toString(),
                //         ),
                //         StandardReceiptBigText(
                //           passedText: "Total: ",
                //           passedPrice: subtotal -
                //                       getTotalSaved(_custdata, _cart, _cart,
                //                           _productData) >
                //                   4000
                //               ? (subtotal -
                //                       getTotalSaved(_custdata, _cart, _cart,
                //                           _productData))
                //                   .toString()
                //               : ((subtotal -
                //                           getTotalSaved(_custdata, _cart,
                //                               _cart, _productData)) +
                //                       deliveryFee)
                //                   .toString(),
                //         ),
                //         SizedBox(height: 10),

                //         // _custdata != null
                //         //     ? InkWell(
                //         //         onTap: () {
                //         //           Map<String, dynamic> _shippingAddr = {
                //         //             _addrSelectedTitle:
                //         //                 _custdata.address[_addrSelectedTitle]
                //         //           };
                //         //           double _total = subtotal > 4000
                //         //               ? (subtotal -
                //         //                   getTotalSaved(_custdata, _cart,
                //         //                       _cart, _productData))
                //         //               : ((subtotal -
                //         //                       getTotalSaved(_custdata, _cart,
                //         //                           _cart, _productData)) +
                //         //                   deliveryFee);
                //         //           print(
                //         //               " ===> _shippingAddr inside OrderView : " +
                //         //                   _shippingAddr.toString());
                //         //           // _custdata.address.keys.

                //         //           if (_addrSelectedTitle != null &&
                //         //               _custdata.custPhNo != null) {
                //         //             model.createOrder(
                //         //                 _custdata.custId,
                //         //                 _custdata.custName,
                //         //                 _shippingAddr,
                //         //                 _custdata.custPhNo,
                //         //                 [
                //         //                   getEnumValue(Order_Status.ORDER_PLACED
                //         //                       .toString())
                //         //                 ],
                //         //                 _cart.items,
                //         //                 _total,
                //         //                 _custdata.cartID);

                //         //             Navigator.pushReplacement(
                //         //               context,
                //         //               MaterialPageRoute(
                //         //                 builder: (context) => OrderSummaryView(),
                //         //               ),
                //         //             );
                //         //           } else {
                //         //             if (_addrSelectedTitle == null) {
                //         //               _showAlert(context, 'Address ',
                //         //                   'Address not found Kindly enter a valid address');
                //         //             } else {
                //         //               _showAlert(context, 'Contact Number',
                //         //                   'contact number not found ,Enter a valid contact number ');
                //         //             }
                //         //           }
                //         //         },
                //         //         child: BigLightGreenBtn(
                //         //           passedText: "Place order",
                //         //           isDisabled: false,
                //         //         ),
                //         //       )
                //         //     : BigLightGreenBtn(
                //         //         passedText: "Place order",
                //         //         isDisabled: true,
                //         //       ),
                //       ],
                //     ),
                //   ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showAlert(BuildContext context, String title, String desc) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(desc),
          ));
}
