class UserRes {
  String? message;
  int? status;
  String? jwt;
  UserModel? data;

  UserRes({this.message, this.status, this.jwt, this.data});

  UserRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    jwt = json['jwt'];
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['jwt'] = jwt;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserModel {
  String? sId;
  String? cartNumber;
  String? email;
  String? password;
  String? company;
  String? location;
  String? zipCode;
  String? firstName;
  String? lastName;
  String? subscription;
  String? paymentMethod;
  String? cardNumber;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserModel(
      {this.sId,
        this.cartNumber,
        this.email,
        this.password,
        this.company,
        this.location,
        this.zipCode,
        this.firstName,
        this.lastName,
        this.subscription,
        this.paymentMethod,
        this.cardNumber,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cartNumber = json['cartNumber'];
    email = json['email'];
    password = json['password'];
    company = json['company'];
    location = json['location'];
    zipCode = json['zipCode'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    subscription = json['subscription'];
    paymentMethod = json['paymentMethod'];
    cardNumber = json['cardNumber'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['cartNumber'] = cartNumber;
    data['email'] = email;
    data['password'] = password;
    data['company'] = company;
    data['location'] = location;
    data['zipCode'] = zipCode;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['subscription'] = subscription;
    data['paymentMethod'] = paymentMethod;
    data['cardNumber'] = cardNumber;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}