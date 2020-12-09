class CurrentUser {
  String uid;
  CurrentUser({this.uid});

  CurrentUser.initial() : uid = '';
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
  String custContactNo;
  var custDateOfBirth;
  String custPic;
  List custfavs;

// Map<String, dynamic>
  Map<String, dynamic> custaddress;
  List custOrders;
  String custGender;
  String custWeight;
  String custHeight;
  List custFollowing;
  DateTime custAddDate;
  DateTime custUpdateDate;
  String cartID;

  String planID;

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
    this.custaddress,
    this.custOrders,
    this.custFollowing,
    this.custPic,
    this.planID,
    this.custUpdateDate,
    this.cartID,
    this.custContactNo,
  });
}

class ChefData {
  String chefID;
  String chefName;
  String chefPhNo;
  var chefDateOfBirth;
  var chefAddDate;
  String chefLocation;
  int chefRatings;
  List chefFollowers;
  List chefDishes;
  String chefPic;
  String chefBio;
  var chefUpdateDate;
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

class DelivData {
  String delivID;
  String delivName;
  String delivPhNo;
  var delivDateOfBirth;
  Map<String, dynamic> delivaddress;
  DateTime delivAddDate;
  DateTime delivUpdateDate;

  DelivData({
    this.delivID,
    this.delivName,
    this.delivDateOfBirth,
    this.delivPhNo,
    this.delivaddress,
    this.delivAddDate,
    this.delivUpdateDate,
  });
}
