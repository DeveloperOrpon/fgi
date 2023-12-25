class OrderResponse {
  Meta? meta;
  List<OrderResModel>? data;

  OrderResponse({this.meta, this.data});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <OrderResModel>[];
      json['data'].forEach((v) {
        data!.add(new OrderResModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? totalOrders;
  int? limit;
  int? currentPage;
  int? totalPages;

  Meta({this.totalOrders, this.limit, this.currentPage, this.totalPages});

  Meta.fromJson(Map<String, dynamic> json) {
    totalOrders = json['totalOrders'];
    limit = json['limit'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalOrders'] = this.totalOrders;
    data['limit'] = this.limit;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class OrderResModel {
  String? sId;
  String? userEmail;
  String? userName;
  String? userAddress;
  num? orderStatus;
  String? pickupTime;
  String? additionalInformation;
  List<Items>? items;
  num? totalCost;
  String? createdAt;
  String? updatedAt;
  num? iV;

  OrderResModel(
      {this.sId,
        this.userEmail,
        this.userName,
        this.userAddress,
        this.orderStatus,
        this.pickupTime,
        this.additionalInformation,
        this.items,
        this.totalCost,
        this.createdAt,
        this.updatedAt,
        this.iV});

  OrderResModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userEmail = json['user_email'];
    userName = json['user_name'];
    userAddress = json['user_address'];
    orderStatus = json['order_status'];
    pickupTime = json['pickup_time'];
    additionalInformation = json['additional_information'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalCost = json['totalCost'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_email'] = this.userEmail;
    data['user_name'] = this.userName;
    data['user_address'] = this.userAddress;
    data['order_status'] = this.orderStatus;
    data['pickup_time'] = this.pickupTime;
    data['additional_information'] = this.additionalInformation;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalCost'] = this.totalCost;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Items {
  String? productName;
  dynamic? productImage;
  num? productQuantity;
  num? productPrice;
  String? productId;
  String? sId;
  String? createdAt;
  String? updatedAt;
  num? product_unit_value;
  String? productUnitType;
  num? unitFlag;

  Items(
      {this.productName,
        this.productImage,
        this.productQuantity,
        this.productPrice,
        this.productId,
        this.sId,
        this.product_unit_value,
        this.productUnitType,
        this.unitFlag,
        this.createdAt,
        this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productImage = json['product_image'];
    productQuantity = json['product_quantity'];
    productPrice = json['product_price'];
    productId = json['product_id'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product_unit_value = json['product_unit_value']??0;
    productUnitType = json['product_unit_type']??'Piece';
    unitFlag = json['unit_flag']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['product_quantity'] = this.productQuantity;
    data['product_price'] = this.productPrice;
    data['product_id'] = this.productId;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}