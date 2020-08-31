import 'package:cloud_firestore/cloud_firestore.dart';

class Dish {
  String dishID;
  String dishName;
  double dishRatings;
  String dishPic;
  bool dishAval;
  int dishPrepTime;
  double dishKcal;
  double dishFat;
  int dishPrice;
  double dishCarbs;
  double dishProtein;
  Timestamp dishAddDate;
  Timestamp dishUpdateDate;
  String chefName; // Jugar
  String chefID; // - Foreign Key
  String attrID; // - Foreign Key
  String ctgID; // - Foreign Key

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
    this.chefName,
    this.chefID,
    this.attrID,
    this.ctgID,
  });
}

class Attribute {
  String attrID;
  String attrName;
  Timestamp attrAddDate;

  Attribute({
    this.attrID,
    this.attrName,
    this.attrAddDate,
  });
}

class DishCategory {
  String ctgID;
  String ctgName;
  Timestamp ctgAddDate;

  DishCategory({
    this.ctgID,
    this.ctgName,
    this.ctgAddDate,
  });
}
