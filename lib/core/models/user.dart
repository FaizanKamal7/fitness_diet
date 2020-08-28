class User {
  String uid;
  User({this.uid});

  User.initial() : uid = '';
  String get getUid => this.uid;

  // User.fromJson(Map<String, dynamic> json) {
  //   uid = json['id'];
  //   name = json['name'];
  //   username = json['username'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.uid;
  //   data['name'] = this.name;
  //   data['username'] = this.username;
  //   return data;
  // }
}

class CustData {
  String custId;
  String custName;
  String custPhNo;
  DateTime custDateOfBirth;
  DateTime custAddDate;
  List custfavs;
  String custLocation;
  List custOrders;
  String custGender;
  String custWeight;
  String custHeight;
  List custFollowing;
  String pId;

  CustData({
    this.custId,
    this.custName,
    this.custPhNo,
    this.custDateOfBirth,
    this.custAddDate,
    this.custGender,
    this.custWeight,
    this.custHeight,
    this.custfavs,
    this.custLocation,
    this.custOrders,
    this.custFollowing,
    this.pId,
  });
}

class ChefData {
  String chefId;
  String chefName;
  String chefPhNo;
  DateTime chefDateOfBirth;
  DateTime chefAddDate;
  String chefLocation;
  int chefRatings;
  List chefFollowers;
  List chefDishes;
  String chefPicture;
  String chefBio;
  // Map<String, dynamic> keyValuesPairs;
//  ChefData(this.keyValuesPairs);

  ChefData({
    this.chefId,
    this.chefName,
    this.chefPhNo,
    this.chefDateOfBirth,
    this.chefAddDate,
    this.chefDishes,
    this.chefFollowers,
    this.chefLocation,
    this.chefPicture,
    this.chefRatings,
    this.chefBio,
  });
}
