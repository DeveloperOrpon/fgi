import 'package:animate_do/animate_do.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:fgi_y2j/config/extend/string.dart';
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/authentication/screen/loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import 'Input_Password_Screen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authenticationController=Get.put(AuthenticationController());
    authenticationController.forgotButtonState.value=const ButtonState.idle();
    final key=GlobalKey();
    return Scaffold(
      key:key,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: const Icon(CupertinoIcons.back,color: AppColors.primary,size: 25,)),
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
            key: authenticationController.forgotFromKey,
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
                      "Forgot Password,",
                      style: AppTextStyles.boldstyle
                          .copyWith(color: AppColors.white),
                    ),
                  ),  BounceInLeft(
                    delay: const Duration(milliseconds: 600),
                    child:Text(
                      "Please Provide The Valid Email Address For Sent Email On Your Mail Address ",
                      style: AppTextStyles.boldstyle
                          .copyWith(color: AppColors.strongAmer,fontSize: 12,fontWeight: FontWeight.normal),
                    ),
                  ),
                  BounceInLeft(
                    delay: const Duration(milliseconds: 800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        controller: authenticationController.forgotEmailController,
                        onFieldSubmitted: (value) async {

                        },
                        validator: (value) {
                          if (value!.isEmpty || !value.isValidEmail()) {
                            return 'Please Provide Valid Email';
                          }
                          return null;
                        },
                        // controller: authenticationController.emailController,
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
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style:ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: BorderSide(
                            color: AppColors.primary,
                            width: 1,
                          )
                      ) ,
                      onPressed: () async {
                        if(authenticationController.forgotFromKey.currentState!.validate()){
                          startLoading("Please Wait..");
                          FocusScope.of(context).unfocus();
                          authenticationController.forgotButtonState.value=const ButtonState.loading();
                          authenticationController.forgotPassword(authenticationController.forgotEmailController.text.trim(), context).then((value){
                            EasyLoading.dismiss();
                            if(value){
                              Future.delayed(const Duration(seconds: 3),() {
                                Get.to( InputPasswordScreen(email:authenticationController.forgotEmailController.text.trim() ),transition: Transition.rightToLeftWithFade);
                              },);
                            }else{
                              authenticationController.forgotButtonState.value=const ButtonState.error('');
                              Future.delayed(const Duration(seconds: 1),() {
                                authenticationController.forgotButtonState.value=const ButtonState.idle();

                              },);
                            }
                          });

                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        child: Text(
                          'Sent Mail',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Get.height / 6),
                  InkWell(
                    onTap: () {
                      Get.off(const LoginScreen(),
                          curve: Curves.bounceInOut,
                          transition: Transition.upToDown);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Have an Account?",
                            style: AppTextStyles.boldstyle.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          TextSpan(
                            onEnter: (event) {

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
    );
  }
}
