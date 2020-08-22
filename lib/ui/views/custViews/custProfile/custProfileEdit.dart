// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:date_format/date_format.dart';

// class CustProfileEdit extends StatefulWidget {
//   @override
//   _CustProfileEditState createState() => _CustProfileEditState();
// }

// class _CustProfileEditState extends State<CustProfileEdit> {
//   String _custNameController;
//   String _custResdController;
//   // DateTime _dateOfBirth;
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<User>(context);
//     final deviceSize = MediaQuery.of(context).size;
//     return StreamBuilder<CustData>(
//       stream: DatabaseService(uid: user.uid).getCustData,
//       builder: (context, snapshot) {
//         CustData _custData = snapshot.data;

//         return Form(
//           key: _formKey,
//           child: Container(
//             color: Constants().mainBgColor,
//             padding: EdgeInsets.all(30),
//             height: deviceSize.height * 0.8,
//             child: ListView(
//               children: <Widget>[
//                 // ---------------------------------------------------- H E A D E R   T E X T
//                 Text(
//                   "Edit your profile",
//                   style: TextStyle(
//                     color: Constants().headerTextColor1,
//                     fontSize: 25,
//                     fontFamily: "Montserrat",
//                   ),
//                 ),
//                 // ---------------------------------------------------- C U S T    P R O F I L E   C H A N G E
//                 Container(
//                   margin: EdgeInsets.only(top: 30),
//                   child: Row(
//                     children: <Widget>[
//                       ClipOval(
//                         child: Image.asset(
//                           "lib/assets/images/chef2.JPG",
//                           height: deviceSize.height * 0.12,
//                           width: deviceSize.width * 0.2,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       FlatButton(
//                         onPressed: () => HomePage(),
//                         child: Text("Change profile picture"),
//                       )
//                     ],
//                   ),
//                 ),
//                 // ---------------------------------------------------- E D I T   C U S T    I N F O
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     //
//                     // >>>>>>>>> U S E R N A M E    L A B E L
//                     //
//                     Container(
//                       margin: EdgeInsets.only(top: 30),
//                       child: Text(
//                         "Enter username: ",
//                         style: TextStyle(
//                           color: Constants().headerTextColor1,
//                         ),
//                       ),
//                     ),
//                     //
//                     // >>>>>>>>> U S E R N A M E   T E X T F E I L D
//                     //
//                     TextFormField(
//                       initialValue: _custData.custName,
//                       validator: (val) =>
//                           val.isEmpty ? 'Please enter the username' : null,
//                       onChanged: (val) =>
//                           setState(() => _custNameController = val),
//                       decoration: InputDecoration(
//                           fillColor: Colors.grey,
//                           filled: false,
//                           hintText: "Enter your name "),
//                     ),
//                     //
//                     // >>>>>>>>> R E S I D E N C E    L A B E L
//                     //
//                     Container(
//                       margin: EdgeInsets.only(top: 10),
//                       child: Text(
//                         "Change Residence: ",
//                         style: TextStyle(
//                           color: Constants().headerTextColor1,
//                         ),
//                       ),
//                     ),
//                     //
//                     // >>>>>>>>> R E S I D E N C E   T E X T F E I L D
//                     //
//                     TextFormField(
//                       initialValue: "_custData.residence",
//                       validator: (val) =>
//                           val.isEmpty ? 'Please enter the username' : null,
//                       onChanged: (val) =>
//                           setState(() => _custResdController = val),
//                       decoration: InputDecoration(
//                           fillColor: Colors.grey,
//                           filled: false,
//                           hintText: "Add your location "),
//                     ),

//                     //
//                     // >>>>>>>>> D A T E   O F   B I R T H   D R O P D O W N
//                     //
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(top: 10),
//                           child: Text(
//                             "Change date of birth: ",
//                             style: TextStyle(
//                               color: Constants().headerTextColor1,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Container(),
//                             // Container(
//                             //   child: Text(_dateOfBirth == null
//                             //       ? _custData.dateOfBirth.toString()
//                             //       : formatDate(
//                             //           _dateOfBirth, [dd, '-', mm, '-', yyyy])),
//                             // ),
//                             // Spacer(),
//                             // FlatButton(
//                             //   onPressed: () {
//                             //     showDatePicker(
//                             //       context: context,
//                             //       initialDate: DateTime.now(),
//                             //       firstDate: DateTime(1950),
//                             //       lastDate: DateTime.now(),
//                             //     ).then((date) {
//                             //       setState(() {
//                             //         _dateOfBirth = date;
//                             //       });
//                             //     });
//                             //   },
//                             //   child: Icon(Icons.calendar_today),
//                             // ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     // Container(
//                     //   padding: EdgeInsets.only(top: 10, bottom: 10),
//                     //   child: Row(
//                     //     children: <Widget>[
//                     //       Text("Date of birth: "),
//                     //       Text(_date == null ? "Old DOB" : _date.toString()),
//                     //       Spacer(),
//                     //       InkResponse(
//                     //         onTap: () => _selectDate(context),
//                     //         child: Icon(Icons.calendar_today),
//                     //       )
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),

//                 // ---------------------------------------------------- D O N E   B U T T O N
//                 FlatButton(
//                   onPressed: () async {
//                     if (_formKey.currentState.validate()) {
//                       await DatabaseService(uid: user.uid).updateCustData({
//                         'custName': _custNameController ?? _custData.custName,
//                         //      _custResdController ?? _custData.residence,
//                         //  _dateOfBirth ?? _custData.dateOfBirth,
//                       });
//                       Navigator.pop(context);
//                     }
//                   },
//                   child: Container(
//                     width: deviceSize.width * 0.3,
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.green.withOpacity(0.8),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(30),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Done",
//                         style: TextStyle(
//                             color: Constants().headerTextColor1,
//                             fontFamily: 'Montserrat'),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
