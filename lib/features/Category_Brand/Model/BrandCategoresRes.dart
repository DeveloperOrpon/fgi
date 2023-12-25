import 'CategoryRes.dart';

class BrandCategoriesRes {
  int? status;
  Meta? meta;
  List<CategoryModel>? data;

  BrandCategoriesRes({this.status, this.meta, this.data});

  BrandCategoriesRes.fromJson(Map<String, dynamic> json) {
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
