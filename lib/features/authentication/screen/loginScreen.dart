
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import 'SIgnUpScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Image.asset(
              loginCarouselSliderImage[0],
              fit: BoxFit.cover,
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
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 170,
                        ),
                        BounceInLeft(
                          delay: const Duration(milliseconds: 200),
                          child: Text(
                            "Hello There,",
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
                        SizedBox(
                          height: 40,
                        ),
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
                                style:const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail,color: AppColors.white,),
                                    hintText: 'Email Address',
                                    hintStyle: AppTextStyles.boldstyle.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16))),
                          ),
                        ),
                        BounceInLeft(
                          delay: const Duration(milliseconds: 800),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: TextFormField(
                              style:const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock,color: AppColors.white,),
                                    hintText: 'Password',
                                    hintStyle: AppTextStyles.boldstyle.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16))),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                            child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "Login",
                            style: AppTextStyles.boldstyle.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.white),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15)),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: AppTextStyles.boldstyle.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              )),
                        ),
                         SizedBox(height: Get.height/6),
                        InkWell(
                          onTap: () {
                            Get.to(const SignUpScreen(),curve: Curves.bounceInOut,transition: Transition.upToDown);
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
