import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/database.dart';
import 'package:fitness_diet/core/viewmodels/baseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustProfileViewModel extends BaseViewModel {
  CustData _custData;
  // Future <CustData> fetchCustData(String userID) async{
   

  //    Stream xyz =   DatabaseService(uid: userID).getCustData,
      
  //     // stream: ,
  //     // builder: (context, snapshot) {
  //     //   if (snapshot.hasData && !snapshot.hasError) {
  //     //     _custData = snapshot.data;
  //     //     return _custData;
  //     //   }
  //     // },
    
  //   // Stream<CustData> fetchData(String userID) {
  //   //   setState(ViewState.Busy);

  //   //   Stream<CustData> custData = DatabaseService(uid: userID).getCustData;
  //   //   setState(ViewState.Idle);
  //   //   print("Custdata from Stream: " + custData.toString());
  //   //   return custData;
  //   // }
  // }
}
