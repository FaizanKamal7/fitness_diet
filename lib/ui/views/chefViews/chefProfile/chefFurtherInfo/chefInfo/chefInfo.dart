import 'package:date_format/date_format.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/ui/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChefInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final deviceSize = MediaQuery.of(context).size;
    return StreamBuilder<ChefData>(
      stream: DatabaseService(uid: user.uid).getChefData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ChefData _chefData = snapshot.data;
          return Container(
            //  color: Colors.amber,
            margin: EdgeInsets.only(left: 20),
            height: deviceSize.height * 0.2,
            width: deviceSize.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Constants().standardTextStyle1("Bio: "),
                    Constants().standardTextStyle2(_chefData.chefBio != null
                        ? _chefData.chefBio.toString()
                        : ""),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Constants().standardTextStyle1("Phone no: "),
                    Constants().standardTextStyle2(_chefData.chefPhNo != null
                        ? _chefData.chefPhNo.toString()
                        : ""),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Constants().standardTextStyle1("Date of Birth: "),
                    Constants().standardTextStyle2(_chefData.chefDateOfBirth !=
                            null
                        ? formatDate(
                            _chefData.chefDateOfBirth, [dd, '-', mm, '-', yyyy])
                        : ""),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
