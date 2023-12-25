import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fgi_y2j/features/shopping_cart/controller/BookingController.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geocoding/geocoding.dart' as Geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/authentication/model/UserRes.dart';
import 'package:fgi_y2j/features/authentication/screen/loginScreen.dart';
import 'package:fgi_y2j/features/cache_stroage/localStroage.dart';
import 'package:fgi_y2j/redirectScreeen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api/Interceptors/ConnectivityRequestRetrier.dart';
import '../../../Api/Interceptors/OfflineInterceptor.dart';
import '../../../Api/Interceptors/RetryOnConnectionChangeIntercptor.dart';
import '../../../Api/api_route.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/data/citiesRes.dart';
import '../../../constants/data/divisionJson.dart';
import '../../Category_Brand/Model/BrandRes.dart';
import '../../shopping_cart/controller/cartController.dart';
import '../model/UserUpdateRes.dart';

class AuthenticationController extends GetxController {
  int showNoNetDialog=1;
  String FCM='';
  Rxn<Divisions> selectDivision = Rxn<Divisions>();
  Rxn<Districts> selectDistrict = Rxn<Districts>();
  RxBool isShowCompany = RxBool(false);
  RxBool isShowPassword = RxBool(false);
  RxBool isShowConfirmPassword = RxBool(false);
  RxInt timelineIndex = RxInt(0);
  Rxn<BrandModel> selectCompany = Rxn<BrandModel>();
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


   // Future.delayed(const Duration(seconds: 2),() async {
   //   if (brandList.isEmpty) {
   //     await getAllBrands();
   //   }
   //   await getCurrentLocation();
   // },);

    ///init value
  }

  ///login
  Future<void> loginWithEmailPassword(
      String email, String password, BuildContext context) async {
    // startLoading("Please Wait...");
    final authController=Get.put(AuthenticationController());
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
          Future.delayed(
            const Duration(seconds: 1),
            () {
              Get.offAll(const RedirectScreen(), transition: Transition.fadeIn);
            },
          );
          // Future.delayed(Duration(seconds: 4),() async {
          //   await userUpdate({
          //     "firebaseFCM":[authController.FCM]
          //   }, context);
          // },);
        } else {
          EasyLoading.dismiss();
          if (context.mounted) {
            showErrorDialog(
                "Waring",
                "Your Account Is Not Active. Please Contact With Admin",
                context);
          }
        }
      }

      EasyLoading.dismiss();
      loginButtonState.value = const ButtonState.success();
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
 Future<bool> signUpUser(BuildContext context) async {
    String cartNumber = cartNumberController.text;
    String zipCode = zipCodeController.text;
    String firstname = firstNameController.text;
    String lastname = lastNameController.text;
    String email = emailSignUpController.text;
    String password = passwordSignUpController.text;
    String phoneNumber = phoneSignUpController.text;
    String address = addressController.text;
    if (cartNumber.isEmpty ||
        zipCode.isEmpty ||
        address.isEmpty ||
        firstname.isEmpty ||
        lastname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        phoneNumber.isEmpty) {
      showErrorDialogInTop(
          "Warning", "Please Provide All The Input Information", context);
      return false;
    }

    ///selectSubscription.value==null|| selectPaymentType.value==null||
    // if (selectDistrict.value == null || selectDivision.value == null) {
    //   showErrorDialogInTop(
    //       "Warning", "Please Provide All The Selection Information", context);
    //   return;
    // }

    ///{
    //   "cartNumber": "1234567890",
    // 	"profilePicture":"www.google.com",
    //   "company": "Example Cmpany",
    // 	"email":"shahidabdulla.aas@gmail.com",
    //   "location": "Location City",
    //   "zipCode": "12345",
    //   "firstName": "John",
    //   "lastName": "Doe",
    //   "subscription": "Gold",
    //   "paymentMethod": "Credit Card",
    //   "cardNumber": "**** **** **** 1234",
    //   "password": "123"
    // }
    startLoading("Please Wait");
    final userInformation = {
      "profilePicture": "",
      "cartNumber": cartNumber.toString(),
      "company": selectCompany.value!.brandLabel ?? "",
      "email": email.toString(),
      "location": address,
      "zipCode": zipCode.toString(),
      "firstName": "$firstname",
      "lastName": "$lastname",
      "subscription": "Gold",
      "paymentMethod": "Credit Card",
      "cardNumber": "**** **** **** 1234",
      "password": "$password",
      "phoneNumber": "$phoneNumber",
      "company_slug": "${selectCompany.value!.brandSlug}",
    };

    printLog("${userInformation.toString()}");

    try {
      final DIO.Response response =
          await dio.post(USER_CREATE, data: userInformation);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Map<String, dynamic> messageRes = response.data;
        log("messageRes :$messageRes");
        controllerClear();
            Get.back();
            timelineIndex.value = 0;
        if (context.mounted) {
          showSuccessToastTop(
              "Information", "Account Create Successfully", context);
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

  ///LOGOUT
  logout() async {
    startLoading("Logout..");
    LocalStorage.savedJWT("");
    LocalStorage.savedUserInformation('');
    userModel.value = null;
    userRes.value = null;
    EasyLoading.dismiss();
    Get.delete<CartController>();
    Get.delete<CategoryController>();
    Get.delete<AllProductController>();
    Get.delete<BookingController>();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Get.offAll(const RedirectScreen(), transition: Transition.fadeIn);
  }

  ///controller clear
  controllerClear() {
    emailController.text = '';
    passwordController.text = '';
    cartNumberController.text = '';
    zipCodeController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    emailSignUpController.text = '';
    passwordSignUpController.text = '';
    phoneSignUpController.text = '';
  }

  Future<bool> forgotPassword(String email, BuildContext context) async {
    try {
      final DIO.Response response = await dio.post("$FORGOT_PASSWORD/$email");
      if (response.statusCode == 200) {
        Map<String, dynamic> messageRes = response.data;
        log("messageRes :$messageRes");
        if (context.mounted) {
          showSuccessDialog(
              "Information",
              "${messageRes['message'] ?? "Mail Sent On Your Mail Check OTP"}",
              context);
        }
        controllerClear();
        return true;
      } else {
        Map<String, dynamic> messageRes = response.data;
        if (context.mounted) {
          showSuccessDialog(
              "Information",
              "${messageRes['msg'] ?? "Mail Sent On Your Mail Check OTP"}",
              context);
        }
        return false;
      }
      EasyLoading.dismiss();
      return false;
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      log(e.requestOptions.baseUrl + e.requestOptions.path);
      log(e.requestOptions.data);
      return false;
    }
  }

  Future<bool> userUpdate(
      Map<String, dynamic> map, BuildContext context) async {
    try {
      log("Update Data: ${map}");
      log("Update Data: ${dio.options.baseUrl}${USER_UPDATE}");
      final DIO.Response response = await dio.patch(USER_UPDATE, data: map);
      printLog("Res[onse: ${response.data}");
      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = response.data;
        UserUpdateRes newUserRes = UserUpdateRes.fromJson(userMap);
        userModel.value = newUserRes.data!;
        // if (context.mounted) {
        //   showSuccessDialog(
        //       "Information",
        //       "${userMap['message'] ?? "User Profile Update Successful"}",
        //       context);
        // }
        return true;
      }
      // EasyLoading.dismiss();
      return false;
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      log(e.requestOptions.baseUrl + e.requestOptions.path);
      log(e.requestOptions.data);
      log(e.requestOptions.headers.toString());
      return false;
    }
  }

  Future<void> uploadImage(File file) async {
    try {
      String fileName = file.path.split('/').last;
      DIO.FormData formData = DIO.FormData.fromMap({
        "file": await DIO.MultipartFile.fromFile(file.path, filename: fileName),
      });
      DIO.Response response = await dio.post(UPLOAD_IMAGE, data: formData);
      log("Response: ${response.data}");
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      log(e.requestOptions.baseUrl + e.requestOptions.path);
      log(e.requestOptions.data);
      return;
    }
  }

  ///check CODE
  Future<bool> checkOTP(String otp, String email, BuildContext context) async {
    try {
      Map<String, dynamic> otpMap = {
        "email": email,
        "token": num.parse(otp).toInt()
      };
      log("OTPData : ${otpMap}");
      final DIO.Response response = await dio.post(VERIFY_OTP, data: otpMap);
      if (response.statusCode == 200) {
        Map<String, dynamic> messageRes = response.data;
        return true;
      } else {
        Map<String, dynamic> messageRes = response.data;
        if (context.mounted) {
          showSuccessDialog("Information",
              "${messageRes['msg'] ?? "OTP Doesn't Match"}", context);
        }
        return false;
      }
      EasyLoading.dismiss();
      return false;
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      log(e.requestOptions.baseUrl + e.requestOptions.path);
      log(e.requestOptions.data);
      return false;
    }
  }

  Future<bool> changePassword(
      String email, String password, BuildContext context) async {
    try {
      final DIO.Response response =
          await dio.post("$RESET_PASSWORD?email=$email&password=$password");
      log("Url : ${response.requestOptions.baseUrl}${response.requestOptions.path}");
      if (response.statusCode == 200) {
        Map<String, dynamic> messageRes = response.data;
        return true;
      } else {
        Map<String, dynamic> messageRes = response.data;
        if (context.mounted) {
          showSuccessDialog("Information",
              "${messageRes['msg'] ?? "Something Error"}", context);
        }
        return false;
      }
      EasyLoading.dismiss();
      return false;
    } on DIO.DioException catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      log(e.requestOptions.baseUrl + e.requestOptions.path);
      log(e.requestOptions.data);
      return false;
    }
  }

  Rxn<BrandRes> brandRes = Rxn<BrandRes>();
  RxList<BrandModel> brandList = RxList<BrandModel>([]);

  Future<List<BrandModel>> getAllBrands() async {
    printLog("getAllBrands");
    String url = "$ALL_BRANDS?limit=1000000";
    printLog("getAllBrands : $url");
    try {
      final DIO.Response response = await dio.get(url);
      if (response.statusCode == 200) {
        log('AuthBrand: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
        log("Value: ${response.data}");
        Map<String, dynamic> serverJSON = response.data;
        brandRes.value = BrandRes.fromJson(serverJSON);
        brandList.value = brandRes.value!.data ?? [];
        return brandList.value;
      }
      return [];
    } on DIO.DioException catch (e) {
      log("Error Brand: ${e.toString()}: ${e.requestOptions.baseUrl}${e.requestOptions.path}");
      log("Error Brand: ${e.requestOptions.headers.toString()}");
      return [];
    }
  }

  RxString currentAddress = RxString('');
  final addressController = TextEditingController();

  getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData? _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) async {
      // log("Current Location : ${currentLocation.latitude}- ${currentLocation.longitude}");
      try {
        if (currentAddress.value == '') {
          List<Geocoding.Placemark> placemarks =
              await Geocoding.placemarkFromCoordinates(
                  currentLocation.latitude ?? 0.0,
                  currentLocation.longitude ?? 0.0);
          Geocoding.Placemark first = placemarks.first;

          log("Locations: ${first.street}, ${first.locality}, ${first.country}");
          currentAddress.value =
              "${first.street}, ${first.locality}, ${first.country}";
          addressController.text = currentAddress.value ?? "";
        }
      } catch (e) {
        log("Error: $e");
      }
      _locationData = currentLocation;
    });
  }

  showAccountCreateDialog(BuildContext context){
    showCupertinoModalPopup<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.xmark),
            )
          ],
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tickIcon.png',
              width: 80,
              height: 80,
            ).animate(onPlay: (controller) => controller.repeat(reverse: true),).scaleXY(end: 1.2,delay: 400.ms),
            const SizedBox(height: 20),
            Text(
              "Congratulations! Account Create Successfully",
              style: AppTextStyles.drawerTextStyle.copyWith(
                  fontSize: 20,
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Text(
              "Wait For Admin Approval",
              style: AppTextStyles.drawerTextStyle.copyWith(
                  fontSize: 16,
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.w400),
            ),
            // const SizedBox(height: 20),
            // CupertinoButton.filled(
            //   child: const Text("Go To Login",style: TextStyle(fontSize: 13),),
            //   onPressed: () {
            //     Get.back();
            //     Get.offAll(const LoginScreen(),transition: Transition.fadeIn);
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
