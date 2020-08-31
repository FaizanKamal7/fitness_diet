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
  String custPic;
  List custfavs;
  String custLocation;
  List custOrders;
  String custGender;
  String custWeight;
  String custHeight;
  List custFollowing;
  DateTime custAddDate;
  DateTime custUpdateDate;

  String planID;

  CustData(
      {this.custId,
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
      this.custPic,
      this.planID,
      this.custUpdateDate});
}

class ChefData {
  String chefID;
  String chefName;
  String chefPhNo;
  DateTime chefDateOfBirth;
  DateTime chefAddDate;
  String chefLocation;
  int chefRatings;
  List chefFollowers;
  List chefDishes;
  String chefPic;
  String chefBio;
  DateTime chefUpdateDate;
  bool hasDish;
  // Map<String, dynamic> keyValuesPairs;
//  ChefData(this.keyValuesPairs);

  ChefData({
    this.chefID,
    this.chefName,
    this.chefPhNo,
    this.chefDateOfBirth,
    this.chefAddDate,
    this.chefDishes,
    this.chefFollowers,
    this.chefLocation,
    this.chefPic,
    this.chefRatings,
    this.chefBio,
    this.chefUpdateDate,
    this.hasDish,
  });
}
