class Order {
  String orderID;
  String custID;
  String custName;
  String chefID;
  String phoneNo;
  List orderStatus;
  Map<String, dynamic> items;
  dynamic orderDate;
  dynamic shippedDate;
  Map<String, dynamic> shippingAddress;
  double total;

  Order({
    this.orderID,
    this.custID,
    this.custName,
    this.phoneNo,
    this.shippedDate,
    this.orderStatus,
    this.items,
    this.orderDate,
    this.shippingAddress,
    this.total,
    this.chefID,
  });
}
