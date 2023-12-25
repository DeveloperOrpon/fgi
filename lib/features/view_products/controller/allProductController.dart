import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:fgi_y2j/Api/Interceptors/OfflineInterceptor.dart';
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/BrandRes.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/CategoryRes.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/shopping_cart/model/CartRes.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart' as DIO;

import '../../../Api/Interceptors/ConnectivityRequestRetrier.dart';
import '../../../Api/Interceptors/RetryOnConnectionChangeIntercptor.dart';
import '../../../Api/api_route.dart';
import '../../Category_Brand/Model/CategoryByProductRes.dart';

class AllProductController extends GetxController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RefreshController refreshSearchController =
      RefreshController(initialRefresh: false);
  RxBool isLoadingAllProduct = RxBool(false);
  RxBool isListAllProduct = RxBool(true);
  Rxn<ProductRes> productRes = Rxn<ProductRes>();
  RxList<ProductModel> allProduct = RxList<ProductModel>([]);

  Rxn<BrandModel> selectBrand = Rxn<BrandModel>();
  Rxn<CategoryModel> selectCategory = Rxn<CategoryModel>();
  Rxn<SubCategories> selectSubCategory = Rxn<SubCategories>();

  void onRefreshPage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoadingPage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

  late DIO.Dio dio;

  @override
  onInit() async {
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
    getAllProduct();
  }

  ///get All Product
  int allProductPage = 1;
  getAllProduct() async {
    final authController = Get.put(AuthenticationController());
    final url =
        "$ALL_PRODUCT?brand_slug=${authController.userModel.value!.companySlug}&limit=10&page=$allProductPage";
    final cache=await DataCacheService(apiEndPoint: url).getData();
    if(cache==null) {
      try {
      final DIO.Response response = await dio.get(url);
      printLog("Message: ${dio.options.baseUrl}$url");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        productRes.value = ProductRes.fromJson(jsonData);
        ///setDataInLocalDataBase
        DataCacheService(apiEndPoint: url).setData(jsonData);
        if (allProductPage == 1) {
          allProduct.value = productRes.value!.data ?? [];
        } else {
          List<ProductModel> tempProductList = allProduct.value;
          tempProductList.addAll(productRes.value!.data ?? []);
          allProduct.value = [];
          allProduct.value = tempProductList;
        }
        printLog("$jsonData");
      }
      return;
    } on DIO.DioException catch (e) {
      printLog("Error : ${e.toString()}");
      return;
    }
    }else{
      log("Have Already In LocalDataDB (getAllProduct)");
      productRes.value = ProductRes.fromJson(cache);
      if (allProductPage == 1) {
        allProduct.value = productRes.value!.data ?? [];
      } else {
        List<ProductModel> tempProductList = allProduct.value;
        tempProductList.addAll(productRes.value!.data ?? []);
        allProduct.value = [];
        allProduct.value = tempProductList;
      }
    }
  }

  ///add to cart Product
  Future<bool> addToCartProduct(ProductModel productModel,
      {double quantity = 1}) async {
    final authenticationController = Get.put(AuthenticationController());
    final cartController = Get.put(CartController());
    cartController.startIncrease.value=true;
    CartModel cartModel = CartModel(
      createdAt: DateTime.now().toString(),
      price: productModel.price,
      productId: productModel.pId,
      productImage: productModel.productImage ?? "",
      productName: productModel.name,
      quantity: 1,
      sId: '',
      updatedAt: DateTime.now().toString(),
    );
    var check = cartController.cartItems.value.firstWhereOrNull(
        (element) => element.productId == cartModel.productId);
    List<CartModel> remainCart = cartController.cartItems.value;
    if (check == null) {
      remainCart.add(cartModel);
    }
    cartController.cartItems.value = remainCart;
    cartController.cartItems.value = remainCart;
    try {
      Map<String, dynamic> cartProductMap = {
        "product_id": productModel.pId,
        // "user_email":authenticationController.userModel.value?.email,
        // "product_name": productModel.name,
        "quantity": quantity,
        "product_unit_type":cartModel.productUnitType,
        "product_unit":cartModel.productUnit,
        "product_unit_value":cartModel.productUnitValue,
        // "price": productModel.price,
        // "product_image":productModel.productImage??""
      };
      final DIO.Response response =
          await dio.post(ADD_TO_CART, data: cartProductMap);
      printLog("Message: ${dio.options.baseUrl}");
      cartController
          .getAllCartProduct(authenticationController.userModel.value!);
      cartController.startIncrease.value=false;
      return true;
    } on DIO.DioException catch (e) {
      printLog("Error : ${e.toString()}");
      return false;
    }
  }

  ///SEARCH PRODUCT
  Future<ProductSearchRes?> searchProduct(String key, int page) async {
    final authController = Get.put(AuthenticationController());
    final url =
        "$ALL_PRODUCT?brand_slug=${authController.userModel.value!.companySlug}&limit=10&page=$page&search=$key";
    printLog("getProductByCategory: $key --Index: $page");
    final cache=await DataCacheService(apiEndPoint: url).getData();
    if(cache==null) {
      try {
      final DIO.Response response = await dio.get(url);
      log("Search Url: ${response.requestOptions.baseUrl}${response.requestOptions.path}");
      Map<String, dynamic> serverJSON = response.data;
      DataCacheService(apiEndPoint: url).setData(serverJSON);
      log("searchProduct: $serverJSON");
      return ProductSearchRes.fromJson(serverJSON);
    } on DIO.DioException catch (e) {
      log("Error Brand: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      log("Error Brand: ${e.requestOptions.headers.toString()}");
      return null;
    }
    }else{
      log("Have Already In LocalDataDB (Search)");
      return ProductSearchRes.fromJson(cache);
    }
  }

  int tag = 3;
  RxList<Map<String, dynamic>> filters = RxList<Map<String, dynamic>>([]);
  RxList<ProductModel> filterProducts = RxList<ProductModel>([]);
  Rxn<ProductSearchRes> filterProductSearchRes = Rxn<ProductSearchRes>();

  getProductByBrandCategorySubCategory(int page) async {
    final authController = Get.put(AuthenticationController());
    List<Map<String, dynamic>> tempFilter = [];
    if (selectBrand.value != null) {
      tempFilter
          .add({"name": "brand", "value": selectBrand.value!.brandLabel ?? ""});
    }
    if (selectSubCategory.value != null) {
      tempFilter.add({
        "name": "subCat",
        "value": selectSubCategory.value!.subcategoryName ?? ""
      });
    }
    if (selectCategory.value != null) {
      tempFilter.add(
          {"name": "cat", "value": selectCategory.value!.categoryLabel ?? ""});
    }
    filters.value = tempFilter;
    String url =
        "$ALL_PRODUCT?limit=10&page=$page${selectBrand.value != null ? "&brand_slug=${selectBrand.value!.brandSlug}" : "&brand_slug=${authController.userModel.value!.companySlug}"}${selectCategory.value != null ? "&category_name=${selectCategory.value!.categoryLabel}" : ""}${selectCategory.value != null ? "&sub_category_name=${selectSubCategory.value!.subcategoryName}" : ""}";
    log("Select User : $url");
    final cache=await DataCacheService(apiEndPoint: url).getData();
    if(cache==null) {
      try {
      final DIO.Response response = await dio.get(url);
      Map<String, dynamic> serverJSON = response.data;
      log("getProductByCategory: $serverJSON");
      filterProductSearchRes.value = ProductSearchRes.fromJson(serverJSON);
      DataCacheService(apiEndPoint: url).setData(serverJSON);
      if (page == 1 && filterProductSearchRes.value != null) {
        filterProducts.value = filterProductSearchRes.value!.data ?? [];
      } else {
        if (filterProductSearchRes.value != null) {
          final temp = filterProducts.value;
          temp.addAll(filterProductSearchRes.value!.data ?? []);
          filterProducts.value = temp;
        }
      }
    } on DIO.DioException catch (e) {
      log("Error Brand: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      log("Error Brand: ${e.requestOptions.headers.toString()}");
      return null;
    }
    }else{
      log("Have Already In LocalDataDB (getProductByBrandCategorySubCategory)");
      filterProductSearchRes.value = ProductSearchRes.fromJson(cache);
      if (page == 1 && filterProductSearchRes.value != null) {
        filterProducts.value = filterProductSearchRes.value!.data ?? [];
      } else {
        if (filterProductSearchRes.value != null) {
          final temp = filterProducts.value;
          temp.addAll(filterProductSearchRes.value!.data ?? []);
          filterProducts.value = temp;
        }
      }
    }
  }
}
