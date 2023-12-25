import 'dart:developer';
import 'dart:async';
import 'dart:developer';
import 'package:fgi_y2j/Api/notification/fcm.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/shopping_cart/screen/OrderConfirmScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as Geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/authentication/model/UserRes.dart';
import 'package:fgi_y2j/features/dashboard/Component/dashboardHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart' as DIO;

import '../../../Api/Interceptors/ConnectivityRequestRetrier.dart';
import '../../../Api/Interceptors/RetryOnConnectionChangeIntercptor.dart';
import '../../../Api/api_route.dart';
import '../../../config/helper/helperFunction.dart';
import '../model/CartRes.dart';
import '../model/OrderRes.dart';

class CartController extends GetxController {
  ScrollController cartHomeScrollController = ScrollController();
  RxString currentAddress = RxString('');
  final addressController = TextEditingController();
  final additionalController = TextEditingController();
  RxBool startIncrease = RxBool(false);

  /// order Complete
  late DIO.Dio dio;

  @override
  onInit() {
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
    final authController = Get.put(AuthenticationController());
    if (authController.userModel.value != null) {
      getAllCartProduct(authController.userModel.value!);
    }
    getCurrentLocation();
  }

  final RefreshController refreshCartController =
      RefreshController(initialRefresh: false);

  void onRefreshCartPage() async {
    final authController = Get.put(AuthenticationController());
    if (authController.userModel.value != null) {
      cartRes.value = null;
      cartItems.value = [];
      getAllCartProduct(authController.userModel.value!);
    }

    refreshCartController.refreshCompleted();
  }

  void onLoadingCartPage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshCartController.loadComplete();
  }

  Rxn<CartRes> cartRes = Rxn<CartRes>();
  RxList<CartModel> cartItems = RxList<CartModel>([]);

  Future<void> getAllCartProduct(UserModel userModel) async {
    try {
      final DIO.Response response =
          await dio.get("$CART_ITEMS/${userModel.email}");
      printLog("Message: ${dio.options.baseUrl}${response.requestOptions.path}");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        printLog("JsonCart: ${jsonData}");
        cartRes.value = CartRes.fromJson(jsonData);
        printLog("cartRes.value: ${cartRes.value!.toJson()}");
        cartItems.value = cartRes.value!.items ?? [];
        EasyLoading.dismiss();
      }
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      cartRes.value=CartRes(items: [],total: 0,);
      printLog("Error : ${e.toString()}");
      printLog("Error : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return;
    }
  }

  removeProductFromCart(CartModel cartModel) async {
    // startLoading('');
    List<CartModel> remainCart =
        cartItems.value.where((element) => element != cartModel).toList();
    cartItems.value = remainCart;
    final authController = Get.put(AuthenticationController());
    if (authController.userModel.value == null) {
      EasyLoading.dismiss();
      return;
    }
    try {
      Map<String, dynamic> deleteMap = {
        "user_email": authController.userModel.value!.email!,
        "product_id": cartModel.productId
      };
      final DIO.Response response =
          await dio.delete(CART_REMOVE, data: deleteMap);
      printLog("deleteMap: ${dio.options.baseUrl}${response.requestOptions.path}");
      printLog("deleteMap: ${deleteMap}");
      printLog("deleteMap: ${response.data}");

      if (response.statusCode == 200) {
        getAllCartProduct(authController.userModel.value!);
        EasyLoading.dismiss();
      }
      EasyLoading.dismiss();
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();

      printLog("deleteMap : ${e.toString()}");
      printLog("deleteMap : ${e.requestOptions.data}");
      printLog("deleteMap : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return;
    }
  }

  ///cartProductCountChange
 Future<void> cartProductCountChange(CartModel cartModel, num quantity) async {
    final authController = Get.put(AuthenticationController());
    if (authController.userModel.value == null) {
      EasyLoading.dismiss();
      return;
    }
    try {
      Map<String, dynamic> updateCartInfo = {
        "user_email": authController.userModel.value!.email!,
        "product_id": cartModel.productId,
        "quantity": quantity
      };
      log("UpdateCartItemsData: $updateCartInfo");
      final DIO.Response response =
          await dio.patch(CART_UPDATE, data: updateCartInfo);
      printLog("Message: ${dio.options.baseUrl}");

      if (response.statusCode == 200) {
        getAllCartProduct(authController.userModel.value!);
      }
      EasyLoading.dismiss();
      return;
    } on DIO.DioException catch (e) {
      printLog("Error : ${e.toString()}");
      printLog("Error : ${e.requestOptions.data}");
      printLog("Error : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return;
    }
  }

  RxDouble totalProductPrice = RxDouble(0.00);
  RxInt selectedProductCount = RxInt(0);

  getTotalProductPrice() {
    double temp = 0.00;
    selectedProductCount.value = 0;
    totalProductPrice.value = 0;
    for (CartModel cartModel in cartItems.value) {
      if (cartModel.isCheck) {
        temp += cartModel.price! * (cartModel.quantity)!.toDouble();
        selectedProductCount.value++;
      }
    }
    totalProductPrice.value = temp;
  }

  ///Place Order Order
  Future<bool> placeAOrder(BuildContext context, String pickTime) async {
    final authController = Get.put(AuthenticationController());

    if (authController.userModel.value == null) {
      EasyLoading.dismiss();
      showSuccessToastTop('Information', "Something Error", context);
      return false;
    }
    try {
      Map<String, dynamic> updateCartInfo = {
        "user_email": authController.userModel.value!.email ?? "",
        "user_name":
            "${authController.userModel.value!.firstName ?? ""},${authController.userModel.value!.lastName ?? ""}",
        "user_address": addressController.text.trim(),
        "pickup_time": pickTime,
        "additional_information": additionalController.text,
        'default_address':currentAddress.value??""
      };
      List<Map<String, dynamic>> items = [];
      for (CartModel cartModel in cartItems.value) {
        if (cartModel.isCheck) {
          items.add({
            "product_name": cartModel.productName,
            "product_image": cartModel.productImage,
            "product_quantity": cartModel.quantity,
            "product_price": cartModel.afterDiscount??cartModel.price,
            "product_id": cartModel.productId,
            "product_unit_type":cartModel.productUnitType,
            "product_unit":cartModel.productUnit,
            "product_unit_value":cartModel.productUnitValue,
            "order_status": 0
          });

        }
      }
      removeHoleCartNoLoad(authController.userModel.value!.email ?? "");
      updateCartInfo.addAll({"items": items});
      log("placeAOrder: $updateCartInfo");
      log("Carditems: $items");
      final DIO.Response response =
          await dio.post(ORDER_CREATE, data: updateCartInfo);
      printLog("Message: ${dio.options.baseUrl}");
      printLog("Message: ${response.data}");
      if (response.statusCode == 200) {
        getAllCartProduct(authController.userModel.value!);
        Map<String,dynamic> map=response.data;
        EasyLoading.dismiss();
        OrderResModel orderResModel =OrderResModel.fromJson(map['order']);
        HapticFeedback.mediumImpact();
        createNotification(RemoteMessage(
          messageId: '1',
          senderId: '1',
          data: {
            'message':"Your order has been placed successfully",
            'title':"Order #${(orderResModel.sId??'1234567').substring(6)}",
            'image':"${orderResModel.items![0].productImage??''}"
          }
        ));
        Get.to(OrderConfirmScreen(orderResModel: orderResModel,),transition: Transition.fadeIn);
        return true;
      }
      EasyLoading.dismiss();
      return false;
    } on DIO.DioException catch (e) {
      printLog("Error : ${e.toString()}");
      printLog("Error : ${e.requestOptions.data}");
      printLog("Error : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return false;
    }
  }

  Future<bool> removeHoleCart(String email) async {
    try {
      final DIO.Response response = await dio.delete("/empty/cart/$email");
      printLog("Message: ${dio.options.baseUrl}");

      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        return true;
      }
      EasyLoading.dismiss();
      return false;
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();

      printLog("Error : ${e.toString()}");
      printLog("Error : ${e.requestOptions.data}");
      printLog("Error : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return false;
    }
  }
  Future<bool> removeHoleCartNoLoad(String email) async {
    try {
      final DIO.Response response = await dio.delete("empty/cart/$email");
      printLog("Message: ${dio.options.baseUrl}");

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      printLog("Error : ${e.toString()}");
      printLog("Error : ${e.requestOptions.data}");
      printLog("Error : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return false;
    }
  }

  getCurrentLocation() async {
    final authController=Get.put(AuthenticationController());
    currentAddress.value =authController.currentAddress.value;
    addressController.text = currentAddress.value ?? "";
  }
}
