import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/ui/views/custViews/custProfile/custProfile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustProfileMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<CustData>.value(
          value: DatabaseService(uid: user.uid).getCustData,
        )
      ],
      child: MaterialApp(
        home: CustProfile(),
      ),
    );
  }
}
