class CategoriesRs {
  int? status;
  Meta? meta;
  List<CategoryModel>? data;

  CategoriesRs({this.status, this.meta, this.data});

  CategoriesRs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <CategoryModel>[];
      json['data'].forEach((v) {
        data!.add(new CategoryModel.fromJson(v));
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
  int? totalCategories;
  int? totalPage;
  int? currentPage;
  int? perPage;

  Meta({this.totalCategories, this.totalPage, this.currentPage, this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalCategories = json['total_categories'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_categories'] = this.totalCategories;
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    data['per_page'] = this.perPage;
    return data;
  }
}

class CategoryModel {
  String? sId;
  String? categoryLabel;
  String? categoryType;
  String? image;
  String? brandId;
  List<SubCategories>? subCategories;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryModel(
      {this.sId,
        this.categoryLabel,
        this.categoryType,
        this.image,
        this.brandId,
        this.subCategories,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryLabel = json['category_label'];
    categoryType = json['category_type'];
    image = json['image'];
    brandId = json['brand_id'];
    if (json['subCategories'] != null) {
      subCategories = <SubCategories>[];
      json['subCategories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category_label'] = this.categoryLabel;
    data['category_type'] = this.categoryType;
    data['image'] = this.image;
    data['brand_id'] = this.brandId;
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SubCategories {
  String? brandId;
  String? categoryId;
  String? subcategoryName;
  String? image;
  String? slug;
  String? description;
  String? sId;
  String? createdAt;
  String? updatedAt;

  SubCategories(
      {this.brandId,
        this.categoryId,
        this.subcategoryName,
        this.image,
        this.slug,
        this.description,
        this.sId,
        this.createdAt,
        this.updatedAt});

  SubCategories.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    categoryId = json['category_id'];
    subcategoryName = json['subcategory_name'];
    image = json['image'];
    slug = json['slug'];
    description = json['description'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['category_id'] = this.categoryId;
    data['subcategory_name'] = this.subcategoryName;
    data['image'] = this.image;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}