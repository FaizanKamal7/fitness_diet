import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_diet/core/models/dish.dart';
import 'package:fitness_diet/core/models/user.dart';

class DatabaseService {
  // collection reference is just reference for certain collection
  final CollectionReference custCollection =
      Firestore.instance.collection('customer');
  final CollectionReference chefCollection =
      Firestore.instance.collection('chef');

  final CollectionReference dishCollection =
      Firestore.instance.collection('dish');
  final CollectionReference dishCtgCollection =
      Firestore.instance.collection('dishCategory');
  final CollectionReference dishAttrCollection =
      Firestore.instance.collection('dishAttributes');

  final String uid;
  DatabaseService({this.uid});

  // ------------------------------- UPDATION AND RETRIVAL OF CUSTOMER DATA

  //
  // >>>>>>>>>>>>>>>> S E T T I N G   D A T A
  //
  Future<bool> updateCustData(Map<String, dynamic> dataMap) async {
    // await custCollection.document(uid).setData({
    //   'username': username,
    //   'residence': residence,
    //   //  'dateOfBirth': dateOfBirth
    // });

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

  //
  // >>>>>>>>>>>>>>>> G E T T I N G   D A T A
  //
  CustData _custDataFromSnapshot(DocumentSnapshot snapshot) {
    // print(" UiD DB TEST" + uid + " USerNAme: " + snapshot.data['username']);
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
    return custCollection.document(uid).snapshots().map(_custDataFromSnapshot);
  }

  // ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   C H E F  D A T A

  Future updateChefData(Map<String, dynamic> dataMap) async {
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

// ------------------------------- U P D A T I O N   A N D   R E T R I V A L   O F   D I S H   D A T A

  Future updateDishData(Map<String, dynamic> dataMap) async {
    print(
        "---------> UpdateDishData function reached in DatabaseServies class");
    // print("DishLength: " + dishLength.toString());
    print("DataMap : " + dataMap.toString());
    final dishLength = await countDishDocuments();
    // final dishLength =
    //     await Firestore.instance.collection('dish').snapshots().length;

    int dishID = dishLength + 1;
    if (dishLength == 0) {
      await dishCollection.document(dishID.toString()).setData(
        {
          'dishID': dishLength,
          'dishAddDate': DateTime.now(),
        },
        merge: true,
      );
    }

    //- Dynamically adding data in the db
    dataMap.forEach(
      (key, value) async {
        print("Adding dynamic dish data - DatabaseService");
        await dishCollection.document(dishID.toString()).setData(
          {
            key: value,
          },
          merge: true,
        );
      },
    );
  }

//Cust data from snapshot (For retrival)
  Dish _dishDataFromSnapshot(DocumentSnapshot snapshot) {
    print("-------> Snapshot data (from within _dishDataFromSnapshot) : " +
        snapshot.data.toString());
    return Dish(
      dishID: snapshot.data['dishID'] ?? "",
      dishName: snapshot.data['dishName'] ?? "",
      dishPrice: snapshot.data['dishPrice'] ?? 0,
      dishRatings: snapshot.data['dishRatings'] ?? 0.0,
      dishPic: snapshot.data['dishPic'] ?? null,
      dishAval: snapshot.data['dishAval'] ?? false,
      dishPrepTime: snapshot.data['dishPrepTime'] ?? 0,
      dishKcal: snapshot.data['dishKcal'] ?? 0.0,
      dishFat: snapshot.data['dishFat'] ?? 0.0,
      dishCarbs: snapshot.data['dishCarbs'] ?? 0.0,
      dishProtein: snapshot.data['dishProtein'] ?? 0.0,
      dishAddDate: snapshot.data['dishAddDate'] ?? null,
      dishUpdateDate: snapshot.data['dishUpdateDate'] ?? null,
      // chefID: snapshot.data['chefID'] ?? "",
      // ctgID: fetchDishCtgName(snapshot.data['ctgID']) ?? 0,
      // attrID: fetchDishAttrName(snapshot.data['attrID']) ?? 0,
    );
  }

// Get user doc stream
  Stream<Dish> get getDishData {
    print("----> Getting DishData from inside DatabaseService class");
    var chefDishes;
    try {
      chefDishes = dishCollection
          .document(1.toString())
          .snapshots()
          .map(_dishDataFromSnapshot);
      // chefDishes =
      //     dishCollection.where("chefID", isEqualTo: uid).getDocuments();
    } catch (error) {
      print("----> ERROR in getDishData: " + error.toString());
    }

    return chefDishes;
  }

  Future<Map<String, dynamic>> getChefDishList() async {
    Map<String, dynamic> chefDishes;
    var result =
        await dishCollection.where("chefID", isEqualTo: uid).getDocuments();

    result.documents.forEach((eachResult) {
      // chefDishes = eachResult.data;
      dishCollection.document().snapshots().map(_dishDataFromSnapshot);
      print("_______GetDIsheachResult: " + eachResult.data.toString());
    });

    return chefDishes;
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
// -------------------------------------------------------------------- Custom queries functions

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

    if (chefResult.documents.length > 0) {
      print("Chef Case is true___________");
      return "chef";
    } else if (custResult.documents.length > 0) {
      print("Cust Case is true___________");
      return "cust";
    } else {
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
