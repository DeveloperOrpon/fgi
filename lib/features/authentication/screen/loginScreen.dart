import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:fgi_y2j/config/extend/string.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import 'SignUpScreen.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationController = Get.put(AuthenticationController());
    final key=GlobalKey();
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          key: key,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              statusBarIconBrightness: Brightness.light,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.black,
          body: Stack(
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
              Form(
                key: authenticationController.signInFromKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 100),
                      BounceInLeft(
                        delay: const Duration(milliseconds: 200),
                        child: Text(
                          "Hello There",
                          style: AppTextStyles.boldstyle
                              .copyWith(color: AppColors.strongAmer),
                        ),
                      ),
                      BounceInLeft(
                        delay: const Duration(milliseconds: 400),
                        child: Text(
                          'Welcome Back!',
                          style: AppTextStyles.boldstyle.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(height: 40),
                      BounceInLeft(
                        delay: const Duration(milliseconds: 600),
                        child: Text(
                          "Login,",
                          style: AppTextStyles.boldstyle
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                      BounceInLeft(
                        delay: const Duration(milliseconds: 800),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            onFieldSubmitted: (value) async {
                              FocusScope.of(context).unfocus();
                              if (authenticationController
                                  .signInFromKey.currentState!
                                  .validate()) {
                                authenticationController.loginButtonState.value =
                                    const ButtonState.loading();
                                authenticationController
                                    .loginWithEmailPassword(
                                        authenticationController
                                            .emailController.text
                                            .toLowerCase()
                                            .trim(),
                                        authenticationController
                                            .passwordController.text
                                            .toLowerCase()
                                            .trim(),
                                        context)
                                    .then((value) {
                                  Future.delayed(
                                    const Duration(seconds: 2),
                                    () {
                                      authenticationController.loginButtonState
                                          .value = const ButtonState.idle();
                                    },
                                  );
                                });
                              } else {
                                authenticationController.loginButtonState.value =
                                    const ButtonState.error("");
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () {
                                    authenticationController.loginButtonState
                                        .value = const ButtonState.idle();
                                  },
                                );
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty || !value.isValidEmail()) {
                                return 'Please Provide Valid Email';
                              }
                              return null;
                            },
                            controller: authenticationController.emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
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
                                borderSide: BorderSide(
                                    width: .5, color: AppColors.primary),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: .1,
                                      color: AppColors.primary.withOpacity(.5)),
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Email Address',
                              hintStyle: AppTextStyles.boldstyle.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      BounceInLeft(
                        delay: const Duration(milliseconds: 800),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Obx(() {
                              return TextFormField(
                                obscureText: !authenticationController.loginPasswordShow.value,
                                  onFieldSubmitted: (value) async {
                                    FocusScope.of(context).unfocus();
                                    if (authenticationController
                                        .signInFromKey.currentState!
                                        .validate()) {
                                      authenticationController.loginButtonState
                                          .value = const ButtonState.loading();
                                      authenticationController
                                          .loginWithEmailPassword(
                                              authenticationController
                                                  .emailController.text
                                                  .toLowerCase()
                                                  .trim(),
                                              authenticationController
                                                  .passwordController.text
                                                  .toLowerCase()
                                                  .trim(),
                                              context)
                                          .then((value) {
                                        Future.delayed(
                                          const Duration(seconds: 2),
                                          () {
                                            authenticationController.loginButtonState
                                                .value = const ButtonState.idle();
                                          },
                                        );
                                      });
                                    } else {
                                      authenticationController.loginButtonState
                                          .value = const ButtonState.error("");
                                      Future.delayed(
                                        const Duration(seconds: 2),
                                        () {
                                          authenticationController.loginButtonState
                                              .value = const ButtonState.idle();
                                        },
                                      );
                                    }
                                  },
                                  controller:
                                      authenticationController.passwordController,
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
                                            margin: const EdgeInsets.only(right: 10),
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
                                            icon: authenticationController
                                                    .loginPasswordShow.value
                                                ? const Icon(CupertinoIcons.eye,color: AppColors.primary,)
                                                : const Icon(
                                                    CupertinoIcons.eye_slash_fill,color: AppColors.primary,),
                                            onPressed: () {
                                              authenticationController
                                                      .loginPasswordShow.value =
                                                  !authenticationController
                                                      .loginPasswordShow.value;
                                            },
                                          );
                                        }
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            width: .5, color: AppColors.primary),
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: .1,
                                              color:
                                                  AppColors.primary.withOpacity(.5)),
                                          borderRadius: BorderRadius.circular(10)),
                                      hintText: 'Password',
                                      hintStyle: AppTextStyles.boldstyle.copyWith(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)));
                            }
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Obx(() {
                          return AsyncButtonBuilder(

                            buttonState:
                                authenticationController.loginButtonState.value,
                            errorWidget: Container(
                              color: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              child: const Text(
                                "Try Again",
                                style: TextStyle(color: CupertinoColors.white),
                              ),
                            ),
                            loadingWidget: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: CupertinoActivityIndicator(
                                radius: 15,
                                color: AppColors.primary,
                              ),
                            ),
                            successWidget: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Icon(
                                Icons.check,
                                color: AppColors.primary,
                                size: 30,
                              ),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (authenticationController
                                  .signInFromKey.currentState!
                                  .validate()) {
                                authenticationController.loginButtonState.value =
                                    const ButtonState.loading();
                                authenticationController
                                    .loginWithEmailPassword(
                                        authenticationController
                                            .emailController.text
                                            .toLowerCase()
                                            .trim(),
                                        authenticationController
                                            .passwordController.text
                                            .toLowerCase()
                                            .trim(),
                                        context)
                                    .then((value) {
                                  Future.delayed(
                                    const Duration(seconds: 2),
                                    () {
                                      authenticationController.loginButtonState
                                          .value = const ButtonState.idle();
                                    },
                                  );
                                });
                              } else {
                                authenticationController.loginButtonState.value =
                                    const ButtonState.error("");
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () {
                                    authenticationController.loginButtonState
                                        .value = const ButtonState.idle();
                                  },
                                );
                              }
                            },
                            loadingSwitchInCurve: Curves.bounceInOut,
                            loadingTransitionBuilder: (child, animation) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 1.0),
                                  end: const Offset(0, 0),
                                ).animate(animation),
                                child: child,
                              );
                            },
                            builder: (context, child, callback, state) {
                              return Material(
                                color: state.maybeWhen(
                                  success: () => Colors.transparent,
                                  orElse: () => Colors.transparent,
                                  error: (error, stackTrace) => Colors.red,
                                ),
                                // This prevents the loading indicator showing below the
                                // button
                                clipBehavior: Clip.hardEdge,
                                shape: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.primary, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: callback,
                                  child: child,
                                ),
                              );
                            },
                            sizeClipBehavior: Clip.none,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () {
                              Get.to(const ForgotPassword(),transition: Transition.rightToLeftWithFade);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: AppTextStyles.boldstyle.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            )),
                      ),
                      SizedBox(height: Get.height / 6),
                      InkWell(
                        onTap: () {

                          Get.to(const SignUpScreen(),
                              curve: Curves.bounceInOut,
                              transition: Transition.upToDown);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Not a Registered user?",
                                style: AppTextStyles.boldstyle.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                              TextSpan(
                                onEnter: (event) {
                                  log("message");
                                },
                                recognizer: TapAndPanGestureRecognizer(),
                                text: " Register",
                                style: AppTextStyles.boldstyle.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
