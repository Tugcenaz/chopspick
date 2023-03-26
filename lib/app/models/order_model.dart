class OrderModel {
  String userId;
  int totalPrice;
  String? orderNote;

  OrderModel({required this.userId, required this.totalPrice, this.orderNote});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'totalPrice': totalPrice,
      'orderNote': orderNote,
    };
  }

  OrderModel.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        totalPrice = map['totalPrice'],
        orderNote = map['orderNote'];


}
