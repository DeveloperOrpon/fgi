import 'dart:developer';

import 'package:animate_icons/animate_icons.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/BrandRes.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Api/Interceptors/ConnectivityRequestRetrier.dart';
import '../../../Api/Interceptors/RetryOnConnectionChangeIntercptor.dart';
import '../../../Api/api_route.dart';
import '../Model/CategoryRes.dart';

class CategoryController extends GetxController{
  final bottomBarController = BottomBarWithSheetController(initialIndex: 0);
  final productScrollController = ScrollController();
 final animation= AnimateIconController();
  RxBool isDrawerOpen=RxBool(false);
  RxBool isListAllProduct=RxBool(false);
  Rxn< CategoriesRs> categoryRes=Rxn<CategoriesRs>();
  RxList<CategoryModel> categoryList=RxList<CategoryModel>([]);
  Rxn<BrandRes> brandRes=Rxn<BrandRes>();
  RxList<BrandModel> brandList=RxList<BrandModel>([]);
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final RefreshController allCategoryRefreshController = RefreshController(initialRefresh: false);
  final RefreshController allBrandsRefreshController = RefreshController(initialRefresh: false);
  late DIO.Dio dio;

  ///error message

  @override
  void onInit() {
    bottomBarController.stream.listen((opened) {
       isDrawerOpen.value=opened;
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
    getAllCategories();
    getAllBrands();
  }
  ///function
  void onRefreshPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoadingPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }
  ///all category refresh
  void onAllCategoryRefreshPage() async{
    categoryRes.value=null;
    categoryList.value=[];
    await getAllCategories();
    allCategoryRefreshController.refreshCompleted();
  }

  void onAllCategoryLoadingPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    allCategoryRefreshController.loadComplete();
  }
  ///all brand refresh
  void onAllBrandRefreshPage() async{
    brandRes.value=null;
    brandList.value=[];
    await getAllBrands();
    allBrandsRefreshController.refreshCompleted();
  }

  void onAllBrandLoadingPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    allBrandsRefreshController.loadComplete();
  }

  ///get all categories
Future<List<CategoryModel>> getAllCategories() async {
    printLog("getAllCategories");
  try {
    final DIO.Response response =
        await dio.get(ALL_CATEGORIES);
    if (response.statusCode == 200) {
      Map<String, dynamic> serverJSON = response.data;
      categoryRes.value= CategoriesRs.fromJson(serverJSON);
      if(categoryRes.value!=null) {
        categoryList.value=categoryRes.value!.data??[];
      }
      return categoryList.value;
    }
    return [];
  } on DIO.DioException catch (e) {
    log("Error Categorizes: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
    return [];
  }
}
  ///get all categories
Future<List<BrandModel>> getAllBrands() async {
    printLog("getAllBrands");
  try {
    final DIO.Response response =
        await dio.get(ALL_BRANDS);
    if (response.statusCode == 200) {
      Map<String, dynamic> serverJSON = response.data;
      brandRes.value= BrandRes.fromJson(serverJSON);
      if(brandRes.value!=null) {
        brandList.value=brandRes.value!.data??[];
      }
      return brandList.value;
    }
    return [];
  } on DIO.DioException catch (e) {
    log("Error Brand: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
    log("Error Brand: ${e.requestOptions.headers.toString()}");
    return [];
  }
}
}