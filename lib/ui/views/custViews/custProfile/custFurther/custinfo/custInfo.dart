import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/viewmodels/custViewModels/custProfileViewModel/custInfoViewModel/custInfoViewModel.dart';
import 'package:fitness_diet/ui/responsive/responsiveSafeArea.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/addAddressView.dart';
import 'package:fitness_diet/ui/widgets/custOrders.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingwithBGandRoundCorner.dart';
import 'package:fitness_diet/ui/widgets/standardInfoDisplayWithBullets.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CustInfo extends StatelessWidget {
  static List FoodCatgSectionItemList = [
    {'Name': "Biryani", "Pic": "assets/images/biryani.jpg"},
    {'Name': "Nihari", "Pic": "assets/images/nihari.jpg"},
    {'Name': "Kebab", "Pic": "assets/images/biryani.jpg"},
    {'Name': "Chicken", "Pic": "assets/images/cover.jpg"},
  ];
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

  void _showEditaddressBottomSheet(BuildContext _context, String title) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: _context,
      isScrollControlled: true,
      elevation: 20,
      builder: (context) {
        return AddAddressView(
          addressTitle: title,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _custData = Provider.of<CustData>(context);
    final _custOrders = Provider.of<List<Order>>(context);

    final _planData = Provider.of<Plan>(context);
    return BaseView<CustInfoViewModel>(
      builder: (context, model, child) => ResponsiveSafeArea(
        builder: (context, widgetSize) => Container(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: widgetSize.width * 0.02),
                child: Text(
                  "Following  0  chefs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "UniSansSemiBold",
                    fontSize: widgetSize.height * 0.04,
                    color: Color(0xff2a6427).withOpacity(0.75),
                  ),
                ),
              ),
              SizedBox(
                height: widgetSize.height * 0.03,
              ),
              Container(
                margin: EdgeInsets.only(left: widgetSize.width * 0.1),
                child: Column(
                  children: <Widget>[
                    standardInfDisplaywithBullets(
                        'Contact No : ', _custData.custContactNo, deviceSize),
                    // standardInfDisplaywithBullets('Data of birth : ',
                    //     model.parseDate(_custData.custDateOfBirth), deviceSize),
                    standardInfDisplaywithBullets('Address :', '', deviceSize),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _custData.custaddress != null
                          ? _custData.custaddress.length
                          : 0,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Flexible(
                              child: standardInfDisplaywithBullets(
                                  _custData.custaddress.keys
                                      .elementAt(index)
                                      .toString(),
                                  _custData.custaddress.values
                                      .elementAt(index)
                                      .toString()
                                      .substring(
                                          1,
                                          _custData.custaddress.values
                                                  .elementAt(index)
                                                  .toString()
                                                  .length -
                                              1),
                                  deviceSize),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                print('******** Edit custaddress presed :');
                                _showEditaddressBottomSheet(
                                    context,
                                    _custData.custaddress.keys
                                        .elementAt(index)
                                        .toString());
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_forever_outlined),
                              onPressed: () {
                                print('********** remove address presed :');

                                model.removeAddress(
                                  _custData.custId,
                                  _custData.custaddress.keys
                                      .elementAt(index)
                                      .toString(),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    FlatButton(
                      onPressed: () {
                        print('add address presed :');
                        _showAddressBottomSheet(context);
                      },
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Add address",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 15,
                              color: Color(0xff3caa43),
                            ),
                          )),
                    ),
                  ],
                ),
              ),

              SizedBox(height: widgetSize.height * 0.06),
              standardHeadingWithBGAndRoundCorner(passedText: "Orders"),

              SizedBox(
                height: widgetSize.height * 0.02,
              ),

              //>>>>>>> F  A V O RU R I T E S --- D I S H E S I
              _custOrders != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _custOrders != null ? _custOrders.length : 0,
                      itemBuilder: (context, index) {
                        // return Container(
                        //   child: Text(_custOrders[index].orderID.toString()),
                        // );
                        return CustOrders(
                            orderID: _custOrders[index].orderID,
                            noOfItems: _custOrders[index].items.length,
                            total: _custOrders[index].total,
                            orderDate: _custOrders[index].orderDate,
                            orderStatus: _custOrders[index].orderStatus);
                      },
                    )
                  : Center(
                      child: Text("No orders yet!"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
