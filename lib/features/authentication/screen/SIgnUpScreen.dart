import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import '../controller/AuthenticationController.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationController = Get.put(AuthenticationController());
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
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  SizedBox(
                    height: 40,
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
                      child: Obx(() {
                        return Text(
                          authenticationController.timelineIndex == 0
                              ? "Cart Details"
                              : authenticationController.timelineIndex == 1
                                  ? "Personal Details"
                                  : authenticationController.timelineIndex == 2
                                      ? "Payment Details"
                                      : 'Check Informations',
                          style: AppTextStyles.boldstyle
                              .copyWith(color: AppColors.white),
                        );
                      })),
                  SizedBox(
                    height: 60,
                    child: Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                authenticationController.timelineIndex.value =
                                    0;
                              },
                              child: TimelineTile(
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.center,
                                isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                  height: 15,
                                  width: 15,
                                  color: authenticationController
                                                  .timelineIndex.value ==
                                              0 ||
                                          authenticationController
                                                  .timelineIndex.value >
                                              0
                                      ? AppColors.strongAmer
                                      : Colors.white,
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Colors.white,
                                  thickness: 2,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                authenticationController.timelineIndex.value =
                                    1;
                              },
                              child: TimelineTile(
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.center,
                                indicatorStyle: IndicatorStyle(
                                  height: 15,
                                  width: 15,
                                  color: authenticationController
                                                  .timelineIndex.value ==
                                              1 ||
                                          authenticationController
                                                  .timelineIndex.value >
                                              1
                                      ? AppColors.strongAmer
                                      : Colors.white,
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Colors.white,
                                  thickness: 2,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                authenticationController.timelineIndex.value =
                                    2;
                              },
                              child: TimelineTile(
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.center,
                                indicatorStyle: IndicatorStyle(
                                  height: 15,
                                  width: 15,
                                  color: authenticationController
                                                  .timelineIndex.value ==
                                              2 ||
                                          authenticationController
                                                  .timelineIndex.value >
                                              2
                                      ? AppColors.strongAmer
                                      : Colors.white,
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Colors.white,
                                  thickness: 2,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                authenticationController.timelineIndex.value =
                                    3;
                              },
                              child: TimelineTile(
                                axis: TimelineAxis.horizontal,
                                alignment: TimelineAlign.center,
                                isLast: true,
                                indicatorStyle: IndicatorStyle(
                                  height: 15,
                                  width: 15,
                                  color: authenticationController
                                                  .timelineIndex.value ==
                                              3 ||
                                          authenticationController
                                                  .timelineIndex.value >
                                              3
                                      ? AppColors.strongAmer
                                      : Colors.white,
                                ),
                                beforeLineStyle: const LineStyle(
                                  color: Colors.white,
                                  thickness: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  Obx(() {
                    return authenticationController.timelineIndex == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Cart Number',
                                    hintStyle: AppTextStyles.boldstyle.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16))),
                          )
                        : authenticationController.timelineIndex == 1
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: TextFormField(
                                            style: const TextStyle(
                                                color: Colors.white),
                                            decoration: InputDecoration(
                                                hintText: 'First Name',
                                                hintStyle: AppTextStyles
                                                    .boldstyle
                                                    .copyWith(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16)))),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: TextFormField(
                                            style: const TextStyle(
                                                color: Colors.white),
                                            decoration: InputDecoration(
                                                hintText: 'Last Name',
                                                hintStyle: AppTextStyles
                                                    .boldstyle
                                                    .copyWith(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16)))),
                                  ],
                                ),
                              )
                            : authenticationController.timelineIndex == 2
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    padding: const EdgeInsets.only(left: 15),
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.2),
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Chose Subscription",
                                              style: AppTextStyles.boldstyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(.25),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Center();
                  }),
                  Obx(() {
                    return authenticationController.timelineIndex == 0
                        ? Container(
                            padding: const EdgeInsets.only(left: 15),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.2),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () {
                                authenticationController.isShowCompany.value =
                                    !authenticationController
                                        .isShowCompany.value;
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Chose Company",
                                      style: AppTextStyles.boldstyle.copyWith(
                                          fontSize: 14,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.normal)),
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.25),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Obx(() {
                                      return authenticationController
                                              .isShowCompany.value
                                          ? const Icon(
                                              Icons.arrow_drop_up_outlined,
                                              color: Colors.white,
                                            )
                                          : const Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: AppColors.white,
                                            );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : authenticationController.timelineIndex == 1
                            ? TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'E-mail address',
                                    hintStyle: AppTextStyles.boldstyle.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)))
                            : authenticationController.timelineIndex == 2
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.only(left: 15),
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.2),
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Payment Method",
                                              style: AppTextStyles.boldstyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(.25),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Center();
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: authenticationController.isShowCompany.value &&
                              authenticationController.timelineIndex == 0
                          ? 60
                          : 0,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(.2),
                            ),
                            height: 60,
                            width: Get.width * .43,
                            child: Image.asset('assets/demo/a.png'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(.2),
                            ),
                            height: 60,
                            width: Get.width * .43,
                            child: Image.asset('assets/demo/b.png'),
                          ),
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return authenticationController.timelineIndex == 0
                        ? Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.only(left: 15),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.2),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () {
                                authenticationController
                                    .showAddressBottomSheet(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Location",
                                      style: AppTextStyles.boldstyle.copyWith(
                                          fontSize: 14,
                                          color: AppColors.white,
                                          fontWeight: FontWeight.normal)),
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.25),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : authenticationController.timelineIndex == 1
                            ? TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: AppTextStyles.boldstyle.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)))
                            : authenticationController.timelineIndex == 2
                                ? TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        hintText: 'Cart Number',
                                        hintStyle: AppTextStyles.boldstyle
                                            .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16)))
                                : Center();
                  }),
                  Obx(() {
                    return authenticationController.timelineIndex == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    hintText: 'Zip Code',
                                    hintStyle: AppTextStyles.boldstyle.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16))),
                          )
                        : authenticationController.timelineIndex == 1
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        hintText: 'Re-type password',
                                        hintStyle: AppTextStyles.boldstyle
                                            .copyWith(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16))),
                              )
                            : Center();
                  }),
                  Obx(() => authenticationController.timelineIndex == 3
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cart Details",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),Text(
                              "Name:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),SizedBox(height: 8),Text(
                              "Category:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),SizedBox(height: 8),Text(
                              "Location:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                      SizedBox(height: 16),
                            SizedBox(height: 15), Text(
                              "Your Details",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),Text(
                              "Name:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),SizedBox(height: 8),Text(
                              "E-mail:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),SizedBox(height: 8),Text(
                              "Phone number:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 16),
                            SizedBox(height: 15), Text(
                              "Payment Details",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),Text(
                              "Payment method:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),SizedBox(height: 8),Text(
                              "Cart number:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),SizedBox(height: 8),Text(
                              "Location:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 16)
                          ],
                        )
                      : Center()),
                  SizedBox(height: 15),
                  Center(
                      child: OutlinedButton(
                    onPressed: () {
                      authenticationController.timelineIndex.value++;
                    },
                    child: Text(
                      "Next",
                      style: AppTextStyles.boldstyle.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.white),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
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
                  SizedBox(
                    height: Get.height * .05,
                  ),
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
