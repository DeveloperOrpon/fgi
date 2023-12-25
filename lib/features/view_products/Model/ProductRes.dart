class ProductRes {
  num? status;
  Meta? meta;
  List<ProductModel>? data;

  ProductRes({this.status, this.meta, this.data});

  ProductRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <ProductModel>[];
      json['data'].forEach((v) {
        data!.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
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
  num? currentPage;
  num? perPage;
  num? totalPages;
  num? totalProducts;

  Meta({this.currentPage, this.perPage, this.totalPages, this.totalProducts});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    totalPages = json['total_pages'];
    totalProducts = json['total_products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['per_page'] = this.perPage;
    data['total_pages'] = this.totalPages;
    data['total_products'] = this.totalProducts;
    return data;
  }
}

class ProductModel {
  String? pId;
  String? name;
  bool? isDisable;
  String? subcategorySlug;
  String? brandSlug;
  String? brandId;
  String? brandName;
  String? categoryId;
  String? categoryName;
  String? subcategoryId;
  String? subcategoryName;
  String? productImage;
  num? discount;
  List<String>? fetImage;
  num? minPurchease;
  num? maxPurchease;
  String? productUnitType;
  num? productUnitQuantity;
  num? unitFlag;
  num? price;
  String? productInformation;
  List<Varient>? varient;
  List<Sku>? sku;
  String? createdAt;
  String? updatedAt;
  String? productSlug;
  num? iV;
  num? afterDiscount;
  num? productUnitValue;

  ProductModel(
      {this.pId,
        this.name,
        this.isDisable,
        this.subcategorySlug,
        this.brandSlug,
        this.brandId,
        this.brandName,
        this.categoryId,
        this.categoryName,
        this.subcategoryId,
        this.subcategoryName,
        this.productImage,
        this.discount,
        this.fetImage,
        this.minPurchease,
        this.maxPurchease,
        this.productUnitType,
        this.productUnitQuantity,
        this.unitFlag,
        this.price,
        this.productInformation,
        this.varient,
        this.sku,
        this.createdAt,
        this.updatedAt,
        this.productSlug,
        this.iV,
        this.productUnitValue,
        this.afterDiscount});

  ProductModel.fromJson(Map<String, dynamic> json) {
    pId = json['_id'];
    name = json['name'];

    productUnitValue = json['product_unit_quantity'];
    isDisable = json['isDisable'];
    subcategorySlug = json['subcategory_slug'];
    brandSlug = json['brand_slug'];
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    productImage = json['product_image'];
    discount = json['discount'];
    fetImage = json['fet_image'].cast<String>();
    minPurchease = json['min_purchease'];
    maxPurchease = json['max_purchease'];
    productUnitType = json['product_unit_type'];
    productUnitQuantity = json['product_unit_quantity'];
    unitFlag = json['unit_flag'];
    price = json['price'];
    productInformation = json['product_information'];
    if (json['varient'] != null) {
      varient = <Varient>[];
      json['varient'].forEach((v) {
        varient!.add(new Varient.fromJson(v));
      });
    }
    if (json['sku'] != null) {
      sku = <Sku>[];
      json['sku'].forEach((v) {
        sku!.add(new Sku.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productSlug = json['product_slug'];
    iV = json['__v'];
    afterDiscount = json['afterDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.pId;
    data['name'] = this.name;
    data['isDisable'] = this.isDisable;
    data['subcategory_slug'] = this.subcategorySlug;
    data['brand_slug'] = this.brandSlug;
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['subcategory_id'] = this.subcategoryId;
    data['subcategory_name'] = this.subcategoryName;
    data['product_image'] = this.productImage;
    data['discount'] = this.discount;
    data['fet_image'] = fetImage;
    data['min_purchease'] = this.minPurchease;
    data['max_purchease'] = this.maxPurchease;
    data['product_unit_type'] = this.productUnitType;
    data['product_unit_quantity'] = this.productUnitQuantity;
    data['unit_flag'] = this.unitFlag;
    data['price'] = this.price;
    data['product_information'] = this.productInformation;
    if (this.varient != null) {
      data['varient'] = this.varient!.map((v) => v.toJson()).toList();
    }
    if (this.sku != null) {
      data['sku'] = this.sku!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['product_slug'] = this.productSlug;
    data['__v'] = this.iV;
    data['afterDiscount'] = this.afterDiscount;
    return data;
  }
}

class Varient {
  String? sId;
  num? basePrice;
  num? discount;
  num? price;
  num? minPurchease;
  num? maxPurchease;

  Varient(
      {this.sId,
        this.basePrice,
        this.discount,
        this.price,
        this.minPurchease,
        this.maxPurchease});

  Varient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    basePrice = json['base_price'];
    discount = json['discount'];
    price = json['price'];
    minPurchease = json['min_purchease'];
    maxPurchease = json['max_purchease'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['base_price'] = this.basePrice;
    data['discount'] = this.discount;
    data['price'] = this.price;
    data['min_purchease'] = this.minPurchease;
    data['max_purchease'] = this.maxPurchease;
    return data;
  }
}

class Sku {
  String? sId;
  num? booked;
  num? available;
  num? ongoing;
  num? stock;
  String? refId;

  Sku(
      {this.sId,
        this.booked,
        this.available,
        this.ongoing,
        this.stock,
        this.refId});

  Sku.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    booked = json['booked'];
    available = json['available'];
    ongoing = json['ongoing'];
    stock = json['stock'];
    refId = json['ref_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['booked'] = this.booked;
    data['available'] = this.available;
    data['ongoing'] = this.ongoing;
    data['stock'] = this.stock;
    data['ref_id'] = this.refId;
    return data;
  }
}