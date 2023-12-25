class UserRes {
  String? message;
  int? status;
  String? jwt;
  String? refreshToken;
  UserModel? data;

  UserRes({this.message, this.status, this.jwt, this.refreshToken, this.data});

  UserRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    jwt = json['jwt'];
    refreshToken = json['refreshToken'];
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['jwt'] = this.jwt;
    data['refreshToken'] = this.refreshToken;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserModel {
  int? acStatus;
  String? sId;
  String? cartNumber;
  String? email;
  String? company;
  String? companySlug;
  bool? isAccountVerified;
  bool? isEmailVerified;
  bool? cardVerified;
  String? phoneNumber;
  bool? isAccountActive;
  String? profilePicture;
  String? location;
  String? zipCode;
  String? firstName;
  String? lastName;
  String? paymentMethod;
  String? cardNumber;
  List<String>? firebaseFCM;
  String? companyAssignedBy;
  dynamic? resetPasswordToken;
  dynamic? resetPasswordExpires;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserModel(
      {this.acStatus,
        this.sId,
        this.cartNumber,
        this.email,
        this.company,
        this.companySlug,
        this.isAccountVerified,
        this.isEmailVerified,
        this.cardVerified,
        this.phoneNumber,
        this.isAccountActive,
        this.profilePicture,
        this.location,
        this.zipCode,
        this.firstName,
        this.lastName,
        this.paymentMethod,
        this.cardNumber,
        this.firebaseFCM,
        this.companyAssignedBy,
        this.resetPasswordToken,
        this.resetPasswordExpires,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    acStatus = json['ac_status'];
    sId = json['_id'];
    cartNumber = json['cartNumber'];
    email = json['email'];
    company = json['company'];
    companySlug = json['company_slug'];
    isAccountVerified = json['isAccountVerified'];
    isEmailVerified = json['isEmailVerified'];
    cardVerified = json['cardVerified'];
    phoneNumber = json['phoneNumber'];
    isAccountActive = json['isAccountActive'];
    profilePicture = json['profilePicture'];
    location = json['location'];
    zipCode = json['zipCode'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    paymentMethod = json['paymentMethod'];
    cardNumber = json['cardNumber'];
    firebaseFCM = json['firebaseFCM'].cast<String>();
    companyAssignedBy = json['companyAssignedBy'];
    resetPasswordToken = json['resetPasswordToken'];
    resetPasswordExpires = json['resetPasswordExpires'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ac_status'] = this.acStatus;
    data['_id'] = this.sId;
    data['cartNumber'] = this.cartNumber;
    data['email'] = this.email;
    data['company'] = this.company;
    data['company_slug'] = this.companySlug;
    data['isAccountVerified'] = this.isAccountVerified;
    data['isEmailVerified'] = this.isEmailVerified;
    data['cardVerified'] = this.cardVerified;
    data['phoneNumber'] = this.phoneNumber;
    data['isAccountActive'] = this.isAccountActive;
    data['profilePicture'] = this.profilePicture;
    data['location'] = this.location;
    data['zipCode'] = this.zipCode;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['paymentMethod'] = this.paymentMethod;
    data['cardNumber'] = this.cardNumber;
    data['firebaseFCM'] = this.firebaseFCM;
    data['companyAssignedBy'] = this.companyAssignedBy;
    data['resetPasswordToken'] = this.resetPasswordToken;
    data['resetPasswordExpires'] = this.resetPasswordExpires;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
