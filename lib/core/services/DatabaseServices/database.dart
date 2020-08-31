import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';
import 'package:fitness_diet/core/services/DatabaseServices/dbHelperFtns.dart';

class DatabaseService {
  // collection reference is just reference for certain collection

  final CollectionReference chefCollection =
      Firestore.instance.collection('chef');
  final CollectionReference dishCollection =
      Firestore.instance.collection('dish');
  final CollectionReference dishCtgCollection =
      Firestore.instance.collection('dishCategory');
  final CollectionReference dishAttrCollection =
      Firestore.instance.collection('attribute');

  final CollectionReference custCollection =
      Firestore.instance.collection('customer');
  final CollectionReference planCollection =
      Firestore.instance.collection('plan');

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
    // - Setting ID first in a document
    await custCollection.document(uid).setData(
      {
        'custID': uid,
        'custAddDate': DateTime.now(),
      },
      merge: true,
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await custCollection.document(uid).setData(
          {
            key: value,
          },
          merge: true,
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

    // - Setting ID first in a document
    await custCollection.document(custID).setData(
      {
        'custUpdateDate': DateTime.now(),
      },
      merge: true,
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await custCollection.document(custID).setData(
          {
            key: value,
          },
          merge: true,
        );
      },
    );
    return true;
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
      custPhNo: snapshot.data['custPhNo'] ?? "load",
      custName: snapshot.data['custName'] ?? "load",
      custDateOfBirth:
          (snapshot.data['custDateOfBirth'] as Timestamp).toDate() ?? "",
      // custfavs: snapshot.data['custfavs'] ?? "",
      custLocation: snapshot.data['custLocation'] ?? "",
      // custFollowing: snapshot.data['custFollowing'] ?? "",
      planID: snapshot.data['planID'] ?? "",
      custPic: snapshot.data['custPic'] ?? "",
      // custOrders: snapshot.data['custOrders'] ?? "",
    );
  }

  // Get user doc stream
  Stream<CustData> get getCustData {
    print(" UiD DB TEST function reached in getcust data******************** ");
    return custCollection.document(uid).snapshots().map(_custDataFromSnapshot);
  }
// ===========================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   C H E F  D A T A
// ===========================================================================================================

  Future addNewChefData(Map<String, dynamic> dataMap) async {
    // });
    print("UID in Database class_+_+__+_+_+_++_+: " + uid.toString());

    // - Statically adding date in the db
    await chefCollection.document(uid).setData(
      {
        'chefID': uid,
        'chefAddDate': DateTime.now(),
        'hasDish': false, // Jugar
      },
      merge: true,
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await chefCollection.document(uid).setData(
          {
            key: value,
          },
          merge: true,
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
    await dishCollection
        .where("chefID", isEqualTo: chefID)
        .getDocuments()
        .then((data) {
      for (int i = 0; i < data.documents.length; i++) {
        _extracteddishID = data.documents[i].data["dishID"].toString();
        updateDishData({"chefName": _chefName}, _extracteddishID);
      }
      // if (data.documents.length > 0) {
      //   _extracteddishID = data.documents[0].data["dishID"].toString();
      // }
    });

    // ----------------- WORKAROUND ENDS HERE -----------------------------

    await chefCollection.document(chefID).setData(
      {
        'chefUpdateDate': DateTime.now(),
      },
      merge: true,
    );

    // - Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        await chefCollection.document(chefID).setData(
          {
            key: value,
          },
          merge: true,
        );
      },
    );
  }

  // Cust data from snapshot (For retrival)
  ChefData _chefDataFromSnapshot(DocumentSnapshot snapshot) {
    print("------> _chefDataFromSnapshot(DocumentSnapshot snapshot) INVOKED");
    return ChefData(
      chefID: uid,
      chefName: snapshot.data['chefName'] ?? "",
      chefPhNo: snapshot.data['chefPhNo'] ?? "",
      chefDateOfBirth:
          (snapshot.data['chefDateOfBirth'] as Timestamp).toDate() ?? "",
      // //  chefAddDate: (snapshot.data['chefAddDate'] as Timestamp).toDate() ??,
      chefLocation: snapshot.data['chefLocation'] ?? "",
      chefRatings: snapshot.data['chefRatings'] ?? 0,
      chefFollowers: snapshot.data['chefFollowers'] ?? [],
      chefDishes: snapshot.data['chefDishes'] ?? [],
      chefPic: snapshot.data['chefPic'] ?? "",
      chefBio: snapshot.data['chefBio'] ?? "",
      hasDish: snapshot.data['hasDish'] ?? false,
    );
  }

// Get user doc stream
  Stream<ChefData> get getChefData {
    print(" ---------> UID inside the getChefData in database.dart : " + uid);
    return chefCollection.document(uid).snapshots().map(_chefDataFromSnapshot);
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
    await dishCollection.document(newDishID).setData(
      {
        'dishID': newDishID,
        'dishAddDate': DateTime.now(),
      },
      merge: true,
    );
    //- Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        print("Adding dynamic dish data - DatabaseService");
        print("Key: $key ,  Value: $value");
        await dishCollection.document(newDishID).setData(
          {
            key: value,
          },
          merge: true,
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
        await dishCollection.document(dishID).setData(
          {
            key: value,
          },
          merge: true,
        );
      },
    );
  }

// >>>>>>>>>>  View DishData
  // ignore: missing_return
  List<Dish> _dishDataFromSnapshot(QuerySnapshot snapshot) {
    print(
        ">>>>>>>>>>> _dishDataFromSnapshot inside database INVOKED and snapshot legth is : " +
            snapshot.documents.length.toString());
    // Map<Dish,dynamic> chefDishes;
    List<Dish> chefDishes = List<Dish>();

    for (int i = 0; i < snapshot.documents.length; i++) {
      chefDishes.add(Dish(
        dishID: snapshot.documents[i].data['dishID'] ?? "",
        dishName: snapshot.documents[i].data['dishName'] ?? "",
        dishPrice: snapshot.documents[i].data['dishPrice'] ?? 0,
        dishRatings: snapshot.documents[i].data['dishRatings'] ?? 0.0,
        dishPic: snapshot.documents[i].data['dishPic'] ?? "",
        dishAval: snapshot.documents[i].data['dishAval'] ?? false,
        dishPrepTime: snapshot.documents[i].data['dishPrepTime'] ?? 0,
        //  dishAddDate: snapshot.documents[i].data['dishAddDate'],
        //  dishUpdateDate: snapshot.documents[i].data['dishUpdateDate'],
        chefID: snapshot.documents[i].data['chefID'] ?? "",
        attrID: snapshot.documents[i].data['attrID'] ?? "",
        chefName: snapshot.documents[i].data['chefName'] ?? "",
        ctgID: snapshot.documents[i].data['ctgID'] ?? "",
      ));
      // print("ALL THE DISHES: " + chefDishes.elementAt(i).dishName.toString());
    }
    return chefDishes;
  }

// //Get user doc stream
//   Stream<List<Dish>> get getDishData {
//     return dishCollection.getDocuments().asStream().map(_dishDataFromSnapshot);
//   }

  Stream<List<Dish>> get getChefDishData {
    print("-------> getChefDishData inside DATABASE INVOKED");
    return dishCollection
        .where("chefID", isEqualTo: uid)
        .getDocuments()
        .asStream()
        .map(_dishDataFromSnapshot);
  }

  Stream<List<Dish>> get getAllDishData {
    return dishCollection.getDocuments().asStream().map(_dishDataFromSnapshot);
  }

// ==================================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D I S H    C A T G    D A T A
// ==================================================================================================================

  List<DishCategory> _dishCatgFromSnapshot(QuerySnapshot snapshot) {
    List<DishCategory> chefDishCategories = List<DishCategory>();

    for (int i = 0; i < snapshot.documents.length; i++) {
      chefDishCategories.add(DishCategory(
        ctgID: snapshot.documents[i].data['ctgID'] ?? "",
        ctgName: snapshot.documents[i].data['ctgName'] ?? "",
        ctgAddDate: snapshot.documents[i].data['ctgAddDate'] ?? "",
      ));
    }
    return chefDishCategories;
  }

//Get user doc stream
  Stream<List<DishCategory>> get getDishCatgData {
    print("============== dishCtgCollection.getDocuments():       " +
        dishCtgCollection.getDocuments().toString());
    return dishCtgCollection
        .getDocuments()
        .asStream()
        .map(_dishCatgFromSnapshot);
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

    await dishAttrCollection.document(newAttrID).setData(
      {
        'attrID': newAttrID,
        'attrName': attrName,
        'attrAddDate': DateTime.now(),
      },
      merge: true,
    );
    //- Dynamically adding data in the db
    // dataMap.forEach(
    //   (key, value) async {
    //     print("Adding dynamic attr data - DatabaseService");
    //     print("Key: $key ,  Value: $value");
    //     await dishAttrCollection.document(newAttrID).setData(
    //       {
    //         key: value,
    //       },
    //       merge: true,
    //     );
    //   },
    // );
  }

// >>>>>>>>>>  View AttrData
  List<Attribute> _dishAttrFromSnapshot(QuerySnapshot snapshot) {
    List<Attribute> chefDishCategories = List<Attribute>();

    for (int i = 0; i < snapshot.documents.length; i++) {
      chefDishCategories.add(Attribute(
        attrID: snapshot.documents[i].data['attrID'] ?? "",
        attrName: snapshot.documents[i].data['attrName'] ?? "",
        attrAddDate: snapshot.documents[i].data['attrAddDate'] ?? "",
      ));
      print(
          "snapshot.documents[i].data['attrAddDate' INSIDE _dishAttrFromSnapshot: " +
              snapshot.documents[i].data['attrAddDate'].toString());
    }
    return chefDishCategories;
  }

//Get user doc stream
  Stream<List<Attribute>> get getDishAttrData {
    print("dishAttrCollection.getDocuments():       " +
        dishAttrCollection.getDocuments().toString());
    return dishAttrCollection
        .getDocuments()
        .asStream()
        .map(_dishAttrFromSnapshot);
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

    await planCollection.document(planID).setData({
      'planID': planID,
      'custID': uid,
    }, merge: true);

    dataMap.forEach(
      (key, value) async {
        print(
            "----------------------- adding dynamic Plan data.. datbase service ");
        await planCollection.document(planID).setData(
          {
            key: value,
          },
          merge: true,
        );
      },
    );
  }

  Plan _planDataFromSnapshot(QuerySnapshot snapshot) {
    return Plan(
      planID: snapshot.documents[0].data['planID'] ?? "",
      custId: snapshot.documents[0].data['custID'] ?? "",
      custGender: snapshot.documents[0].data['custGender'] ?? "",
      custHeight: snapshot.documents[0].data['custHeight'] ?? "",
      custWeight: snapshot.documents[0].data['custWeight'] ?? "",
      custGoalWeight: snapshot.documents[0].data['custGoalWeight'] ?? "",
      custReqKcal: snapshot.documents[0].data['custReqKcl'] ?? "",
      custReqProtein: snapshot.documents[0].data['custReqProtein'] ?? "",
      custReqFats: snapshot.documents[0].data['custReqFats'] ?? "",
      custReqCarbs: snapshot.documents[0].data['custReqCarbs'] ?? "",

      //  custGender: snapshot.data['custGender'] ?? "",
      // custHeight: snapshot.data['custID'] ?? "",
    );
  }

  // Future<DocumentSnapshot > getresult() async {
  //   var result =
  //       await planCollection.where("custID", isEqualTo: uid).getDocuments();
  //   return result.documents[0].data;
  // }

  Stream<Plan> get getPlanData {
    return planCollection
        .where('custID', isEqualTo: uid)
        .getDocuments()
        .asStream()
        .map(_planDataFromSnapshot);
  }

  Future<int> countDocuments(CollectionReference collection) async {
    QuerySnapshot _myDoc = await collection.getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    return _myDocCount.length;
  }

// =================================================================================================
// -------------------------------------------------------------------- Custom queries functions
// =================================================================================================

// This function is just to check if the the passed user ID is of customer or chef
  Future<dynamic> checkUserID(String userID) async {
    var _completer = Completer<dynamic>();

    await custCollection
        .where("custID", isEqualTo: userID)
        .getDocuments()
        .then((data) {
      if (data.documents.length > 0) {
        print(
            "-----> data.documents inside custCollection completer check of 'checkUserID' : " +
                data.documents.length.toString());
        _completer.complete("cust");
      }
    });

    await chefCollection
        .where("chefID", isEqualTo: userID)
        .getDocuments()
        .then((data) {
      if (data.documents.length > 0) {
        print(
            "-----> data.documents inside chefCollection completer check of 'checkUserID' : " +
                data.documents.length.toString());
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
  //       await custCollection.where("custID", isEqualTo: userID).getDocuments();
  //   final chefCheck =
  //       await chefCollection.where("chefID", isEqualTo: userID).getDocuments();
  //   print("---------> DataBase services class reached. ");
  //   print(
  //       "Checking if userID is in database or not? (Message from 'DatabaseServices' class)" +
  //           userID +
  //           " : Cust Check " +
  //           custCheck.toString() +
  //           " Chef Check : " +
  //           chefCheck.toString());

  //   if (custCheck.documents.length > 0) {
  //     return "cust";
  //   } else if (chefCheck.documents.length > 0) {
  //     return "chef";
  //   } else {
  //     print("Returning null from database.dart .................");
  //     return null;
  //   }

  //   // ---> https://stackoverflow.com/a/51122369
  // }

// - This function is to check if phone no exist in either "chef" or "customer"
  Future<String> isPhoneNoAlreadyRegistered(String _phoneNo) async {
    var chefResult = await chefCollection
        .where("chefPhNo", isEqualTo: _phoneNo)
        .getDocuments();
    var custResult = await custCollection
        .where("custPhNo", isEqualTo: _phoneNo)
        .getDocuments();
    print("chefResult==============" + chefResult.toString() + _phoneNo);

    if (chefResult.documents.length > 0) {
      print("Chef Case is true___________");
      return "chef";
    } else if (custResult.documents.length > 0) {
      print("Cust Case is true___________");
      return "cust";
    } else {
      print("chefResult.documents.length============== " +
          chefResult.documents.length.toString());
      print("custResult.documents.length============== " +
          custResult.documents.length.toString());
      print("RESULT IS NULL> DON'T EXIST IN DB");
      return null;
    }
  }

// --------------------- Phone no check
  Future<bool> isPhoneNoInChef(String _phoneNo) async {
    var chefResult = await chefCollection
        .where("chefPhNo", isEqualTo: _phoneNo)
        .getDocuments();

    return chefResult.documents.length > 0 ? true : false;
  }

  Future<bool> isPhoneNoInCust(String _phoneNo) async {
    var custResult = await custCollection
        .where("custPhNo", isEqualTo: _phoneNo)
        .getDocuments();

    return custResult.documents.length > 0 ? true : false;
  }

  // Future<bool> isPhoneNoInCust(String _phoneNo) async {
  //   var custResult = await custCollection
  //       .where("custPhNo", isEqualTo: _phoneNo)
  //       .getDocuments();

  //   return custResult.documents.length > 0 ? true : false;
  // }

  // Future getTotal(postID) async {
  //   int counter;
  //   await Firestore.instance // <<<== changed
  //       .collection('post')
  //       .document(postID)
  //       .collection('count_shrads')
  //       .snapshots()
  //       .listen((data) =>
  //           data.documents.forEach((doc) => counter += (doc["count"])));
  //   print("The total is $counter");
  //   return counter;
  // }

  //
  // >>>>>>>> Sign-in Customer
  //

}
