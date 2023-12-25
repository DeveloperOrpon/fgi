import 'dart:developer';

import 'package:animate_icons/animate_icons.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:fgi_y2j/Api/Interceptors/OfflineInterceptor.dart';
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/BrandCategoresRes.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/BrandRes.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/CategoryByProductRes.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Api/Interceptors/ConnectivityRequestRetrier.dart';
import '../../../Api/Interceptors/RetryOnConnectionChangeIntercptor.dart';
import '../../../Api/api_route.dart';
import '../../authentication/controller/AuthenticationController.dart';
import '../../authentication/model/UserRes.dart';
import '../Model/CategoryRes.dart';

class CategoryController extends GetxController {
  final bottomBarController = BottomBarWithSheetController(initialIndex: 0);
  final productScrollController = ScrollController();
  final animation = AnimateIconController();
  RxBool isDrawerOpen = RxBool(false);
  RxBool isListAllProduct = RxBool(false);
  Rxn<CategoriesRs> categoryRes = Rxn<CategoriesRs>();
  RxList<CategoryModel> categoryList = RxList<CategoryModel>([]);
  RxList<CategoryModel> allCategoryList = RxList<CategoryModel>([]);
  Rxn<BrandRes> brandRes = Rxn<BrandRes>();
  RxList<BrandModel> brandList = RxList<BrandModel>([]);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final RefreshController refreshBrandCategoryController =
      RefreshController(initialRefresh: false);
  final RefreshController allCategoryRefreshController =
      RefreshController(initialRefresh: false);
  final RefreshController allBrandsRefreshController =
      RefreshController(initialRefresh: false);
  final RefreshController refreshControllerBrand =
      RefreshController(initialRefresh: false);
  late DIO.Dio dio;

  ///error message

  @override
  void onInit() {
    bottomBarController.stream.listen((opened) {
      isDrawerOpen.value = opened;
    });
    productScrollController.addListener(() {
      animation.animateToStart();
      bottomBarController.closeSheet();
    });

    ///connection init
    DIO.BaseOptions options = DIO.BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2));
    dio = DIO.Dio(options);
    // _dio.interceptors.add(RetryInterceptor(dio: _dio));
    dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier:
            ConnectiveRequestRetrier(connectivity: Connectivity(), dio: dio)));
    super.onInit();

    ///inti method call
    getCategories();
    getAllBrands();
    getAllCategories();
  }

  ///function
  void onRefreshPage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoadingPage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

  ///all category refresh
  void onAllCategoryRefreshPage() async {
    categoryPage = 1;
    categoryRes.value = null;
    categoryList.value = [];
    await getCategories();
    allCategoryRefreshController.refreshCompleted();
  }

  void onAllCategoryLoadingPage() async {
    categoryPage++;
    await getCategories();
    allCategoryRefreshController.loadComplete();
  }

  ///all brand refresh
  int brandPage = 1;

  void onAllBrandRefreshPage() async {
    brandRes.value = null;
    brandList.value = [];
    brandPage = 1;
    await getAllBrands();
    allBrandsRefreshController.refreshCompleted();
  }

  void onAllBrandLoadingPage() async {
    brandPage++;
    await getAllBrands();
    allBrandsRefreshController.loadComplete();
  }

  ///get all categories
  int categoryPage = 1;

  Future<List<CategoryModel>> getCategories() async {
    final authController = Get.put(AuthenticationController());
    String url =
        "$ALL_CATEGORIES?brand_slug=${authController.userModel.value!.companySlug}&limit=15&page=$categoryPage";
    Map<String, dynamic>? cacheData =
        await DataCacheService(apiEndPoint: url).getData();

    if (cacheData == null) {
      try {
        final DIO.Response response = await dio.get(url);
        if (response.statusCode == 200) {
          Map<String, dynamic> serverJSON = response.data;
          log("CategoryFeatch: ${response.requestOptions.baseUrl}${response.requestOptions.path}");
          log("CategoryFeatch: ${response.data}");
          DataCacheService(apiEndPoint: url).setData(serverJSON);
          categoryRes.value = CategoriesRs.fromJson(serverJSON);
          if (categoryPage == 1) {
            categoryList.value = categoryRes.value!.data ?? [];
          } else {
            List<CategoryModel> tempCategory = categoryList.value;
            tempCategory.addAll(categoryRes.value!.data ?? []);
            categoryList.value = [];
            categoryList.value = tempCategory;
          }
          log("categoryList : ${categoryList.value.length}");
          return categoryList.value;
        }
        return [];
      } on DIO.DioException catch (e) {
        log("Error Categorizes: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
        return [];
      }
    } else {
      categoryRes.value = CategoriesRs.fromJson(cacheData!);
      if (categoryPage == 1) {
        categoryList.value = categoryRes.value!.data ?? [];
      } else {
        List<CategoryModel> tempCategory = categoryList.value;
        tempCategory.addAll(categoryRes.value!.data ?? []);
        categoryList.value = [];
        categoryList.value = tempCategory;
      }
      return categoryList.value;
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final authController = Get.put(AuthenticationController());
    final url =
        "$ALL_CATEGORIES?brand_slug=${authController.userModel.value!.companySlug}&limit=-1";
    printLog("getAllCategories $url");
    Map<String, dynamic>? cacheData =
        await DataCacheService(apiEndPoint: url).getData();
    printLog("getAllCategories ${cacheData}");
    if (cacheData == null) {
      try {
        final DIO.Response response = await dio.get(url);
        if (response.statusCode == 200) {
          Map<String, dynamic> serverJSON = response.data;
          log("allCategoryList: ${response.requestOptions.baseUrl}${response.requestOptions.path}");
          log("allCategoryList: ${response.data}");
          DataCacheService(apiEndPoint: url).setData(serverJSON);
          CategoriesRs categoryResNew = CategoriesRs.fromJson(serverJSON);
          allCategoryList.value = categoryResNew.data ?? [];
          log("categoryList : ${allCategoryList.value.length}");
          return allCategoryList.value;
        }
        return [];
      } on DIO.DioException catch (e) {
        log("Error Categorizes: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
        return [];
      }
    } else {
      CategoriesRs categoryResNew = CategoriesRs.fromJson(cacheData!);
      allCategoryList.value = categoryResNew.data ?? [];
      log("allCategoryList : ${allCategoryList.value.length}");
      return allCategoryList.value;
    }
  }

  ///get all brand
  Future<List<BrandModel>> getAllBrands() async {
    final authController = Get.put(AuthenticationController());

    printLog("getAllBrands");
    String url =
        "$ALL_BRANDS?brand_slug=${authController.userModel.value!.companySlug}&limit=15&page=$brandPage";
    Map<String, dynamic>? cacheData =
        await DataCacheService(apiEndPoint: url).getData();
    printLog("getAllBrands : $url");
    if (cacheData == null) {
      try {
        final DIO.Response response = await dio.get(url);
        if (response.statusCode == 200) {
          Map<String, dynamic> serverJSON = response.data;
          DataCacheService(apiEndPoint: url).setData(serverJSON);
          brandRes.value = BrandRes.fromJson(serverJSON);
          if (brandPage == 1) {
            brandList.value = brandRes.value!.data ?? [];
          } else {
            List<BrandModel> tempBrand = brandList.value;
            tempBrand.addAll(brandRes.value!.data ?? []);
            brandList.value = [];
            brandList.value = tempBrand;
          }
          return brandList.value;
        }
        return [];
      } on DIO.DioException catch (e) {
        log("Error Brand: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
        log("Error Brand: ${e.requestOptions.headers.toString()}");
        return [];
      }
    } else {
      brandRes.value = BrandRes.fromJson(cacheData);
      if (brandPage == 1) {
        brandList.value = brandRes.value!.data ?? [];
      } else {
        List<BrandModel> tempBrand = brandList.value;
        tempBrand.addAll(brandRes.value!.data ?? []);
        brandList.value = [];
        brandList.value = tempBrand;
      }
      return brandList.value;
    }
  }

  ///get categoryByProduct
  Future<ProductSearchRes?> getProductByCategory(
      String categoryName, int page, {bool refresh = false}) async {
    String url = "$ALL_PRODUCT?limit=10&page=$page&category_name=$categoryName"
        .replaceAll(" ", "%20");
    printLog(
        "getProductByCategory: $categoryName --Index: $page : url; ${url}");
    Map<String, dynamic>? cacheData =
        await DataCacheService(apiEndPoint: url).getData();
    if (cacheData == null || refresh) {
      try {
        final DIO.Response response = await dio.get(url);
        Map<String, dynamic> serverJSON = response.data;
        DataCacheService(apiEndPoint: url).setData(serverJSON);
        log("getProductByCategory: $serverJSON");
        return ProductSearchRes.fromJson(serverJSON);
      } on DIO.DioException catch (e) {
        log("Error Brand: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
        log("Error Brand: ${e.requestOptions.headers.toString()}");
        return null;
      }
    } else {
      return ProductSearchRes.fromJson(cacheData);
    }
  }

  ///get categoryByProduct
  Future<ProductSearchRes?> getProductByBrandCategory(
      String categoryName, String brandName, int page) async {
    String url =
        "$ALL_PRODUCT?limit=10&page=$page&brand_slug=$brandName&category_name=$categoryName"
            .replaceAll(" ", "%20");
    printLog("getProductByCategory: $categoryName --Index: $page url :$url");
    Map<String, dynamic>? cacheData =
        await DataCacheService(apiEndPoint: url).getData();
    if (cacheData == null) {
      try {
        final DIO.Response response = await dio.get(url);
        Map<String, dynamic> serverJSON = response.data;
        log("getProductByCategory: $serverJSON");
        DataCacheService(apiEndPoint: url).setData(serverJSON);
        return ProductSearchRes.fromJson(serverJSON);
      } on DIO.DioException catch (e) {
        log("Error Brand: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
        log("Error Brand: ${e.requestOptions.headers.toString()}");
        return null;
      }
    } else {
      return ProductSearchRes.fromJson(cacheData);
    }
  }

  ///get category'sUBcTAEGORYByProduct
  Future<ProductSearchRes?> getProductByBrandCategorySubCategory(
      String categoryName,
      String brandName,
      String subcategoryName,
      int page) async {
    String url =
        ("$BASE_URL$ALL_PRODUCT?limit=10&page=$page&brand_slug=$brandName&category_name=$categoryName&sub_category_name=$subcategoryName")
            .replaceAll(" ", "%20");
    printLog(
        "getProductByBrandCategorySubCategory: $categoryName --Index: $page url : $url");
    Map<String, dynamic>? cacheData =
        await DataCacheService(apiEndPoint: url).getData();
    if (cacheData == null) {
      try {
        final DIO.Response response = await dio.get(url);
        log("getProductByBrandCategorySubCategory: ${response.requestOptions.baseUrl}${response.requestOptions.path}");
        Map<String, dynamic> serverJSON = response.data;
        log("getProductByCategory: $serverJSON");
        DataCacheService(apiEndPoint: url).setData(serverJSON);
        return ProductSearchRes.fromJson(serverJSON);
      } on DIO.DioException catch (e) {
        log("Error Brand: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
        log("Error Brand: ${e.requestOptions.headers.toString()}");
        return null;
      }
    } else {
      return ProductSearchRes.fromJson(cacheData);
    }
  }

  ///get categoryByProduct
  Future<ProductSearchRes?> getProductByBrand(
      String brandName, int page) async {
    String url = "$ALL_PRODUCT?limit=10&page=$page&brand_slug=$brandName"
        .replaceAll(" ", "%20");
    printLog("getProductByCategory: $brandName --Index: $page");
    Map<String, dynamic>? cacheData =
        await DataCacheService(apiEndPoint: url).getData();
    if (cacheData == null) {
      try {
        final DIO.Response response = await dio.get(url);
        Map<String, dynamic> serverJSON = response.data;
        log("getProductByCategory: $serverJSON");
        DataCacheService(apiEndPoint: url).setData(serverJSON);
        return ProductSearchRes.fromJson(serverJSON);
      } on DIO.DioException catch (e) {
        log("Error Brand: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
        log("Error Brand: ${e.requestOptions.headers.toString()}");
        return null;
      }
    } else {
      return ProductSearchRes.fromJson(cacheData);
    }
  }

  ///get  categories brand
  Future<List<CategoryModel>> getCategoriesByBrand(String brandName) async {
    printLog("getCategoriesByBrand");
    String url =
        "$ALL_CATEGORIES?limit=-1&brand_name=$brandName".replaceAll(" ", "%20");
    Map<String, dynamic>? cacheData =
        await DataCacheService(apiEndPoint: url).getData();
    if (cacheData == null) {
      try {
        final DIO.Response response = await dio.get(url);
        if (response.statusCode == 200) {
          Map<String, dynamic> serverJSON = response.data;
          DataCacheService(apiEndPoint: url).setData(serverJSON);
          BrandCategoriesRes brandCategoriesRes =
              BrandCategoriesRes.fromJson(serverJSON);
          return brandCategoriesRes.data ?? [];
        }
        return [];
      } on DIO.DioException catch (e) {
        log("Error getCategoriesByBrand: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
        return [];
      }
    } else {
      BrandCategoriesRes brandCategoriesRes =
          BrandCategoriesRes.fromJson(cacheData);
      return brandCategoriesRes.data ?? [];
    }
  }
}
