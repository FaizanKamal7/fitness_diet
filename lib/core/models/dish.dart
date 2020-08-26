
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Dish {
  String dishID;
  String dishName;
  int dishPrice;
  double dishRatings;
  FileImage dishPic;
  bool dishAval;
  int dishPrepTime;
  double dishKcal;
  double dishFat;
  double dishCarbs;
  double dishProtein;
  Timestamp dishAddDate;
  Timestamp dishUpdateDate;
  String chefID; // - Foreign Key
  int attrID; // - Foreign Key
  int ctgID; // - Foreign Key

  Dish({
    this.dishID,
    this.dishName,
    this.dishPrice,
    this.dishRatings,
    this.dishPic,
    this.dishAval,
    this.dishPrepTime,
    this.dishKcal,
    this.dishFat,
    this.dishCarbs,
    this.dishProtein,
    this.dishAddDate,
    this.dishUpdateDate,
    this.chefID,
    this.attrID,
    this.ctgID,
  });
}

class Attribute {
  String attrID;
  String attrName;
  String attrAddDate;

  Attribute({
    this.attrID,
    this.attrName,
    this.attrAddDate,
  });
}

class DishCategory {
  String ctgID;
  String ctgName;
  String ctgAddDate;

  DishCategory({
    this.ctgID,
    this.ctgName,
    this.ctgAddDate,
  });
}
