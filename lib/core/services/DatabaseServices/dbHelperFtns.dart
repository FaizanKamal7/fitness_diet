import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_diet/core/services/DatabaseServices/database.dart';

class DBHelperFtns extends DatabaseService {
// -------- Counting total number of dishes
  Future<int> countDishDocuments() async {
    QuerySnapshot _myDoc = await dishCollection.getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    return _myDocCount.length;
  }

// -------- Returning last document ID number for non user Collections
  Future<int> lastDocumentIdNumber(
      CollectionReference collection, String fieldName) async {
    print('last document function.********');
    QuerySnapshot _myDoc = await collection.getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    if (_myDocCount.length == 0) {
      return 0;
    } else {
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

// -------- Fetching category name using ctg-ID
  Future<String> ctgIDToName(DocumentSnapshot passedID) async {
    QuerySnapshot ctgName = await dishCtgCollection
        .where("ctgID", isEqualTo: passedID)
        .getDocuments();
    print("------> ctgName from fetchDishCtgName" + ctgName.documents .toString());
    return ctgName.toString();
  }

// -------- Fetching category name using ctg-ID
  Future<String> ctgNameToID(DocumentSnapshot passedName) async {
    QuerySnapshot ctgName = await dishCtgCollection
        .where("ctgName", isEqualTo: passedName)
        .getDocuments();
    print("------> ctgName from fetchDishCtgName" + ctgName.toString());
    return ctgName.toString();
  }

// -------- Fetching Attribute name using ctg-ID
  Future<String> attrIDToName(String passedID) async {
    QuerySnapshot attrName = await dishAttrCollection
        .where("attrID", isEqualTo: passedID)
        .getDocuments();
    print("------> attrName from fetchDishattrName" + attrName.toString());
    return attrName.toString();
  }

  // -------- Fetching Attribute name using ctg-ID
  Future<dynamic> attrNameToID(String passedName) async {
    String extractedID;
    var _completer = Completer<dynamic>();
    await dishAttrCollection
        .where("attrName", isEqualTo: passedName)
        .getDocuments()
        .then((data) {
      if (data.documents.length > 0) {
        extractedID = data.documents[0].data['attrID'].toString();
      }
      print("------> attrID from fetchDishattrID: " + extractedID);
      //  String _attrID = extractedID.toString();
      _completer.complete(extractedID);
      return _completer.future;
    });
    return _completer.future;
  }

  // -------- Extracting name using ID
  Future<dynamic> documentIDToName(
    CollectionReference passedCollection,
    String dbKeyNamOfID,
    String dbKeyNamOfName,
    String passedID,
  ) async {
    String _extractedName;
    var _completer = Completer<dynamic>();
    await passedCollection
        .where(dbKeyNamOfID, isEqualTo: passedID)
        .getDocuments()
        .then((data) {
      if (data.documents.length > 0) {
        _extractedName = data.documents[0].data[dbKeyNamOfName].toString();
      }
      print(
          "------> _extractedCHEFName from fetchDishattrID: " + _extractedName);

      _completer.complete(_extractedName);
      return _completer.future;
    });
    print(
        "------> returning _completer.future from documentIDToName from DBHelperFtns: " +
            _completer.future.toString());
    return _completer.future;
  }

  // -------- Extracting ID using Name
  Future<String> documentNameToID(
    CollectionReference passedCollection,
    String dbKeyNamOfName,
    String dbKeyNamOfID,
    String passedName,
  ) async {
    String _extractedID;
    var _completer = Completer<dynamic>();
   
    await passedCollection
        .where(dbKeyNamOfName, isEqualTo: passedName)
        .getDocuments()
        .then((data) {
      if (data.documents.length > 0) {
        _extractedID = data.documents[0].data[dbKeyNamOfID].toString();
      }
      print("------> attrID from fetchDishattrID: " + _extractedID);

      _completer.complete(_extractedID);
    });
    String _result = await _completer.future;
    print(
        "----------> Value of completer inside documentNameToID DBHelperFtns  : " +
            _result);
    return _result;
  }
  // // -------- Extracting ID using name
  // Future<dynamic> documentNameToID(CollectionReference passedCollection,
  //     String dbKeyNamOfName, DocumentSnapshot passedName) async {
  //   QuerySnapshot _extractedID = await passedCollection
  //       .where(dbKeyNamOfName, isEqualTo: passedName)
  //       .getDocuments();
  //   print("------> _extractedID from within DBHELPER FUNCTION" +
  //       _extractedID.toString());
  //   return _extractedID.documents.length > 0 ? _extractedID.toString() : null;
  // }

  Future<bool> feildExistInCollection(CollectionReference passedCollection,
      String dbKeyNamOfFeild, String passedFeild) async {
    print("-------> feildExistInCollection ftn inside DBHelper INVOKED");
    var _completer = Completer<bool>();
    await passedCollection
        .where(dbKeyNamOfFeild, isEqualTo: passedFeild)
        .getDocuments()
        .then((data) {
      if (data.documents.length > 0) {
        _completer.complete(true);
      } else {
        _completer.complete(false);
      }
    });
    print("-------> _completer.future inside DBHelper " +
        _completer.future.toString());
    return _completer.future;
  }
}
