import 'dart:convert';
import 'dart:developer';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/authentication/model/UserRes.dart';
import 'package:fgi_y2j/features/authentication/screen/loginScreen.dart';
import 'package:fgi_y2j/features/cache_stroage/localStroage.dart';
import 'package:fgi_y2j/redirectScreeen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../Api/Interceptors/ConnectivityRequestRetrier.dart';
import '../../../Api/Interceptors/RetryOnConnectionChangeIntercptor.dart';
import '../../../Api/api_route.dart';
import '../../../constants/data/citiesRes.dart';
import '../../../constants/data/divisionJson.dart';

class AuthenticationController extends GetxController {
  Rxn<Divisions> selectDivision = Rxn<Divisions>();
  Rxn<Districts> selectDistrict = Rxn<Districts>();
  RxBool isShowCompany = RxBool(false);
  RxInt timelineIndex = RxInt(0);
  RxInt selectCompany = RxInt(0);
  DivisionsRes divisionsRes = DivisionsRes.fromJson(division);
  DistrictRes districtRes = DistrictRes.fromJson(districts);
  late DIO.Dio dio;
  Rxn<UserRes> userRes = Rxn<UserRes>();
  Rxn<UserModel> userModel = Rxn<UserModel>();

  /// state
  Rx<ButtonState> loginButtonState = Rx(const ButtonState.idle());
  Rx<ButtonState> forgotButtonState = Rx(const ButtonState.idle());
  RxBool loginPasswordShow = RxBool(false);

  ///signup
  RxnString selectSubscription = RxnString();
  RxnString selectPaymentType = RxnString();

  ///key
  final signInFromKey = GlobalKey<FormState>();
  final signupFromKey = GlobalKey<FormState>();
  final forgotFromKey = GlobalKey<FormState>();

  ///controller login
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passForgotController = TextEditingController();


  ///forgot password
  final forgotPassFromKey = GlobalKey<FormState>();
  final forgotEmailController = TextEditingController();
  final passForgotVerifyController = TextEditingController();
  RxBool forgotPasswordInput = RxBool(false);
  RxBool forgotPasswordVerifyInput = RxBool(false);


  ///signup controller
  final cartNumberController = TextEditingController();
  final zipCodeController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailSignUpController = TextEditingController();
  final passwordSignUpController = TextEditingController();
  final retypePasswordSignUpController = TextEditingController();
  final phoneSignUpController = TextEditingController();

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

    ///init value
  }

  ///login
  Future<void> loginWithEmailPassword(
      String email, String password, BuildContext context) async {
    // startLoading("Please Wait...");
    printLog("email :$email password -$password");

    final userInformation = {"email": email, "password": password};
    try {
      final DIO.Response response =
          await dio.post(USER_LOGIN, data: userInformation);
      if (response.statusCode == 200) {
        Map<String, dynamic> messageRes = response.data;
        log("messageRes :$messageRes");

        UserRes userResTemp = UserRes.fromJson(messageRes);
        if (userResTemp.data!.isAccountActive!) {
          ///controller clear
          controllerClear();

          ///runtime save
          userRes.value = userResTemp;
          userModel.value = userResTemp.data;

          ///save Local Database
          LocalStorage.savedJWT(userResTemp.jwt ?? "");
          String jsonString = json.encode(userModel.value?.toJson());
          LocalStorage.savedUserInformation(jsonString);
          EasyLoading.dismiss();
          if (context.mounted) {
            showSuccessDialog(
                'Information',
                "Login Successfully.Welcome Back ${"${userResTemp.data!.firstName!} ${userResTemp.data!.lastName!}"}",
                context);
          }

          loginButtonState.value = const ButtonState.success();
          Future.delayed(
            const Duration(seconds: 1),
            () {
              Get.offAll(const RedirectScreen(), transition: Transition.fadeIn);
            },
          );
        } else {
          EasyLoading.dismiss();
          if (context.mounted) {
            showErrorDialog(
                "Waring",
                "Your Account Is Not Active. Please Contact With Admin",
                context);
          }
          loginButtonState.value = const ButtonState.success();
        }
      }

      EasyLoading.dismiss();
      return;
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      log(e.requestOptions.baseUrl + e.requestOptions.path);
      log(e.requestOptions.data);
      loginButtonState.value = const ButtonState.error('');
      return;
    }
  }

  ///SIGNUP USER
  signUpUser(BuildContext context) async {
    String cartNumber= cartNumberController.text;
    String zipCode= zipCodeController.text;
    String firstname= firstNameController.text;
    String lastname= lastNameController.text;
    String email= emailSignUpController.text;
    String password= passwordSignUpController.text;
    String phoneNumber= phoneSignUpController.text;
    if(cartNumber.isEmpty ||zipCode.isEmpty||firstname.isEmpty||lastname.isEmpty||email.isEmpty||password.isEmpty||phoneNumber.isEmpty){
      showErrorDialogInTop("Warning", "Please Provide All The Input Information", context);
      return;
    }
    ///selectSubscription.value==null|| selectPaymentType.value==null||
    if(selectDistrict.value==null|| selectDivision.value==null){
      showErrorDialogInTop("Warning", "Please Provide All The Selection Information", context);
      return;
    }
    startLoading("Please Wait");
    final userInformation = {
      "cartNumber": cartNumber,
      "company": "Example Cmpany",
      "email":email,
      "location": "${selectDivision.value!.name??''},${selectDistrict.value!.name??''}",
      "zipCode": zipCode,
      "firstName": firstname,
      "lastName": lastname,
      "subscription": "Gold",
      "paymentMethod": "Credit Card",
      "cardNumber": "**** **** **** 1234",
      "password": password
    };

    printLog("${userInformation.toString()}");

    try {
      final DIO.Response response =
          await dio.post(USER_CREATE, data: userInformation);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Map<String, dynamic> messageRes = response.data;
        log("messageRes :$messageRes");
        if(context.mounted) {
          showSuccessDialog("Information", "Account Create Successfully", context);
        }
          controllerClear();
       Future.delayed(Duration(seconds: 1),() {
         Get.off(const LoginScreen(),transition: Transition.fadeIn);
         timelineIndex.value=0;
       },);
      }

      EasyLoading.dismiss();
      return;
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      log(e.requestOptions.baseUrl + e.requestOptions.path);
      log(e.requestOptions.data);

      return;
    }
  }

  ///LOGOUT
  logout() {
    startLoading("Logout..");
    LocalStorage.savedJWT("");
    LocalStorage.savedUserInformation('');
    userModel.value = null;
    userRes.value = null;
    EasyLoading.dismiss();
    Get.offAll(const RedirectScreen(), transition: Transition.fadeIn);
  }

  ///controller clear
  controllerClear() {
    emailController.text = '';
    passwordController.text = '';
   cartNumberController.text='';
    zipCodeController.text='';
   firstNameController.text='';
    lastNameController.text='';
   emailSignUpController.text='';
    passwordSignUpController.text='';
    phoneSignUpController.text='';
  }
}
