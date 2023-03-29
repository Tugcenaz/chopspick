class UserModel {
  String? email;
  String? userId;
  String? picture;
  String? userName;
  int? balance;
  int? createdAt;

  UserModel(
      {this.email,
      this.userId,
      this.picture,
      this.userName,
      this.balance=0,
      this.createdAt=0
      });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userId': userId,
      'picture': picture,
      'userName': userName,
      'balance': balance,
      'createdAt': createdAt,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : email = map['email'],
        userId = map['userId'],
        picture = map['picture'],
        userName = map['userName'],
        balance = map['balance'],
        createdAt = map['createdAt'];

  @override
  String toString() {
    return 'UserModel{email: $email, userId: $userId, picture: $picture, userName: $userName, balance: $balance, createdAt: $createdAt}';
  }
}
