import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_diet/core/models/cart.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/exercise.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/dbHelperFtns.dart';

class DatabaseService {
  // collection reference is just reference for certain collection

  final CollectionReference chefCollection =
      FirebaseFirestore.instance.collection('chef');
  final CollectionReference dishCollection =
      FirebaseFirestore.instance.collection('dish');
  final CollectionReference dishCtgCollection =
      FirebaseFirestore.instance.collection('dishCategory');
  final CollectionReference dishAttrCollection =
      FirebaseFirestore.instance.collection('attribute');
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');
  final CollectionReference custCollection =
      FirebaseFirestore.instance.collection('customer');
  final CollectionReference planCollection =
      FirebaseFirestore.instance.collection('plan');
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('order');
  final CollectionReference exerciseCollection =
      FirebaseFirestore.instance.collection('exercise');

  final String uid;
  DatabaseService({this.uid});
// ============================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   C U S T O M E R   D A T A
// ============================================================================================================
  //
  // >>>>>>>>>>>>>>>> S E T T I N G   D A T A
  //
  Future<bool> addNewCustData(Map<String, dynamic> dataMap) async {
    print("---------> DataBase services class reached. Updating user for uid" +
        uid.toString());
    // - Setting ID first in a doc

    Map<String, List<String>> address = {};
    await custCollection.doc(uid).set(
      {
        'custID': uid,
        'custAddDate': DateTime.now(),
        'custAddress': address,
      },
      SetOptions(merge: true),
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await custCollection.doc(uid).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
    return true;
  }

  Future<bool> updateCustData(
      Map<String, dynamic> dataMap, String custID) async {
    print(
        "---------> DataBase services class reached. Updating user for uid : " +
            uid.toString());

    // - Setting ID first in a doc
    await custCollection.doc(custID).set(
      {
        'custUpdateDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await custCollection.doc(custID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
    return true;
  }

  //-------------- address
  Future updateCustAddress(String custID, String title, String houseno,
      String street, String city) async {
    print('inside update address function  in  data base');
    await custCollection.doc(custID).set(
      {
        'custAddress': {
          title: [houseno, street, city]
        },
      },
      SetOptions(merge: true),
    );
  }

  // ignore: missing_return
  Future removeCustAddress(String custID, String title) {
    print('********** inside remove address in database :' + title.toString());
    custCollection.doc(custID).set(
      {
        'custAddress': {title: FieldValue.delete()}
      },
      SetOptions(merge: true),
    );
  }

  //
  // >>>>>>>>>>>>>>>> G E T T I N G   D A T A
  //
  CustData _custDataFromSnapshot(DocumentSnapshot snapshot) {
    print(
        " UiD DB TEST function reached in data fromsnapshot ******************** data " +
            uid);

    return CustData(
      custId: uid,
      custPhNo: snapshot.data()['custPhNo'] ?? "load",
      custName: snapshot.data()['custName'] ?? "load",
      custDateOfBirth:
          (snapshot.data()['custDateOfBirth'] as Timestamp).toDate() ?? "",
      // custfavs: snapshot.data()['custfavs'] ?? "",

      custaddress: snapshot.data()['custAddress'] ?? '',
      custContactNo: snapshot.data()['custContactNo'] ?? '',
      // custFollowing: snapshot.data()['custFollowing'] ?? "",
      planID: snapshot.data()['planID'] ?? "",
      custPic: snapshot.data()['custPic'] ?? "",
      cartID: snapshot.data()['cartID'] ?? "",
      // custOrders: snapshot.data()['custOrders'] ?? "",
    );
  }

  // Get user doc stream
  Stream<CustData> get getCustData {
    print(" UiD DB TEST function reached in getcust data******************** ");
    return custCollection.doc(uid).snapshots().map(_custDataFromSnapshot);
  }
// ===========================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   C H E F  D A T A
// ===========================================================================================================

  Future addNewChefData(Map<String, dynamic> dataMap) async {
    // });
    print("UID in Database class_+_+__+_+_+_++_+: " + uid.toString());

    // - Statically adding date in the db
    await chefCollection.doc(uid).set(
      {
        'chefID': uid,
        'chefAddDate': DateTime.now(),
        'hasDish': false, // Jugar
      },
      SetOptions(merge: true),
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await chefCollection.doc(uid).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }

  Future updateChefData(Map<String, dynamic> dataMap, String chefID) async {
    // });
    print("UID in Database class_+_+__+_+_+_++_+: " + uid.toString());
    // - Statically adding date in the db

    // -------------- NOT A RELAIBLE SOLUTION, PLEASE CHANGE IN FUTURE ------------------------------------
    String _chefName = dataMap["chefName"];
    String _extracteddishID;
    await dishCollection.where("chefID", isEqualTo: chefID).get().then((data) {
      for (int i = 0; i < data.docs.length; i++) {
        _extracteddishID = data.docs[i].data()["dishID"].toString();
        updateDishData({"chefName": _chefName}, _extracteddishID);
      }
      // if (data.docs.length > 0) {
      //   _extracteddishID = data.docs[0].data()["dishID"].toString();
      // }
    });

    // ----------------- WORKAROUND ENDS HERE -----------------------------

    await chefCollection.doc(chefID).set(
      {
        'chefUpdateDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await chefCollection.doc(chefID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }

//   // Cust data from snapshot (For retrival)
//   ChefData _chefDataFromSnapshot(docSnapshot snapshot) {
//     print("------> _chefDataFromSnapshot(docSnapshot snapshot) INVOKED");
//     return ChefData(
//       chefID: uid,
//       chefName: snapshot.data()['chefName'] ?? "",
//       chefPhNo: snapshot.data()['chefPhNo'] ?? "",
//       chefDateOfBirth:
//           (snapshot.data()['chefDateOfBirth'] as Timestamp).toDate() ?? "",
//       // //  chefAddDate: (snapshot.data()['chefAddDate'] as Timestamp).toDate() ??,
//       chefLocation: snapshot.data()['chefLocation'] ?? "",
//       chefRatings: snapshot.data()['chefRatings'] ?? 0,
//       chefFollowers: snapshot.data()['chefFollowers'] ?? [],
//       chefDishes: snapshot.data()['chefDishes'] ?? [],
//       chefPic: snapshot.data()['chefPic'] ?? "",
//       chefBio: snapshot.data()['chefBio'] ?? "",
//       hasDish: snapshot.data()['hasDish'] ?? false,
//     );
//   }

// // Get user doc stream
//   Stream<ChefData> getChefData(String chefID) {
//     print(
//         " ---------> UID inside the getChefData in database.dart : " + chefID);
//     return chefCollection.doc().snapshots().map(_chefDataFromSnapshot);
//   }

  // Cust data from snapshot (For retrival)
  List<ChefData> _allChefDataFromSnapshot(QuerySnapshot snapshot) {
    print("------> _allChefDataFromSnapshot(docSnapshot snapshot) INVOKED");

    List<ChefData> _chefsList = List<ChefData>();
    for (int i = 0; i < snapshot.docs.length; i++) {
      _chefsList.add(ChefData(
        chefID: snapshot.docs[i].data()['chefID'],
        chefName: snapshot.docs[i].data()['chefName'] ?? "",
        chefPhNo: snapshot.docs[i].data()['chefPhNo'] ?? "",
        chefDateOfBirth:
            (snapshot.docs[i].data()['chefDateOfBirth'] as Timestamp)
                    .toDate() ??
                "",
        // //  chefAddDate: (snapshot.docs[i].data()['chefAddDate'] as Timestamp).toDate() ??,
        chefLocation: snapshot.docs[i].data()['chefLocation'] ?? "",
        chefRatings: snapshot.docs[i].data()['chefRatings'] ?? 0,
        chefFollowers: snapshot.docs[i].data()['chefFollowers'] ?? [],
        chefDishes: snapshot.docs[i].data()['chefDishes'] ?? [],
        chefPic: snapshot.docs[i].data()['chefPic'] ?? "",
        chefBio: snapshot.docs[i].data()['chefBio'] ?? "",
        hasDish: snapshot.docs[i].data()['hasDish'] ?? false,
      ));
      print("snapshot.docs[i].data()['chefName'] inside Database: " +
          snapshot.docs[i].data()['chefName'].toString());
    }
    return _chefsList;
  }

  Stream<List<ChefData>> getSingleChefData(String chefID) {
    print(" ---------> UID inside the getSingleChefData in database.dart : " +
        chefID.toString());
    return chefCollection
        .where("chefID", isEqualTo: chefID)
        .snapshots()
        .map(_allChefDataFromSnapshot);
  }
  // Get user doc stream

  Stream<List<ChefData>> get getAllChefData {
    print(" ---------> Inside the getAllChefData in database.dart ");
    return chefCollection.snapshots().map(_allChefDataFromSnapshot);
  }

// ===============================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D I S H   D A T A
// ===============================================================================================================

// >>>>>>>>>>  Upon adding new dish
  Future addNewDishData(Map<String, dynamic> dataMap) async {
    print("---------> AddDishData function reached in DatabaseServies class");

    // *  Creating ID
    int lastIndexOfDish =
        await DBHelperFtns().lastDocumentIdNumber(dishCollection, 'dishID');
    String newDishID = "dish" + (lastIndexOfDish + 1).toString();

    updateChefData({"hasDish": true}, dataMap["chefID"]);
    print("---------> chefID passed inside addNewDish in database: " +
        dataMap["chefID"]);
    await dishCollection.doc(newDishID).set(
      {
        'dishID': newDishID,
        'dishAddDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );
    //- Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        print("Adding dynamic dish data - DatabaseService");
        print("Key: $key ,  Value: $value");
        await dishCollection.doc(newDishID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }

// >>>>>>>>>>  Upon updating existing dish
  Future updateDishData(Map<String, dynamic> dataMap, String dishID) async {
    print(
        "---------> UpdateDishData function reached in DatabaseServies class");

    //- Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        print("Adding dynamic dish data - DatabaseService");
        await dishCollection.doc(dishID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }

// >>>>>>>>>>  View DishData
  // ignore: missing_return
  List<Dish> _dishDataFromSnapshot(QuerySnapshot snapshot) {
    print(
        ">>>>>>>>>>> _dishDataFromSnapshot inside database INVOKED and snapshot legth is : " +
            snapshot.docs.length.toString());
    // Map<Dish,dynamic> chefDishes;
    List<Dish> chefDishes = List<Dish>();

    for (int i = 0; i < snapshot.docs.length; i++) {
      chefDishes.add(Dish(
        dishID: snapshot.docs[i].data()['dishID'] ?? "",
        dishName: snapshot.docs[i].data()['dishName'] ?? "",
        dishPrice: snapshot.docs[i].data()['dishPrice'] ?? 0,
        dishRatings: snapshot.docs[i].data()['dishRatings'] ?? 0.0,
        dishPic: snapshot.docs[i].data()['dishPic'] ?? "",
        dishAval: snapshot.docs[i].data()['dishAval'] ?? false,
        dishPrepTime: snapshot.docs[i].data()['dishPrepTime'] ?? 0,
        //  dishAddDate: snapshot.docs[i].data()['dishAddDate'],
        //  dishUpdateDate: snapshot.docs[i].data()['dishUpdateDate'],
        chefID: snapshot.docs[i].data()['chefID'] ?? "",
        attrID: snapshot.docs[i].data()['attrID'] ?? "",
        chefName: snapshot.docs[i].data()['chefName'] ?? "",
        ctgID: snapshot.docs[i].data()['ctgID'] ?? "",
      ));
      // print("ALL THE DISHES: " + chefDishes.elementAt(i).dishName.toString());
    }
    return chefDishes;
  }

// //Get user doc stream
//   Stream<List<Dish>> get getDishData {
//     return dishCollection.get().asStream().map(_dishDataFromSnapshot);
//   }

  Stream<List<Dish>> get getChefDishData {
    print("-------> getChefDishData inside DATABASE INVOKED");
    return dishCollection
        .where("chefID", isEqualTo: uid)
        .get()
        .asStream()
        .map(_dishDataFromSnapshot);
  }

  Stream<List<Dish>> get getAllDishData {
    return dishCollection.get().asStream().map(_dishDataFromSnapshot);
  }

// ==================================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D I S H    C A T G    D A T A
// ==================================================================================================================

  List<DishCategory> _dishCatgFromSnapshot(QuerySnapshot snapshot) {
    List<DishCategory> chefDishCategories = List<DishCategory>();

    for (int i = 0; i < snapshot.docs.length; i++) {
      chefDishCategories.add(DishCategory(
        ctgID: snapshot.docs[i].data()['ctgID'] ?? "",
        ctgName: snapshot.docs[i].data()['ctgName'] ?? "",
        ctgAddDate: snapshot.docs[i].data()['ctgAddDate'] ?? "",
      ));
    }
    return chefDishCategories;
  }

//Get user doc stream
  Stream<List<DishCategory>> get getDishCatgData {
    print("============== dishCtgCollection.get():       " +
        dishCtgCollection.get().toString());
    return dishCtgCollection.get().asStream().map(_dishCatgFromSnapshot);
  }

// ==================================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D I S H    A T T R I B    D A T A
// ==================================================================================================================

// >>>>>>>>>>  Upon adding new dish
  Future addAttrData(String attrName) async {
    print("---------> AddDishData function reached in DatabaseServies class");

    // *  Creating ID
    int lastIndexOfattr =
        await DBHelperFtns().lastDocumentIdNumber(dishAttrCollection, 'attrID');
    String newAttrID = "attr" + (lastIndexOfattr + 1).toString();

    await dishAttrCollection.doc(newAttrID).set(
      {
        'attrID': newAttrID,
        'attrName': attrName,
        'attrAddDate': DateTime.now(),
      },
      SetOptions(merge: true),
    );
    //- Dynamically adding data in the db
    // dataMap.forEach(
    //   (key, value) async {
    //     print("Adding dynamic attr data - DatabaseService");
    //     print("Key: $key ,  Value: $value");
    //     await dishAttrCollection.doc(newAttrID).set(
    //       {
    //         key: value,
    //       },
    //       SetOptions(merge: true),
    //     );
    //   },
    // );
  }

// >>>>>>>>>>  View AttrData
  List<Attribute> _dishAttrFromSnapshot(QuerySnapshot snapshot) {
    List<Attribute> chefDishCategories = List<Attribute>();

    for (int i = 0; i < snapshot.docs.length; i++) {
      chefDishCategories.add(Attribute(
        attrID: snapshot.docs[i].data()['attrID'] ?? "",
        attrName: snapshot.docs[i].data()['attrName'] ?? "",
        attrAddDate: snapshot.docs[i].data()['attrAddDate'] ?? "",
      ));
      print(
          "snapshot.docs[i].data()['attrAddDate' INSIDE _dishAttrFromSnapshot: " +
              snapshot.docs[i].data()['attrAddDate'].toString());
    }
    return chefDishCategories;
  }

//Get user doc stream
  Stream<List<Attribute>> get getDishAttrData {
    print("dishAttrCollection.get():       " +
        dishAttrCollection.get().toString());
    return dishAttrCollection.get().asStream().map(_dishAttrFromSnapshot);
  }

// ====================================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   P L A N    D A T A
// ====================================================================================================================

  Future addPlanData(Map<String, dynamic> dataMap) async {
    print('inside function add plan data iin database');

    int x = await DBHelperFtns().lastDocumentIdNumber(planCollection, 'planID');
    String planID = "plan" + (x + 1).toString();
    addNewCustData({'planID': planID});

    print("-------> add dish function reached in database calass...");
    print("DataMap : " + dataMap.toString());

    Map<String, List<String>> custExercise = {};
    await planCollection.doc(planID).set({
      'planID': planID,
      'custID': uid,
      'custExercise': custExercise,
    }, SetOptions(merge: true));

    dataMap.forEach(
      (key, value) async {
        print(
            "----------------------- adding dynamic Plan data.. datbase service ");
        await planCollection.doc(planID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }

  Plan _planDataFromSnapshot(QuerySnapshot snapshot) {
    return Plan(
      planID: snapshot.docs[0].data()['planID'] ?? "",
      custId: snapshot.docs[0].data()['custID'] ?? "",
      custGender: snapshot.docs[0].data()['custGender'] ?? "",
      custHeight: snapshot.docs[0].data()['custHeight'] ?? 0.0,
      custWeight: snapshot.docs[0].data()['custWeight'] ?? 0.0,
      custGoalWeight: snapshot.docs[0].data()['custGoalWeight'] ?? 0.0,
      custReqKcal: snapshot.docs[0].data()['custReqKcl'] ?? 0.0,
      custReqProtein: snapshot.docs[0].data()['custReqProtein'] ?? 0.0,
      custReqFats: snapshot.docs[0].data()['custReqFats'] ?? 0.0,
      custReqCarbs: snapshot.docs[0].data()['custReqCarbs'] ?? 0.0,
      custExercise: snapshot.docs[0].data()['custExercise'] ?? "",
      custburntKcal: snapshot.docs[0].data()['custburntKcal'] ?? 0.0,
      custburntProtein: snapshot.docs[0].data()['custburntProtein'] ?? 0.0,
      //  custGender: snapshot.data()['custGender'] ?? "",
      // custHeight: snapshot.data()['custID'] ?? "",
    );
  }

  // Future<docSnapshot > getresult() async {
  //   var result =
  //       await planCollection.where("custID", isEqualTo: uid).get();
  //   return result.docs[0].data();
  // }

  Stream<Plan> get getPlanData {
    return planCollection
        .where('custID', isEqualTo: uid)
        .get()
        .asStream()
        .map(_planDataFromSnapshot);
  }

//todo
  Future updatePLanData(Map<String, dynamic> dataMap, String planID) {
    print('------------------- inside update plan data in database ');
    dataMap.forEach(
      (key, value) async {
        await planCollection.doc(planID).set(
          {
            key: value,
          },
          SetOptions(merge: true),
        );
      },
    );
  }
  //  Future<bool> updateCustData(
  //     Map<String, dynamic> dataMap, String custID) async {
  //   print(
  //       "---------> DataBase services class reached. Updating user for uid : " +
  //           uid.toString());

  //   // - Setting ID first in a doc
  //   await custCollection.doc(custID).set(
  //     {
  //       'custUpdateDate': DateTime.now(),
  //     },
  //     SetOptions(merge: true),
  //   );

  //   // - Dynamically adding data in the db
  //   dataMap.forEach(
  //     (key, value) async {
  //       await custCollection.doc(custID).set(
  //         {
  //           key: value,
  //         },
  //         SetOptions(merge: true),
  //       );
  //     },
  //   );
  //   return true;
  // }

  Future<int> countdocs(CollectionReference collection) async {
    QuerySnapshot _myDoc = await collection.get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return _myDocCount.length;
  }

// =================================================================================================
// -------------------------------------------------------------------- Custom queries functions
// =================================================================================================

// This function is just to check if the the passed user ID is of customer or chef
  Future<dynamic> checkUserID(String userID) async {
    var _completer = Completer<dynamic>();

    await custCollection.where("custID", isEqualTo: userID).get().then((data) {
      if (data.docs.length > 0) {
        print(
            "-----> data.docs inside custCollection completer check of 'checkUserID' : " +
                data.docs.length.toString());
        _completer.complete("cust");
      }
    });

    await chefCollection.where("chefID", isEqualTo: userID).get().then((data) {
      if (data.docs.length > 0) {
        print(
            "-----> data.docs inside chefCollection completer check of 'checkUserID' : " +
                data.docs.length.toString());
        _completer.complete("chef");
      }
    });

    print(
        "---------> DataBase services class reached. Completer.future inside checkUserID in DBServices: " +
            _completer.future.toString());

    String returnUser = await _completer.future;
    print("-------> User returned from COMPLETER: " + returnUser);
    return returnUser != null ? returnUser : null;

    // return null;

    // ---> https://stackoverflow.com/a/51122369
  }

  // Future<String> checkUserID(String userID) async {
  //   final custCheck =
  //       await custCollection.where("custID", isEqualTo: userID).get();
  //   final chefCheck =
  //       await chefCollection.where("chefID", isEqualTo: userID).get();
  //   print("---------> DataBase services class reached. ");
  //   print(
  //       "Checking if userID is in database or not? (Message from 'DatabaseServices' class)" +
  //           userID +
  //           " : Cust Check " +
  //           custCheck.toString() +
  //           " Chef Check : " +
  //           chefCheck.toString());

  //   if (custCheck.docs.length > 0) {
  //     return "cust";
  //   } else if (chefCheck.docs.length > 0) {
  //     return "chef";
  //   } else {
  //     print("Returning null from database.dart .................");
  //     return null;
  //   }

  //   // ---> https://stackoverflow.com/a/51122369
  // }

// - This function is to check if phone no exist in either "chef" or "customer"
  Future<String> isPhoneNoAlreadyRegistered(String _phoneNo) async {
    var chefResult =
        await chefCollection.where("chefPhNo", isEqualTo: _phoneNo).get();
    var custResult =
        await custCollection.where("custPhNo", isEqualTo: _phoneNo).get();
    print("chefResult==============" + chefResult.toString() + _phoneNo);

    if (chefResult.docs.length > 0) {
      print("Chef Case is true___________");
      return "chef";
    } else if (custResult.docs.length > 0) {
      print("Cust Case is true___________");
      return "cust";
    } else {
      print("chefResult.docs.length============== " +
          chefResult.docs.length.toString());
      print("custResult.docs.length============== " +
          custResult.docs.length.toString());
      print("RESULT IS NULL> DON'T EXIST IN DB");
      return null;
    }
  }

// --------------------- Phone no check
  Future<bool> isPhoneNoInChef(String _phoneNo) async {
    var chefResult =
        await chefCollection.where("chefPhNo", isEqualTo: _phoneNo).get();

    return chefResult.docs.length > 0 ? true : false;
  }

  Future<bool> isPhoneNoInCust(String _phoneNo) async {
    var custResult =
        await custCollection.where("custPhNo", isEqualTo: _phoneNo).get();

    return custResult.docs.length > 0 ? true : false;
  }

  // Future<bool> isPhoneNoInCust(String _phoneNo) async {
  //   var custResult = await custCollection
  //       .where("custPhNo", isEqualTo: _phoneNo)
  //       .get();

  //   return custResult.docs.length > 0 ? true : false;
  // }

  // Future getTotal(postID) async {
  //   int counter;
  //   await Firestore.instance // <<<== changed
  //       .collection('post')
  //       .doc(postID)
  //       .collection('count_shrads')
  //       .snapshots()
  //       .listen((data) =>
  //           data.docs.forEach((doc) => counter += (doc["count"])));
  //   print("The total is $counter");
  //   return counter;
  // }

  //
  // >>>>>>>> Sign-in Customer
  //

//******************************************************************************************** */
// *************************************** C  A  R  T ******************************************
//********************************************************************************************** */

  Future<String> addNewCartData(String custID) async {
    print(
        "---------> Addnewcart on user registration  function reached in DatabaseServies class");

    // *  Creating ID
    int lastIndexOfcart =
        await DBHelperFtns().lastDocumentIdNumber(cartCollection, 'cartID');

    String newcartID = "cart" + (lastIndexOfcart + 1).toString();
    print(
        '******* after last document function in add new cart function in  database new cart id is ' +
            newcartID.toString());
    Map<String, dynamic> items = {};
    await cartCollection.doc(newcartID).set(
      {
        'custID': custID,
        'cartID': newcartID,
        'cartAddDate': DateTime.now(),
        'items': items,
      },
      SetOptions(merge: true),
    );

    return newcartID;
  }

  Future updateCartData(String cartID, String productID, int quantity) async {
    print("---------> update cart  function reached in DatabaseServies class");
    await cartCollection.doc(cartID).set(
      {
        'items': {productID: quantity},
      },
      SetOptions(merge: true),
    );

    print('data updated ');
  }

  Future deleteCartItem(String cartID, String productID) {
    print('**** inside delete cart item in database');

    cartCollection.doc(cartID).set(
      {
        'items': {productID: FieldValue.delete()}
      },
      SetOptions(merge: true),
    );
  }

  Future deleteallCartItems(String cartID, Map<String, dynamic> items) {
    print('**** inside delete all cart item in database');

    for (int index = 0; index < items.length; index++) {
      cartCollection.doc(cartID).set(
        {
          'items': {items.keys.elementAt(index): FieldValue.delete()}
        },
        SetOptions(merge: true),
      );
    }
  }

  Future updateInventory(String dishID, int quantity) {
    print('------->>>>> inside update inventory  in database' +
        quantity.toString());
    dishCollection.doc(dishID).set(
      {
        'quantity': quantity,
      },
      SetOptions(merge: true),
    );
  }

  Cart _userCartDataFromsnapshot(QuerySnapshot snapshot) {
    int i = 0;
    print('****** snapshot length inside user cart data from snapshot ' +
        snapshot.docs[i].data()['items'].toString());
    try {
      String cartID = snapshot.docs[i].data()['cartID'] ?? '';
      String custID = snapshot.docs[i].data()['custID'] ?? '';
      return Cart(
        cartid: cartID,
        custID: custID,
        items: snapshot.docs[i].data()['items'] ?? null,
      );
    } catch (error) {
      print('error in map function of ucer cart ' + error.toString());
    }
  }

  Stream<Cart> getCartData(String custID) {
    return cartCollection
        .where('custID', isEqualTo: custID)
        .snapshots()
        .map(_userCartDataFromsnapshot);
  }

  //--------------------------------- O R D E R ------------------------------

  Future<String> createOrder(
    String custID,
    String custName,
    String chefID,
    Map<String, dynamic> shippingAddress,
    String phoneNo,
    List orderStatus,
    Map<String, dynamic> itemsList,
    double total,
  ) async {
    print('inside create mew order function ***********');

    int lastindexofOrder =
        await DBHelperFtns().lastDocumentIdNumber(orderCollection, 'orderID');

    String newOrderID = 'order' + (lastindexofOrder + 1).toString();

    print(
        '******* after last document function in add new order function in  database new order id is ' +
            newOrderID.toString());

    // Map<String, int> items = {};
    await orderCollection.doc(newOrderID).set(
      {
        'custID': custID,
        'orderID': newOrderID,
        'custName': custName,
        'chefID': chefID,
        'shippingAddress': shippingAddress,
        'contactNo': phoneNo,
        'orderStatus': orderStatus,
        'orderDate': DateTime.now(),
        'items': itemsList,
        'total': total,
      },
      SetOptions(merge: true),
    );
    return newOrderID;
  }

  List<Order> _orderDataFromSnapshot(QuerySnapshot snapshot) {
    print(
        ">>>>>>>>>>> _orderDataFromSnapshot inside database INVOKED and snapshot legth is : " +
            snapshot.docs.length.toString());
    // Map<Dish,dynamic> chefDishes;
    List<Order> ordersList = List<Order>();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ordersList.add(Order(
        orderID: snapshot.docs[i].data()['orderID'] ?? "",
        custID: snapshot.docs[i].data()['custID'] ?? "",
        orderStatus: snapshot.docs[i].data()['orderStatus'] ?? "",
        phoneNo: snapshot.docs[i].data()['contactNo'] ?? "",
        chefID: snapshot.docs[i].data()['chefID'] ?? "",
        orderDate:
            (snapshot.docs[i].data()['orderDate'] as Timestamp).toDate() ?? "",
        // shippedDate:
        //     (snapshot.docs[i].data()['shippedDate'] as Timestamp).toDate() ??
        //         "",
        shippingAddress: snapshot.docs[i].data()['shippingAddress'] ?? "",
        items: snapshot.docs[i].data()['items'] ?? "",
        total: snapshot.docs[i].data()['total'] ?? "",
        custName: snapshot.docs[i].data()['custName'] ?? "",
      ));
    }
    return ordersList;
  }

  Stream<List<Order>> getSingleOrderData(String _passedOrderID) {
    print("---> _passedOrderID inside getSingleOrderData in database class: " +
        _passedOrderID.toString());
    return orderCollection
        .where("orderID", isEqualTo: _passedOrderID)
        .snapshots()
        .map(_orderDataFromSnapshot);
  }

  Stream<List<Order>> getCustOrderData() {
    // print("---> _custID inside getSingleOrderData in database class: " +
    //     _custID.toString());
    return orderCollection
        .where("custID", isEqualTo: uid)
        .snapshots()
        .map(_orderDataFromSnapshot);
  }

  //
  //------------------------------ E  X  E  R  C  I  S  E //

  // List<Order> _orderDataFromSnapshot(QuerySnapshot snapshot) {
  //   print(
  //       ">>>>>>>>>>> _orderDataFromSnapshot inside database INVOKED and snapshot legth is : " +
  //           snapshot.docs.length.toString());
  //   // Map<Dish,dynamic> chefDishes;
  //   List<Order> ordersList = List<Order>();

  //   for (int i = 0; i < snapshot.docs.length; i++) {
  //     ordersList.add(Order(
  //       orderID: snapshot.docs[i].data()['orderID'] ?? "",
  //       custID: snapshot.docs[i].data()['custID'] ?? "",
  //       orderStatus: snapshot.docs[i].data()['orderStatus'] ?? "",
  //       phoneNo: snapshot.docs[i].data()['contactNo'] ?? "",
  //       chefID: snapshot.docs[i].data()['chefID'] ?? "",
  //       orderDate:
  //           (snapshot.docs[i].data()['orderDate'] as Timestamp).toDate() ?? "",
  //       // shippedDate:
  //       //     (snapshot.docs[i].data()['shippedDate'] as Timestamp).toDate() ??
  //       //         "",
  //       shippingAddress: snapshot.docs[i].data()['shippingAddress'] ?? "",
  //       items: snapshot.docs[i].data()['items'] ?? "",
  //       total: snapshot.docs[i].data()['total'] ?? "",
  //       custName: snapshot.docs[i].data()['custName'] ?? "",
  //     ));
  //   }
  //   return ordersList;
  // }
  List<Exercise> _exerciseDataFromSnapShop(QuerySnapshot snapshot) {
    print('-------------------------- inside map function of exercise ' +
        snapshot.docs.length.toString());

    List<Exercise> exerciseList = List<Exercise>();
    for (int i = 0; i < snapshot.docs.length; i++) {
      exerciseList.add(Exercise(
        exerciseName: snapshot.docs[i].data()['ExerciseName'] ?? "",
        weight_48_59: snapshot.docs[i].data()['48kg to 59kg'] ?? "",
        weight_59_70: snapshot.docs[i].data()['59kg to 70kg'] ?? "",
        weight_70_82: snapshot.docs[i].data()['70kg to 82kg'] ?? "",
        weight_82_93: snapshot.docs[i].data()['82kg to 93kg'] ?? "",
        weight_93_104: snapshot.docs[i].data()['93kg to 104'] ?? "",
        weight_104_116: snapshot.docs[i].data()['104kg to 116kg'] ?? "",
        weight_116_127: snapshot.docs[i].data()['116kg to 127kg'] ?? "",
      ));
    }
    return exerciseList;
  }

  Stream<List<Exercise>> getAllExercises() {
    print('--------------- inside get all exercises function ');
    return exerciseCollection.snapshots().map(_exerciseDataFromSnapShop);
  }

  Future updateCustExercise(String planID, String exerciseName, String calories,
      String duration) async {
    print(
        '---------------------inside updaet cust exercise funtion indatabase');
    String now = DateTime.now().toString();
    await planCollection.doc(planID).set(
      {
        'custExercise': {
          now: [exerciseName, calories, duration]
        },
      },
      SetOptions(merge: true),
    );
  }

  // Future updateCustAddress(String custID, String title, String houseno,
  //     String street, String city) async {
  //   print('inside update address function  in  data base');
  //   await custCollection.doc(custID).set(
  //     {
  //       'custAddress': {
  //         title: [houseno, street, city]
  //       },
  //     },
  //     SetOptions(merge: true),
  //   );
  // }
}
