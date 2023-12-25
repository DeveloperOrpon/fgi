import 'dart:developer';

class CartRes {
  String? sId;
  String? userEmail;
  List<CartModel>? items;
  num? total;
  String? createdAt;
  String? updatedAt;
  num? iV;

  CartRes(
      {this.sId,
        this.userEmail,
        this.items,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CartRes.fromJson(Map<String, dynamic> json) {
    try{
      sId = json['_id'];
      userEmail = json['user_email'];
      if (json['items'] != null) {
        items = <CartModel>[];
        json['items'].forEach((v) {
          items!.add(new CartModel.fromJson(v));
        });
      }
      total = json['total'];
      createdAt = json['createdAt'];
      updatedAt = json['updatedAt'];
      iV = json['__v'];
    }catch(e){
      log("ErrorModel: ${e.toString()}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_email'] = this.userEmail;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CartModel {
  String? productName;
  String? productImage;
  String? productId;
  String? productUnitType;
  num? unitFlag;
  num? quantity;
  num? price;
  num? afterDiscount;
  num? discount;
  String? sId;
  String? createdAt;
  String? updatedAt;
  num? productUnitValue;
  String? productUnit;
  bool isCheck=true;

  CartModel(
      {this.productName,
        this.productImage,
        this.productId,
        this.productUnitType,
        this.unitFlag,
        this.quantity,
        this.price,
        this.afterDiscount,
        this.discount,
        this.sId,
        this.isCheck=true,
        this.productUnitValue,
        this.createdAt,
        this.productUnit,
        this.updatedAt});

  CartModel.fromJson(Map<String, dynamic> json) {
   try{
     productName = json['product_name'];
     productImage = json['product_image'];
     productId = json['product_id'];
     productUnitType = json['product_unit_type'];
     productUnit = json['product_unit'];
     productUnitValue = json['product_unit_value'];
     unitFlag = json['unit_flag'];
     quantity = json['quantity'];
     price = json['price'];
     afterDiscount = json['afterDiscount'];
     discount = json['discount'];
     sId = json['_id'];
     createdAt = json['createdAt'];
     updatedAt = json['updatedAt'];
     isCheck = json['isCheck']??true;
   }catch(e){
     log("ErrorModel: ${e.toString()}");
   }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_unit_value'] = this.productUnitValue;
    data['product_unit'] = this.productUnit;
    data['product_image'] = this.productImage;
    data['product_id'] = this.productId;
    data['product_unit_type'] = this.productUnitType;
    data['unit_flag'] = this.unitFlag;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['afterDiscount'] = this.afterDiscount;
    data['discount'] = this.discount;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}