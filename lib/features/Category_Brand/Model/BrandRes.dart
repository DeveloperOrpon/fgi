class BrandRes {
  int? status;
  Meta? meta;
  List<BrandModel>? data;

  BrandRes({this.status, this.meta, this.data});

  BrandRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <BrandModel>[];
      json['data'].forEach((v) {
        data!.add(new BrandModel.fromJson(v));
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
  int? totalBrands;
  int? totalPage;
  int? currentPage;
  int? perPage;

  Meta({this.totalBrands, this.totalPage, this.currentPage, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalBrands = json['total_brands'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_brands'] = this.totalBrands;
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    data['per_page'] = this.perPage;
    return data;
  }
}

class BrandModel {
  String? sId;
  String? brandLabel;
  String? brandSlug;
  String? brandImage;
  int? iV;

  BrandModel({this.sId, this.brandLabel, this.brandSlug, this.brandImage, this.iV});

  BrandModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    brandLabel = json['brand_label'];
    brandSlug = json['brand_slug'];
    brandImage = json['brand_image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['brand_label'] = this.brandLabel;
    data['brand_slug'] = this.brandSlug;
    data['brand_image'] = this.brandImage;
    data['__v'] = this.iV;
    return data;
  }
}