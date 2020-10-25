import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustProfileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);

    var custStreamProvider;
    var planStreamProvider;
    var ordersStreamProvider;

    try {
      custStreamProvider = StreamProvider<CustData>.value(
          value: DatabaseService(uid: user.uid).getCustData);
      planStreamProvider = StreamProvider<Plan>.value(
          value: DatabaseService(uid: user.uid).getPlanData);
      ordersStreamProvider = StreamProvider<List<Order>>.value(
          value: DatabaseService(uid: user != null ? user.uid : null)
              .getCustOrderData());
    } catch (e) {
      print("--------> Error in custProfileMain: " + e.toString());
    }
    return MultiProvider(
      providers: [custStreamProvider, planStreamProvider, ordersStreamProvider],
      child: MaterialApp(
        home: CustProfile(),
        //   ),
      ),
    );
  }
}
