import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/plan.dart';
import 'package:fitness_diet/core/models/user.dart';

class DatabaseService {
  // collection reference is just reference for certain collection

  final CollectionReference chefCollection =
      Firestore.instance.collection('chef');
  final CollectionReference dishCollection =
      Firestore.instance.collection('dish');
  final CollectionReference dishCtgCollection =
      Firestore.instance.collection('dishCategory');
  final CollectionReference dishAttrCollection =
      Firestore.instance.collection('dishAttributes');

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

  Future<bool> updateCustData(Map<String, dynamic> dataMap) async {
    print("---------> DataBase services class reached. Updating user for uid" +
        uid.toString());

    // - Setting ID first in a document
    await custCollection.document(uid).setData(
      {
        'custUpdateDate': DateTime.now(),
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

  //
  // >>>>>>>>>>>>>>>> G E T T I N G   D A T A
  //
  CustData _custDataFromSnapshot(DocumentSnapshot snapshot) {
    print(" UiD DB TEST" + uid + " USerNAme: " + snapshot.data['username']);
    return CustData(
      custId: uid,
      custPhNo: snapshot.data['custPhNo'] ?? "",
      custName: snapshot.data['custName'] ?? "",
      custDateOfBirth:
          (snapshot.data['custDateOfBirth'] as Timestamp).toDate() ?? "",
      // custAddDate: (snapshot.data['custAddDate'] as Timestamp).toDate() ?? "",
      custGender: snapshot.data['custGender'] ?? "",
      custWeight: snapshot.data['custWeight'] ?? "",
      custHeight: snapshot.data['custHeight'] ?? "",
      // custfavs: snapshot.data['custfavs'] ?? "",
      custLocation: snapshot.data['custLocation'] ?? "",
      // custOrders: snapshot.data['custOrders'] ?? "",
    );
  }

  // Get user doc stream
  Stream<CustData> get getCustData {
    //print("-----------> getCustData reached and Id is "  + custCollection.document(uid).snapshots(),toString());
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

  Future updateChefData(Map<String, dynamic> dataMap) async {
    // });
    print("UID in Database class_+_+__+_+_+_++_+: " + uid.toString());
    // - Statically adding date in the db
    await chefCollection.document(uid).setData(
      {
        'chefUpdateDate': DateTime.now(),
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

  // Cust data from snapshot (For retrival)
  ChefData _chefDataFromSnapshot(DocumentSnapshot snapshot) {
    return ChefData(
      chefId: uid,
      chefName: snapshot.data['chefName'] ?? "",
      chefPhNo: snapshot.data['chefPhNo'] ?? "",
      chefDateOfBirth:
          (snapshot.data['chefDateOfBirth'] as Timestamp).toDate() ?? "",
      chefAddDate: (snapshot.data['chefAddDate'] as Timestamp).toDate(),
      chefLocation: snapshot.data['chefLocation'] ?? "",
      chefRatings: snapshot.data['chefLocation'] ?? null,
      chefFollowers: snapshot.data['chefFollowers'] ?? [],
      chefDishes: snapshot.data['chefDishes'] ?? [],
      chefPicture: snapshot.data['chefPicture'] ?? "",
      chefBio: snapshot.data['chefBio'] ?? "",

    );
  }

// Get user doc stream
  Stream<ChefData> get getChefData {
    return chefCollection.document(uid).snapshots().map(_chefDataFromSnapshot);
  }

// ===============================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D I S H   D A T A
// ===============================================================================================================

  Future addNewDishData(Map<String, dynamic> dataMap) async {
    print("---------> AddDishData function reached in DatabaseServies class");
    final dishLength = await countDishDocuments();
    int dishID = dishLength + 1;
    String newDishID = "dish" + dishID.toString();

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
    await dishCollection.document(newDishID).setData(
      {
        'dishID': newDishID,
        'dishAddDate': DateTime.now(),
      },
      merge: true,
    );
  }

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

//Cust data from snapshot (For retrival)
  // ignore: missing_return
  List<Dish> _dishDataFromSnapshot(QuerySnapshot snapshot) {
    // Map<Dish,dynamic> chefDishes;
    List<Dish> chefDishes = List<Dish>();

    for (int i = 0; i < snapshot.documents.length; i++) {
      chefDishes.add(Dish(
        dishID: snapshot.documents[i].data['dishID'] ?? "",
        dishName: snapshot.documents[i].data['dishName'] ?? "",
        dishPrice: snapshot.documents[i].data['dishPrice'] ?? 0,
        dishRatings: snapshot.documents[i].data['dishRatings'] ?? 0.0,
        dishPic: snapshot.documents[i].data['dishPic'] ?? null,
        dishAval: snapshot.documents[i].data['dishAval'] ?? false,
      ));
      print("ALL THE DISHES: " + chefDishes.elementAt(i).dishName.toString());
    }
    print("ALL THE DISHES: " + chefDishes.elementAt(0).dishName.toString());
    print("ALL THE DISHES lENGTH: " + chefDishes.length.toString());

    return chefDishes;
  }

//Get user doc stream
  Stream<List<Dish>> get getDishData {
    return dishCollection
        .where("chefID", isEqualTo: uid)
        .getDocuments()
        .asStream()
        .map(_dishDataFromSnapshot);
  }

  Future<int> countDishDocuments() async {
    QuerySnapshot _myDoc = await dishCollection.getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    return _myDocCount.length;
  }

// -------- Fetching category name using ctg-ID
  Future<String> fetchDishCtgName(DocumentSnapshot passedCtgID) async {
    QuerySnapshot ctgName = await dishCtgCollection
        .where("ctgID", isEqualTo: passedCtgID)
        .getDocuments();
    print("------> ctgName from fetchDishCtgName" + ctgName.toString());
    return ctgName.toString();
  }

// -------- Fetching Attribute name using ctg-ID
  Future<String> fetchDishAttrName(DocumentSnapshot passedAttrID) async {
    QuerySnapshot attrName = await dishAttrCollection
        .where("attrID", isEqualTo: passedAttrID)
        .getDocuments();
    print("------> attrName from fetchDishattrName" + attrName.toString());
    return attrName.toString();
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
    print("dishCtgCollection.getDocuments():       " +
        dishCtgCollection.getDocuments().toString());
    return dishCtgCollection
        .getDocuments()
        .asStream()
        .map(_dishCatgFromSnapshot);
  }

// ====================================================================================================================
// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   P L A N    D A T A
// ====================================================================================================================

  Future addPlanData(Map<String, dynamic> dataMap) async {
    print('inside function add plan data iin database');
    int x = await lastDocumentIdNumber(planCollection, 'planID');

    print("-------> add dish function reached in database calass...");
    print("DataMap : " + dataMap.toString());

    String planID = "plan" + (x + 1).toString();
    updateCustData({'planID': planID});

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

  Future<int> lastDocumentIdNumber(
      CollectionReference collection, String fieldName) async {
    print('last document function.********');
    QuerySnapshot _myDoc = await collection.getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    if (_myDocCount.length == 0) {
      print('if  working ***');
      return 0;
    } else {
      print('else working ***');
      dynamic value = _myDocCount[_myDocCount.length - 1].data[fieldName];

      final intRegex = RegExp(r'[0-9]');

      Iterable matches = intRegex.allMatches(value.toString());
      String str = '';

      matches.forEach((match) {
        print(value.toString().substring(match.start, match.end));
        str = str + value.toString().substring(match.start, match.end);
      });
      print('string ' + str);
      int idNumber = int.parse(str);
      return idNumber;
    }
  }

// =================================================================================================
// -------------------------------------------------------------------- Custom queries functions
// =================================================================================================

// This function is just to check if the the passed user ID is of customer or chef
  Future<String> checkUserID(String userID) async {
    // var completer = Completer<String>();
    final custCheck =
        (await custCollection.where("custID", isEqualTo: userID).getDocuments())
            .documents;
    final chefCheck =
        (await chefCollection.where("chefID", isEqualTo: userID).getDocuments())
            .documents;
    print("---------> DataBase services class reached. ");
    print(
        "Checking if userID is in database or not? (Message from 'DatabaseServices' class)" +
            userID +
            " : Cust Check " +
            custCheck.toString() +
            " Chef Check : " +
            chefCheck.toString());

    if (custCheck.length > 0) {
      return "cust";
    } else if (chefCheck.length > 0) {
      return "chef";
    }
    print("Returning null from database.dart .................");
    return null;

    // ---> https://stackoverflow.com/a/51122369
  }

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

  Future getTotal(postID) async {
    int counter;
    await Firestore.instance // <<<== changed
        .collection('post')
        .document(postID)
        .collection('count_shrads')
        .snapshots()
        .listen((data) =>
            data.documents.forEach((doc) => counter += (doc["count"])));
    print("The total is $counter");
    return counter;
  }

  //
  // >>>>>>>> Sign-in Customer
  //
  Future signInCustomer(String phNo, String password) {}
}
