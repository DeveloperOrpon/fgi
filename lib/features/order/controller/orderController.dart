import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:developer';
import 'dart:async';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/dio.dart' as DIO;
import '../../../Api/Interceptors/ConnectivityRequestRetrier.dart';
import '../../../Api/Interceptors/RetryOnConnectionChangeIntercptor.dart';
import '../../../Api/api_route.dart';
import '../../../config/helper/helperFunction.dart';
import '../../shopping_cart/model/OrderRes.dart';

class OrderController extends GetxController {
  int pendingOrderPage = 1;
  int completedOrderPage = 1;

  ///History Page
  final RefreshController refreshHistoryController =
      RefreshController(initialRefresh: false);

  void onRefreshHistoryPage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshHistoryController.refreshCompleted();
  }

  void onLoadingHistoryPage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshHistoryController.loadComplete();
  }

  /// order pending
  final RefreshController refreshPendingController =
      RefreshController(initialRefresh: false);

  void onRefreshPendingPage() async {
    pendingOrderPage = 1;
    pendingOrderResponse.value = null;
    pendingOrderList.value = [];
    pendingOrderInformation(1);
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshPendingController.refreshCompleted();
  }

  void onLoadingPendingPage() async {
    pendingOrderPage++;
    pendingOrderInformation(pendingOrderPage);
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshPendingController.loadComplete();
  }
  /// order accept
  final RefreshController refreshAcceptController =
      RefreshController(initialRefresh: false);

  void onRefreshAcceptPage() async {
    acceptOrderPage = 1;
    acceptOrderResponse.value = null;
    acceptOrderList.value = [];
    pendingOrderInformation(1);
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshAcceptController.refreshCompleted();
  }

  void onLoadingAcceptPage() async {
    acceptOrderPage++;
    pendingOrderInformation(acceptOrderPage);
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshAcceptController.loadComplete();
  }

  /// order Complete
  final RefreshController refreshCompleteController =
      RefreshController(initialRefresh: false);

  void onRefreshCompletePage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshCompleteController.refreshCompleted();
  }

  void onLoadingCompletePage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshCompleteController.loadComplete();
  }

  /// order invoice
  final RefreshController refreshInvoiceController =
      RefreshController(initialRefresh: false);

  void onRefreshInvoicePage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshInvoiceController.refreshCompleted();
  }

  void onLoadingInvoicePage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshInvoiceController.loadComplete();
  }

  ScrollController cartHomeScrollController = ScrollController();
  RxString currentAddress = RxString('');
  final addressController = TextEditingController();
  final additionalController = TextEditingController();

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
      pendingOrderInformation(1);
    }
    if (authController.userModel.value != null) {
      completedOrderInformation(1);
      acceptOrderInformation(1);
      cancelOrderInformation(1);
    }
    getAllOrder();
  }

  //order pending
  Rxn<OrderResponse> pendingOrderResponse = Rxn<OrderResponse>();
  RxList<OrderResModel> pendingOrderList = RxList([]);

  pendingOrderInformation(int page) async {
    final authController = Get.put(AuthenticationController());
    try {
      final DIO.Response response = await dio.get(
          "$ORDER_CREATE/?order_status=0&limit=10&page=$page&search=${authController.userModel.value!.email ?? ""}");

      if (response.statusCode == 200) {
        printLog(
            "Message: ${dio.options.baseUrl}${response.requestOptions.path}");
        printLog("pendingOrderInformation: ${response.data}");
        Map<String, dynamic> jsonData = response.data;
        pendingOrderResponse.value = OrderResponse.fromJson(jsonData);
        if (page == 1) {
          pendingOrderList.value = pendingOrderResponse.value!.data ?? [];
        } else {
          List<OrderResModel> tempModel = pendingOrderList.value;
          tempModel.addAll(pendingOrderResponse.value!.data ?? []);
          pendingOrderList.value = [];
          pendingOrderList.value = tempModel;
        }
        EasyLoading.dismiss();
      }
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      printLog("Error : ${e.toString()}");
      printLog("Error : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return;
    }
  }

  ///order complete
  Rxn<OrderResponse> completedOrderResponse = Rxn<OrderResponse>();
  RxList<OrderResModel> completedOrderList = RxList([]);

  completedOrderInformation(int page) async {
    final authController = Get.put(AuthenticationController());
    try {
      final DIO.Response response = await dio.get(
          "$ORDER_CREATE/?order_status=3&limit=10&page=$page&search=${authController.userModel.value!.email ?? ""}");
      printLog("Message: ${dio.options.baseUrl}");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        completedOrderResponse.value = OrderResponse.fromJson(jsonData);
        if (page == 1) {
          completedOrderList.value = completedOrderResponse.value!.data ?? [];
        } else {
          List<OrderResModel> tempModel = completedOrderList.value;
          tempModel.addAll(completedOrderResponse.value!.data ?? []);
          completedOrderList.value = tempModel;
        }
        EasyLoading.dismiss();
      }
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      printLog("Error : ${e.toString()}");
      printLog("Error : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return;
    }
  }

  ///order complete
  Rxn<OrderResponse> acceptOrderResponse = Rxn<OrderResponse>();
  RxList<OrderResModel> acceptOrderList = RxList([]);
 int acceptOrderPage = 1;
  acceptOrderInformation(int page) async {
    final authController = Get.put(AuthenticationController());
    try {
      final DIO.Response response = await dio.get(
          "$ORDER_CREATE/?order_status=1&limit=10&page=$page&search=${authController.userModel.value!.email ?? ""}");
      printLog("Message: ${dio.options.baseUrl}");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        acceptOrderResponse.value = OrderResponse.fromJson(jsonData);
        if (page == 1) {
          acceptOrderList.value = acceptOrderResponse.value!.data ?? [];
        } else {
          List<OrderResModel> tempModel = acceptOrderList.value;
          tempModel.addAll(acceptOrderResponse.value!.data ?? []);
          acceptOrderList.value = tempModel;
        }
        EasyLoading.dismiss();
      }
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      printLog("Error : ${e.toString()}");
      printLog("Error : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return;
    }
  }

  ///order cancel
  final RefreshController refreshCancelController =
  RefreshController(initialRefresh: false);

  void onRefreshCancelPage() async {
    cancelOrderPage = 1;
    cancelOrderResponse.value = null;
    cancelOrderList.value = [];
    cancelOrderInformation(1);
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshCancelController.refreshCompleted();
  }

  void onLoadingCancelPage() async {
    cancelOrderPage++;
    cancelOrderInformation(cancelOrderPage);
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshCancelController.loadComplete();
  }
  Rxn<OrderResponse> cancelOrderResponse = Rxn<OrderResponse>();
  RxList<OrderResModel> cancelOrderList = RxList([]);
 int cancelOrderPage = 1;
  cancelOrderInformation(int page) async {
    final authController = Get.put(AuthenticationController());
    try {
      final DIO.Response response = await dio.get(
          "$ORDER_CREATE/?order_status=2&limit=10&page=$page&search=${authController.userModel.value!.email ?? ""}");
      printLog("Message: ${dio.options.baseUrl}");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        cancelOrderResponse.value = OrderResponse.fromJson(jsonData);
        if (page == 1) {
          cancelOrderList.value = cancelOrderResponse.value!.data ?? [];
        } else {
          List<OrderResModel> tempModel = cancelOrderList.value;
          tempModel.addAll(cancelOrderResponse.value!.data ?? []);
          cancelOrderList.value = tempModel;
        }
        EasyLoading.dismiss();
      }
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      printLog("Error : ${e.toString()}");
      printLog("Error : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return;
    }
  }

  Rxn<OrderResponse> allOrderResponse = Rxn<OrderResponse>();
  RxList<OrderResModel> allOrderList = RxList([]);
  getAllOrder() async {
    final authController = Get.put(AuthenticationController());
    try {
      final DIO.Response response = await dio.get(
          "$ORDER_CREATE?limit=-1&search=${authController.userModel.value!.email ?? ""}");
      printLog("getAllOrder: ${dio.options.baseUrl}${response.requestOptions.path}");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;

        allOrderResponse.value = OrderResponse.fromJson(jsonData);
        allOrderList.value=allOrderResponse.value!.data??[];
        printLog("getAllOrder: ${allOrderList.value.length}");

        EasyLoading.dismiss();
      }
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      printLog("Error : ${e.toString()}");
      printLog("Error : ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      return;
    }
  }
}
