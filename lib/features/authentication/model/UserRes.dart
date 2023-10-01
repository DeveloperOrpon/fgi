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
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['jwt'] = this.jwt;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserModel {
  bool? isAccountVerified;
  bool? isEmailVerified;
  bool? cardVerified;
  bool? isAccountActive;
  String? sId;
  String? cartNumber;
  String? email;
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
      {this.isAccountVerified,
        this.isEmailVerified,
        this.cardVerified,
        this.isAccountActive,
        this.sId,
        this.cartNumber,
        this.email,
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
    isAccountVerified = json['isAccountVerified'];
    isEmailVerified = json['isEmailVerified'];
    cardVerified = json['cardVerified'];
    isAccountActive = json['isAccountActive'];
    sId = json['_id'];
    cartNumber = json['cartNumber'];
    email = json['email'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAccountVerified'] = this.isAccountVerified;
    data['isEmailVerified'] = this.isEmailVerified;
    data['cardVerified'] = this.cardVerified;
    data['isAccountActive'] = this.isAccountActive;
    data['_id'] = this.sId;
    data['cartNumber'] = this.cartNumber;
    data['email'] = this.email;
    data['company'] = this.company;
    data['location'] = this.location;
    data['zipCode'] = this.zipCode;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['subscription'] = this.subscription;
    data['paymentMethod'] = this.paymentMethod;
    data['cardNumber'] = this.cardNumber;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}