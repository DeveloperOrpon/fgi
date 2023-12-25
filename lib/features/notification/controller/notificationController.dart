import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Api/Interceptors/ConnectivityRequestRetrier.dart';
import '../../../Api/Interceptors/RetryOnConnectionChangeIntercptor.dart';
import '../../../Api/api_route.dart';
import '../model/notificationRes.dart';
class AppNotificationController extends GetxController{
  final RefreshController refreshController =
  RefreshController(initialRefresh: false);
  late DIO.Dio dio;
  Rxn<NotificationRes> notificationRes=Rxn();
  int page=1;
  RxList<NotificationModel> notificationList=RxList([]);
  @override
  onInit()  {
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
    getNotification();
  }
  ///notification
getNotification() async {
    final auth=Get.put(AuthenticationController());
    if(auth.userModel.value!=null){
      try {
        final DIO.Response response =
        await dio.get(NOTIFICATION+"?email=${auth.userModel.value!.email??""}&notification=notification&page=$page");
        if (response.statusCode == 200) {
          Map<String, dynamic> json = response.data;
          // printLog("Notification Response : ${response.data}");
          notificationRes.value=NotificationRes.fromJson(json);
          if(page==1){
            notificationList.value=notificationRes.value!.notifications??[];
          }else{
            final temp=notificationList.value;
            temp.addAll(notificationRes.value!.notifications??[]);
            notificationList.value=temp;
          }
        }
        EasyLoading.dismiss();
        return true;
      } on DIO.DioException catch (e) {
        EasyLoading.dismiss();
        log(e.toString());
        log(e.requestOptions.baseUrl + e.requestOptions.path);
        log(e.requestOptions.data);
        return false;
      }
    }
}

int countUnRead(){
    List countList=notificationList.value.where((element) => element.read==null||!element.read!).toList();
    return countList.length;
}

  readMarkNotification(NotificationModel notificationModel) async {
  final auth=Get.put(AuthenticationController());
  if(auth.userModel.value!=null){
    try {
      final DIO.Response response =
          await dio.patch(NOTIFICATION+"/${notificationModel.sId}",data: {
            "read":true
          });
      log("UpDateNotification: ${response.data}");

      EasyLoading.dismiss();
      return true;
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      log(e.requestOptions.baseUrl + e.requestOptions.path);
      log(e.requestOptions.data);
      return false;
    }
  }
}
}