import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_diet/core/models/user.dart';

class DatabaseService {
  // collection reference is just reference for certain collection
  final CollectionReference custCollection =
      Firestore.instance.collection('customer');
  final CollectionReference chefCollection =
      Firestore.instance.collection('chef');
  final CollectionReference dishCollection =
      Firestore.instance.collection('dish');

  final String uid;
  DatabaseService({this.uid});

  // ------------------------------- UPDATION AND RETRIVAL OF CUSTOMER DATA

  //
  // >>>>>>>>>>>>>>>> S E T T I N G   D A T A
  //
  Future updateCustData(Map<String, dynamic> dataMap) async {
    // await custCollection.document(uid).setData({
    //   'username': username,
    //   'residence': residence,
    //   //  'dateOfBirth': dateOfBirth
    // });

    print("uid inside UPDATE CUST DATA  FUNCTION ----------------: " + uid);
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
      custAddDate: (snapshot.data['custAddDate'] as Timestamp).toDate() ?? "",
      custGender: snapshot.data['custGender'] ?? "",
      custWeight: snapshot.data['custWeight'] ?? "",
      custHeight: snapshot.data['custHeight'] ?? "",
      custfavs: snapshot.data['custfavs'] ?? "",
      custLocation: snapshot.data['custLocation'] ?? "",
      custOrders: snapshot.data['custOrders'] ?? "",
    );
  }

  // Get user doc stream
  Stream<CustData> get getCustData {
    return custCollection.document(uid).snapshots().map(_custDataFromSnapshot);
  }

  // ------------------------------- UPDATION AND RETRIVAL OF CHEF DATA

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

// ------------------------------- UPDATION AND RETRIVAL OF DISH DATA

  Future updateDishData(Map<String, dynamic> dataMap) async {
    final dishLength = dishCollection.snapshots().length;

    print("DishLength: " + dishLength.toString());
    await dishCollection.document(dishLength.toString()).setData(
      {
        'dishID': dishLength,
        'dishAddDate': DateTime.now(),
      },
      merge: true,
    );

    // - Dynamically adding data in the db
    // dataMap.forEach(
    //   (key, value) async {
    //     await dishCollection.document(uid).setData(
    //       {
    //         key: value,
    //       },
    //       merge: true,
    //     );
    //   },
    // );
  }

// Cust data from snapshot (For retrival)
//   ChefData _chefDataFromSnapshot(DocumentSnapshot snapshot) {
//     return ChefData(
//       chefId: uid,
//       chefName: snapshot.data['chefName'] ?? "",
//       chefPhNo: snapshot.data['chefPhNo'] ?? "",
//       chefDateOfBirth:
//           (snapshot.data['chefDateOfBirth'] as Timestamp).toDate() ?? "",
//       chefAddDate: (snapshot.data['chefAddDate'] as Timestamp).toDate(),
//       chefLocation: snapshot.data['chefLocation'] ?? "",
//       chefRatings: snapshot.data['chefLocation'] ?? null,
//       chefFollowers: snapshot.data['chefFollowers'] ?? [],
//       chefDishes: snapshot.data['chefDishes'] ?? [],
//       chefPicture: snapshot.data['chefPicture'] ?? "",
//       chefBio: snapshot.data['chefBio'] ?? "",
//     );
//   }

// // Get user doc stream
//   Stream<ChefData> get getChefData {
//     return chefCollection.document(uid).snapshots().map(_chefDataFromSnapshot);
//   }

// -------------------------------------------------------------------- Custom queries functions

// This function is just to check if the the passed user ID is of customer or chef
  Future<String> checkUserID(String userID) async {
    final custCheck =
        (await custCollection.where("custID", isEqualTo: userID).getDocuments())
            .documents;
    final chefCheck =
        (await chefCollection.where("chefID", isEqualTo: userID).getDocuments())
            .documents;

    print("cust.documents.exist in custUserFuctnion for " +
        userID +
        " : ____________ " +
        custCheck.toString());
    print("chef.documents.exist in chefUserFuctnion for " +
        userID +
        " : ____________ " +
        chefCheck.toString());

    if (custCheck.length > 0) {
      print("Cust check........");
      return "cust";
    } else if (chefCheck.length > 0) {
      print("Chef check........");
      return "chef";
    }
    print("Returning null from database.dart .................");
    return null;

    // ---> https://stackoverflow.com/a/51122369
  }

// - This function is to check if phone no exist in either "chef" or "customer"
  Future<String> isPhoneNoAlreadyRegistered(String _phoneNo) async {
    //bool x = chefCollection.where("chefPnNo", isEqualTo: _phoneNo);

//  final custCheck = await custCollection.document("custId").get();
//     final chefCheck = await chefCollection.document("chefId").get().;
    // chefCollection.document('chefPhNo').snapshots().forEach((element) {
    //   element.exists;
    // });
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
      return null;
    }

    // * For further quering
    // result.documents.forEach((fetchedPh) {
    // });
  }

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
}

// Get customers stream
// Stream<List<CustData>> get customers {
//   return custCollection.snapshots().map(_customerDataListFromSnapShot);
// }

// // Customers DataList from snapshot for our convinece
// List<CustData> _customerDataListFromSnapShot(QuerySnapshot snapshot) {
//   return snapshot.documents.map((i) {
//     return CustData(
//       username: i.data['username'] ?? '',
//       residence: i.data['residence'] ?? '',
//       dateOfBirth: i.data['dateOfBirth'] ?? DateTime.now(),
//     );
//   }).toList();
// }
