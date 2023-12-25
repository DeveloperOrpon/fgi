import 'dart:convert';
import 'dart:developer';

import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/helper/helperFunction.dart';

class WishController extends GetxController {
  static const wishProduct = 'wishProductList';
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxList<ProductModel> wishListProduct = RxList([]);

  @override
  void onInit() {
    getOnWishList();
    super.onInit();
  }

  addOnWishList(ProductModel productModel) async {
    String? vale = await getProduct();
log("Value: $vale");
    if (vale == null || vale.isEmpty) {
      WishModel wishModel = WishModel(data: [productModel]);
      storeProduct(json.encode(wishModel.toJson()));
    } else {
      Map<String, dynamic> productMap = json.decode(vale);
      WishModel wishModel = WishModel.fromJson(productMap);
      var check = wishModel.data!
          .firstWhereOrNull((element) => element.pId == productModel.pId);
      if (check == null) {
        log("productModel:Main ${productModel.toJson()}");
        for (ProductModel p in wishModel.data ?? []) {
          log("productModel${productModel.toJson()}");
        }
        wishModel.data!.add(productModel);
        storeProduct(json.encode(wishModel.toJson()));
      }
    }
  }

  removeOnWishList(ProductModel productModel) async {
    String? vale = await getProduct();
    if (vale == null) {
      return;
    } else {
      Map<String, dynamic> productMap = json.decode(vale);
      WishModel wishModel = WishModel.fromJson(productMap);
      var check = wishModel.data!
          .firstWhereOrNull((element) => element.pId == productModel.pId);
      if (check != null) {
       var reamning= wishModel.data!.where((element) => element.pId!=productModel.pId).toList();
       log('reamning :${reamning.length}');
        WishModel newWishModel=WishModel(data: reamning);
        storeProduct(json.encode(newWishModel.toJson()));
        wishListProduct.value=[];
        getOnWishList();
      }
    }
  }

  Future<List<ProductModel>> getOnWishList() async {
    String? vale = await getProduct();
    log("WishListProduct: ${vale}");
    if (vale == null) {
      return [];
    } else {
      Map<String, dynamic> productMap = json.decode(vale);
      WishModel wishModel = WishModel.fromJson(productMap);
      wishListProduct.value = wishModel.data ?? [];
      return wishModel.data ?? [];
    }
  }

  static Future<String?> getProduct() async {
    final localBD = await SharedPreferences.getInstance();
    printLog("${localBD.getString(wishProduct)}");
    return localBD.getString(wishProduct);
  }

  static Future<bool?> storeProduct(String value) async {
    final localBD = await SharedPreferences.getInstance();
    return localBD.setString(wishProduct, value);
  }
}

class WishModel {
  List<ProductModel>? data;

  WishModel({this.data});

  WishModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductModel>[];
      json['data'].forEach((v) {
        data!.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
