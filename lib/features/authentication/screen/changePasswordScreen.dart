import 'package:animate_do/animate_do.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fgi_y2j/config/extend/string.dart';
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import 'loginScreen.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String email;
  const ChangePasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthenticationController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: AppColors.primary,
              size: 25,
            )),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Image.asset(
              loginCarouselSliderImage[0],
              fit: BoxFit.contain,
              height: 350,
              width: Get.width,
            ),
            Container(
              height: Get.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.black.withOpacity(.5),
                Colors.black,
              ], begin: Alignment.topCenter)),
            ),
            Center(
              child: Form(
                key: authController.forgotPassFromKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SlideInDown(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularCountDownTimer(
                          duration: 2000,
                          initialDuration: 0,
                          controller: CountDownController(),
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.height / 6,
                          ringColor: Colors.grey[300]!,
                          ringGradient: null,
                          fillColor: AppColors.primary,
                          fillGradient: null,
                          backgroundColor: AppColors.blackLight,
                          backgroundGradient: null,
                          strokeWidth: 10.0,
                          strokeCap: StrokeCap.round,
                          textStyle: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textFormat: CountdownTextFormat.MM_SS,
                          isReverse: true,
                          isReverseAnimation: true,
                          isTimerTextShown: true,
                          autoStart: true,
                          onStart: () {
                            printLog('Countdown Started');
                          },
                          onComplete: () {
                            showErrorDialogInTop("Warning", "Time Is Over", context);
                            Future.delayed(Duration(seconds: 1),() {
                              Get.offAll(const LoginScreen(),transition: Transition.zoom);
                            },);

                          },
                          onChange: (String timeStamp) {
                            printLog('Countdown Changed $timeStamp');
                          },

                          timeFormatterFunction:
                              (defaultFormatterFunction, duration) {
                            if (duration.inSeconds == 0) {
                              return "Retry Again";
                            } else {
                              return Function.apply(

                                  defaultFormatterFunction, [duration]);
                            }
                          },
                        ),
                      ),
                    ),
                    // Section 1 - Header

                    const SizedBox(height: 40),
                    BounceInRight(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || !value.isValidEmail()) {
                            return 'Please Provide Valid Email';
                          }
                          return null;
                        },
                        controller: authController.forgotEmailController,
                        autofocus: false,
                        enabled: false,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'youremail@email.com',
                          prefixIcon: SizedBox(
                            width: 60,
                            height: 57,
                            child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.mail,
                                  size: 25,
                                  color: AppColors.white,
                                )),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: .5, color: AppColors.primary),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: .1,
                                  color: AppColors.primary.withOpacity(.5)),
                              borderRadius: BorderRadius.circular(10)),
                          hintStyle: AppTextStyles.boldstyle.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      ),
                    ),

                    // Password
                    const SizedBox(height: 15),
                    BounceInLeft(
                      child: Obx(() {
                        return TextFormField(
                            controller: authController.passForgotController,
                            autofocus: false,
                            obscureText:
                                !authController.forgotPasswordInput.value,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Please Provide Valid Password (Minimum 6 Digit)';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: SizedBox(
                                  width: 60,
                                  height: 57,
                                  child: Container(
                                      margin:
                                          const EdgeInsets.only(right: 10),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.lock,
                                        size: 25,
                                        color: AppColors.white,
                                      )),
                                ),
                                suffixIcon: Obx(() {
                                  return IconButton(
                                    icon: authController
                                            .forgotPasswordInput.value
                                        ? const Icon(
                                            CupertinoIcons.eye,
                                            color: AppColors.primary,
                                          )
                                        : const Icon(
                                            CupertinoIcons.eye_slash_fill,
                                            color: AppColors.primary,
                                          ),
                                    onPressed: () {
                                      authController
                                              .forgotPasswordInput.value =
                                          !authController
                                              .forgotPasswordInput.value;
                                    },
                                  );
                                }),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: .5, color: AppColors.primary),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: .1,
                                        color: AppColors.primary
                                            .withOpacity(.5)),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: '**********',
                                labelText: 'Input New Password',
                                labelStyle:
                                    const TextStyle(color: Colors.grey),
                                hintStyle: AppTextStyles.boldstyle.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16)));
                      }),
                    ),
                    const SizedBox(height: 15),
                    BounceInRight(
                      child: Obx(() {
                        return TextFormField(
                            controller:
                                authController.passForgotVerifyController,
                            autofocus: false,
                            obscureText: !authController
                                .forgotPasswordVerifyInput.value,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Please Provide Valid Password (Minimum 6 Digit)';
                              }
                              if(authController.passForgotController.text.trim()!=value){
                                return 'Confirm Password Does not Match';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                prefixIcon: SizedBox(
                                  width: 60,
                                  height: 57,
                                  child: Container(
                                      margin:
                                          const EdgeInsets.only(right: 10),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.lock,
                                        size: 25,
                                        color: AppColors.white,
                                      )),
                                ),
                                suffixIcon: Obx(() {
                                  return IconButton(
                                    icon: authController
                                            .forgotPasswordVerifyInput.value
                                        ? const Icon(
                                            CupertinoIcons.eye,
                                            color: AppColors.primary,
                                          )
                                        : const Icon(
                                            CupertinoIcons.eye_slash_fill,
                                            color: AppColors.primary,
                                          ),
                                    onPressed: () {
                                      authController.forgotPasswordVerifyInput
                                              .value =
                                          !authController
                                              .forgotPasswordVerifyInput
                                              .value;
                                    },
                                  );
                                }),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: .5, color: AppColors.primary),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: .1,
                                        color: AppColors.primary
                                            .withOpacity(.5)),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: '**********',
                                labelText: 'Confirm New Password',
                                labelStyle:
                                    const TextStyle(color: Colors.grey),
                                hintStyle: AppTextStyles.boldstyle.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16)));
                      }),
                    ),
                     SizedBox(height: Get.height*.05),
                    BounceInUp(
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (authController.forgotPassFromKey.currentState!
                              .validate()) {
                            startLoading("Wait..");
                            authController.changePassword(email, authController.passForgotVerifyController.text.trim(), context).then((value){
                              if(value){
                                authController.passForgotVerifyController.text='';
                                authController.passForgotController.text='';
                                authController.passForgotVerifyController.text='';
                                EasyLoading.dismiss();
                                showSuccessToastTop("Information", "Password Changed Successfully", context);
                                Future.delayed(Duration(seconds: 1),() {
                                  Get.offAll(LoginScreen(),transition: Transition.fade);
                                },);
                              }
                              EasyLoading.dismiss();

                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromWidth(Get.width*.6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Change Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
