import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              loginCarouselSliderImage[2],
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  SizedBox(
                    height: 80,
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
                      "Let's Connect your Cart!",
                      style: AppTextStyles.boldstyle.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BounceInLeft(
                      delay: const Duration(milliseconds: 600),
                      child: Text(
                        "Cart Details",
                        style: AppTextStyles.boldstyle
                            .copyWith(color: AppColors.white),
                      )),
                  SizedBox(
                    height: 60,
                    child: Row(children: [
                      Expanded(
                        child: TimelineTile(
                          axis: TimelineAxis.horizontal,
                          alignment: TimelineAlign.center,
                          isFirst: true,
                          indicatorStyle: const IndicatorStyle(
                            height: 15,
                            width: 15,
                            color: Colors.white,
                          ),
                          beforeLineStyle: const LineStyle(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                      ),Expanded(
                        child: TimelineTile(
                          axis: TimelineAxis.horizontal,
                          alignment: TimelineAlign.center,

                          indicatorStyle: const IndicatorStyle(
                            height: 15,
                            width: 15,
                            color: Colors.white,
                          ),
                          beforeLineStyle: const LineStyle(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                      ),Expanded(
                        child: TimelineTile(
                          axis: TimelineAxis.horizontal,
                          alignment: TimelineAlign.center,

                          indicatorStyle: const IndicatorStyle(
                            height: 15,
                            width: 15,
                            color: Colors.white,
                          ),
                          beforeLineStyle: const LineStyle(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                      ),Expanded(
                        child : TimelineTile(
                          axis: TimelineAxis.horizontal,
                          alignment: TimelineAlign.center,
                          isLast: true,
                          indicatorStyle: const IndicatorStyle(
                            height: 15,
                            width: 15,
                            color: Colors.white,
                          ),
                          beforeLineStyle: const LineStyle(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                      ),
                    ],),
                  ),
                  BounceInLeft(
                    delay: const Duration(milliseconds: 800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                          style:const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Cart Number',
                              hintStyle: AppTextStyles.boldstyle.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16))),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius:  BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Chose Company",style: AppTextStyles.boldstyle.copyWith(
                          fontSize: 14,
                        color: AppColors.white,
                        fontWeight: FontWeight.normal)),Icon(Icons.arrow_drop_down_outlined,color: AppColors.white,),
                      ],
                    ),
                  ),Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius:  BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Location",style: AppTextStyles.boldstyle.copyWith(
                          fontSize: 14,
                        color: AppColors.white,
                        fontWeight: FontWeight.normal)),Icon(Icons.arrow_drop_down_outlined,color: AppColors.white,),
                      ],
                    ),
                  ),
                  BounceInLeft(
                    delay: const Duration(milliseconds: 800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                          style:const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Zip Code',
                              hintStyle: AppTextStyles.boldstyle.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16))),
                    ),
                  ),
                  SizedBox(height:15),
                  Center(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "Next",
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
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // Get.to(const SignUpScreen(),curve: Curves.bounceInOut,transition: Transition.upToDown);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Already Registered?",
                            style: AppTextStyles.boldstyle.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          TextSpan(

                            recognizer: TapAndPanGestureRecognizer(),
                            text: " Login",
                            style: AppTextStyles.boldstyle.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height*.05,),
                  InkWell(
                    onTap: () {
                      // Get.to(const SignUpScreen(),curve: Curves.bounceInOut,transition: Transition.upToDown);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Read the terms and conditions ",
                            style: AppTextStyles.boldstyle.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          TextSpan(

                            recognizer: TapAndPanGestureRecognizer(),
                            text: " here..",
                            style: AppTextStyles.boldstyle.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
