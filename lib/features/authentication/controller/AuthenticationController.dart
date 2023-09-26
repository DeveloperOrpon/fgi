
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/authentication/model/UserRes.dart';
import 'package:fgi_y2j/features/cache_stroage/localStroage.dart';
import 'package:fgi_y2j/redirectScreeen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as DIO;
import '../../../Api/Interceptors/ConnectivityRequestRetrier.dart';
import '../../../Api/Interceptors/RetryOnConnectionChangeIntercptor.dart';
import '../../../Api/api_route.dart';
import '../../../constants/data/citiesRes.dart';
import '../../../constants/data/divisionJson.dart';

class AuthenticationController extends GetxController {
  Rxn<Divisions>selectDivision = Rxn<Divisions>();
  Rxn<Districts> selectDistrict = Rxn<Districts>();
  RxBool isShowCompany = RxBool(false);
  RxInt timelineIndex = RxInt(0);
  DivisionsRes divisionsRes = DivisionsRes.fromJson(division);
  DistrictRes districtRes = DistrictRes.fromJson(districts);
  late DIO.Dio dio;
  Rxn<UserRes> userRes=Rxn<UserRes>();
  Rxn<UserModel> userModel=Rxn<UserModel>();

  ///controller login
  final emailController=TextEditingController();
  final passwordController=TextEditingController();

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
  }
  ///login
  loginWithEmailPassword(String email, String password) async {
    startLoading("Please Wait...");
    printLog("email :$email password -$password");

    final userInformation ={
      "email":"developerorpon@gmail.com",
      "password":"123456789"
    };
    try {
      final DIO.Response response = await dio.post(USER_LOGIN,data: userInformation);
      if (response.statusCode == 200) {
        Map<String, dynamic> messageRes = response.data;
        log("messageRes :$messageRes");


        UserRes userResTemp=UserRes.fromJson(messageRes);
        ///runtime save
        userRes.value=userResTemp;
        userModel.value=userResTemp.data;
        ///save Local Database
        LocalStorage.savedJWT(userResTemp.jwt??"");
        String jsonString =
        json.encode(userModel.value?.toJson());
        LocalStorage.savedUserInformation(jsonString);

        Get.offAll(const RedirectScreen(),transition: Transition.fadeIn);
      }
      EasyLoading.dismiss();
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      log(e.requestOptions.baseUrl+e.requestOptions.path);
      log(e.requestOptions.data);
    }
  }
  ///LOGOUT
logout(){
    startLoading("Logout..");
  LocalStorage.savedJWT("");
  LocalStorage.savedUserInformation('');
  userModel.value=null;
  userRes.value=null;
  EasyLoading.dismiss();
  Get.offAll(const RedirectScreen(),transition: Transition.fadeIn);
}
}
