import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/viewmodels/chefViewModels/chefOrdersViewmodel.dart';
import 'package:fitness_diet/ui/shared/colors.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefInfo/chefSingleListOrderView.dart';
import 'package:fitness_diet/ui/views/chefViews/chefProfile/chefFurtherInfo/chefInfo/soleOrderVIew.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardText2.dart';
import 'package:flutter/material.dart';

class ChefOrdersView extends StatefulWidget {
  @override
  _ChefOrdersViewState createState() => _ChefOrdersViewState();
}

class _ChefOrdersViewState extends State<ChefOrdersView> {
  Stream<List<Order>> _allOrderStream;
  String _currentChefID;
  @override
  Widget build(BuildContext context) {
    return BaseView<ChefOrdersViewModel>(
      onModelReady: (model) {
        _allOrderStream = model.getAllOrders();
        _currentChefID = model.getUser;
      },
      builder: (context, model, child) => StreamBuilder<List<Order>>(
        stream: _allOrderStream,
        builder: (context, snapshot) {
          if (model.state == ViewState.Busy) {
            return Loading();
          } else {
            if (snapshot.hasData) {
              final _singleOrder = snapshot.data;
              return Scaffold(
                backgroundColor: colorContentBg2,
                appBar: AppBar(
                  backgroundColor: Colors.brown,
                  title: Text("Order "),
                  shadowColor: Colors.black,
                ),
                body: Container(
                  child: ListView.builder(
                    itemCount: _singleOrder.length,
                    itemBuilder: (context, index) {
                      return _currentChefID == _singleOrder[index].orderID
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SoleOrderView(
                                      singleOrder: _singleOrder[index],
                                    ),
                                  ),
                                );
                              },
                              child: ChefSingleListOrderView(
                                singleOrder: _singleOrder[index],
                              ),
                            )
                          : Center(
                              child: StandardText2(
                                passedDescText: "No orders Yet",
                                fontWeight: FontWeight.normal,
                              ),
                            );
                    },
                  ),
                  // Center(
                  //   child: Text("Orders View"),
                  // ),
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Text("No data loaded"),
              );
            } else {
              return Container(child: Text("No data loaded"));
            }
          }
        },
      ),
    );
  }
}
