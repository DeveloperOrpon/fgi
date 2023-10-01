import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/config/extend/string.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import '../component/addressDialog.dart';
import '../controller/AuthenticationController.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
    final authenticationController = Get.put(AuthenticationController());
    return WillPopScope(
      onWillPop: () async {
        authenticationController.timelineIndex.value = 0;
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  if (authenticationController.timelineIndex.value == 0) {
                    Get.back();
                  } else {
                    authenticationController.timelineIndex.value--;
                  }
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
          key: key,
          backgroundColor: Colors.black,
          body: Form(
            key: authenticationController.signupFromKey,
            child: Stack(
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 30),
                      BounceInLeft(
                          delay: const Duration(milliseconds: 600),
                          child: Obx(() {
                            return Text(
                              authenticationController.timelineIndex.value == 0
                                  ? "Cart Details"
                                  : authenticationController
                                              .timelineIndex.value ==
                                          1
                                      ? "Personal Details"
                                      : authenticationController
                                                  .timelineIndex.value ==
                                              2
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
                                    authenticationController
                                        .timelineIndex.value = 0;
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
                                    if (authenticationController
                                            .signupFromKey.currentState!
                                            .validate() ||
                                        authenticationController
                                                .timelineIndex.value >
                                            1) {
                                      authenticationController
                                          .timelineIndex.value = 1;
                                    } else {
                                      showErrorDialogInTop(
                                          "Warning",
                                          "Please Fill This State First",
                                          context);
                                    }
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
                                    if (authenticationController
                                            .signupFromKey.currentState!
                                            .validate() ||
                                        authenticationController
                                                .timelineIndex.value >
                                            2) {
                                      authenticationController
                                          .timelineIndex.value = 2;
                                    } else {
                                      showErrorDialogInTop(
                                          "Warning",
                                          "Please Fill This State First",
                                          context);
                                    }
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
                                    if (authenticationController
                                            .signupFromKey.currentState!
                                            .validate() ||
                                        authenticationController
                                                .timelineIndex.value >
                                            3) {
                                      authenticationController
                                          .timelineIndex.value = 3;
                                    } else {
                                      showErrorDialogInTop(
                                          "Warning",
                                          "Please Fill This State First",
                                          context);
                                    }
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
                        return authenticationController.timelineIndex.value == 0
                            ? SlideInRight(
                                from: 300,
                                delay: 300.ms,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.length < 5) {
                                          return "Please Provide Cart Number";
                                        }
                                        return null;
                                      },
                                      controller: authenticationController
                                          .cartNumberController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          prefixIcon: SizedBox(
                                            width: 60,
                                            height: 57,
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: const BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  CupertinoIcons.creditcard,
                                                  size: 25,
                                                  color: AppColors.white,
                                                )),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                width: .5,
                                                color: AppColors.primary),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .1,
                                                  color: AppColors.primary
                                                      .withOpacity(.5)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          hintText: 'Cart Number',
                                          hintStyle: AppTextStyles.boldstyle
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16))),
                                ),
                              )
                            : authenticationController.timelineIndex.value == 1
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: SlideInRight(
                                          from: 300,
                                          delay: 300.ms,
                                          child: TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.length < 5) {
                                                  return "Please Provide First Name";
                                                }
                                                return null;
                                              },
                                              controller:
                                                  authenticationController
                                                      .firstNameController,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                  hintText: 'First Name',
                                                  prefixIcon: SizedBox(
                                                    width: 60,
                                                    height: 57,
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppColors.primary,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                          CupertinoIcons.person,
                                                          size: 25,
                                                          color:
                                                              AppColors.white,
                                                        )),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            width: .5,
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: .1,
                                                          color: AppColors
                                                              .primary
                                                              .withOpacity(.5)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  hintStyle: AppTextStyles
                                                      .boldstyle
                                                      .copyWith(
                                                          color:
                                                              AppColors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16))),
                                        )),
                                        const SizedBox(width: 10),
                                        Expanded(
                                            child: SlideInLeft(
                                          from: 300,
                                          delay: 300.ms,
                                          child: TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.length < 5) {
                                                  return "Please Provide Last Name";
                                                }
                                                return null;
                                              },
                                              controller:
                                                  authenticationController
                                                      .lastNameController,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                  hintText: 'Last Name',
                                                  prefixIcon: SizedBox(
                                                    width: 60,
                                                    height: 57,
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppColors.primary,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                          CupertinoIcons.person,
                                                          size: 25,
                                                          color:
                                                              AppColors.white,
                                                        )),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            width: .5,
                                                            color: AppColors
                                                                .primary),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: .1,
                                                          color: AppColors
                                                              .primary
                                                              .withOpacity(.5)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  hintStyle: AppTextStyles
                                                      .boldstyle
                                                      .copyWith(
                                                          color:
                                                              AppColors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16))),
                                        )),
                                      ],
                                    ),
                                  )
                                : authenticationController
                                            .timelineIndex.value ==
                                        2
                                    ? BounceInRight(
                                        from: 300,
                                        delay: 300.ms,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.2),
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: PullDownButton(
                                            menuOffset: 50,
                                            position: PullDownMenuPosition.over,
                                            itemBuilder: (context) => [
                                              const PullDownMenuTitle(
                                                  title: Text(
                                                "Chose Subscription",
                                              )),
                                              PullDownMenuItem.selectable(
                                                selected:
                                                    authenticationController
                                                            .selectSubscription
                                                            .value ==
                                                        "Basic Plan",
                                                icon: Icons
                                                    .airline_seat_recline_normal,
                                                title: 'Basic Plan',
                                                onTap: () {
                                                  authenticationController
                                                      .selectSubscription
                                                      .value = "Basic Plan";
                                                },
                                              ),
                                              const PullDownMenuDivider(),
                                              PullDownMenuItem.selectable(
                                                selected:
                                                    authenticationController
                                                            .selectSubscription
                                                            .value ==
                                                        "Pro Plan",
                                                icon: Icons.paid_rounded,
                                                title: 'Pro Plan',
                                                onTap: () {
                                                  authenticationController
                                                      .selectSubscription
                                                      .value = "Pro Plan";
                                                },
                                              ),
                                              const PullDownMenuDivider(),
                                              PullDownMenuItem.selectable(
                                                selected:
                                                    authenticationController
                                                            .selectSubscription
                                                            .value ==
                                                        "Advance Plan",
                                                icon: FontAwesomeIcons.adversal,
                                                title: 'Advance Plan',
                                                onTap: () {
                                                  authenticationController
                                                      .selectSubscription
                                                      .value = "Advance Plan";
                                                },
                                              ),
                                            ],
                                            buttonBuilder:
                                                (context, showMenu) => InkWell(
                                              onTap: showMenu,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 60,
                                                    height: 60,
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppColors.primary,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                          CupertinoIcons
                                                              .purchased_circle_fill,
                                                          size: 25,
                                                          color:
                                                              AppColors.white,
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Obx(() {
                                                      return Text(
                                                          authenticationController
                                                                  .selectSubscription
                                                                  .value ??
                                                              "Chose Subscription",
                                                          style: AppTextStyles
                                                              .boldstyle
                                                              .copyWith(
                                                                  fontSize: 14,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal));
                                                    }),
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .arrow_drop_down_outlined,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const Center();
                      }),
                      Obx(() {
                        return authenticationController.timelineIndex.value == 0
                            ? SlideInLeft(
                                from: 300,
                                delay: 300.ms,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 0),
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
                                              .isShowCompany.value =
                                          !authenticationController
                                              .isShowCompany.value;
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: const BoxDecoration(
                                                color: AppColors.primary,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.mail,
                                                size: 25,
                                                color: AppColors.white,
                                              )),
                                        ),
                                        Expanded(
                                          child: Text("Chose Company",
                                              style: AppTextStyles.boldstyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                        ),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(.25),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Obx(() {
                                            return authenticationController
                                                    .isShowCompany.value
                                                ? const Icon(
                                                    Icons
                                                        .arrow_drop_up_outlined,
                                                    color: Colors.white,
                                                  )
                                                : const Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    color: AppColors.white,
                                                  );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : authenticationController.timelineIndex.value == 1
                                ? SlideInRight(
                                    from: 300,
                                    delay: 300.ms,
                                    child: TextFormField(
                                        validator: (value) {
                                          if (value == null ||
                                              !value.isValidEmail()) {
                                            return "Please Provide Email Address";
                                          }
                                          return null;
                                        },
                                        controller: authenticationController
                                            .emailSignUpController,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                            hintText: 'E-mail address',
                                            prefixIcon: SizedBox(
                                              width: 60,
                                              height: 57,
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      topLeft:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.mail,
                                                    size: 25,
                                                    color: AppColors.white,
                                                  )),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: .5,
                                                  color: AppColors.primary),
                                            ),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: .1,
                                                    color: AppColors.primary
                                                        .withOpacity(.5)),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            hintStyle: AppTextStyles.boldstyle
                                                .copyWith(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16))),
                                  )
                                : authenticationController
                                            .timelineIndex.value ==
                                        2
                                    ? BounceInLeft(
                                        from: 300,
                                        delay: 300.ms,
                                        child: PullDownButton(
                                          menuOffset: 50,
                                          position: PullDownMenuPosition.over,
                                          itemBuilder: (context) => [
                                            const PullDownMenuTitle(
                                                title: Text(
                                              "Payment Method",
                                            )),
                                            PullDownMenuItem.selectable(
                                              selected: authenticationController
                                                      .selectPaymentType
                                                      .value ==
                                                  "Cash-On",
                                              icon: FontAwesomeIcons.amazonPay,
                                              title: "Cash-On",
                                              onTap: () {
                                                authenticationController
                                                    .selectPaymentType
                                                    .value = "Cash-On";
                                              },
                                            ),
                                            const PullDownMenuDivider(),
                                            PullDownMenuItem.selectable(
                                              selected: authenticationController
                                                      .selectPaymentType
                                                      .value ==
                                                  "Online Payment",
                                              icon: CupertinoIcons.creditcard,
                                              title: "Online Payment",
                                              onTap: () {
                                                authenticationController
                                                    .selectPaymentType
                                                    .value = "Online Payment";
                                              },
                                            ),
                                          ],
                                          buttonBuilder: (context, showMenu) =>
                                              Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(.2),
                                              border: Border.all(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: InkWell(
                                              onTap: showMenu,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 60,
                                                    height: 60,
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppColors.primary,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        child: const Icon(
                                                          Icons.payment,
                                                          size: 25,
                                                          color:
                                                              AppColors.white,
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Obx(() {
                                                      return Text(
                                                          authenticationController
                                                                  .selectPaymentType
                                                                  .value ??
                                                              "Payment Method",
                                                          style: AppTextStyles
                                                              .boldstyle
                                                              .copyWith(
                                                                  fontSize: 14,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal));
                                                    }),
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .arrow_drop_down_outlined,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const Center();
                      }),
                      Obx(() {
                        return (authenticationController.timelineIndex.value ==
                                1)
                            ? FadeInUp(
                                delay: 300.ms,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 2),
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.length < 6) {
                                          return "Please Provide valid Phone Number";
                                        }
                                        return null;
                                      },
                                      controller: authenticationController
                                          .phoneSignUpController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'Phone Number',
                                          prefixIcon: SizedBox(
                                            width: 60,
                                            height: 57,
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: const BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  CupertinoIcons.phone_circle,
                                                  size: 25,
                                                  color: AppColors.white,
                                                )),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                width: .5,
                                                color: AppColors.primary),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .1,
                                                  color: AppColors.primary
                                                      .withOpacity(.5)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          hintStyle: AppTextStyles.boldstyle
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16))),
                                ),
                              )
                            : const Center();
                      }),
                      const SizedBox(height: 10),
                      Obx(() {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          height:
                              authenticationController.isShowCompany.value &&
                                      authenticationController
                                              .timelineIndex.value ==
                                          0
                                  ? 60
                                  : 0,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
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
                        return authenticationController.timelineIndex.value == 0
                            ? SlideInRight(
                                from: 300,
                                delay: 300.ms,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.only(left: 0),
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
                                      showAddressBottomSheet(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: const BoxDecoration(
                                                color: AppColors.primary,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                ),
                                              ),
                                              child: const Icon(
                                                CupertinoIcons.location_fill,
                                                size: 25,
                                                color: AppColors.white,
                                              )),
                                        ),
                                        Expanded(
                                          child: Text("Location",
                                              style: AppTextStyles.boldstyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                        ),
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
                                ),
                              )
                            : authenticationController.timelineIndex.value == 1
                                ? SlideInLeft(
                                    from: 300,
                                    delay: 300.ms,
                                    child: TextFormField(
                                        validator: (value) {
                                          if (value == null ||
                                              value.length < 6) {
                                            return "Please Provide password (6 digit)";
                                          }
                                          return null;
                                        },
                                        controller: authenticationController
                                            .passwordSignUpController,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                            hintText: 'Password',
                                            prefixIcon: SizedBox(
                                              width: 60,
                                              height: 57,
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      topLeft:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    CupertinoIcons.lock,
                                                    size: 25,
                                                    color: AppColors.white,
                                                  )),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  width: .5,
                                                  color: AppColors.primary),
                                            ),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: .1,
                                                    color: AppColors.primary
                                                        .withOpacity(.5)),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            hintStyle: AppTextStyles.boldstyle
                                                .copyWith(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16))),
                                  )
                                : authenticationController
                                            .timelineIndex.value ==
                                        2
                                    ? BounceInRight(
                                        from: 300,
                                        delay: 300.ms,
                                        child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.length < 6) {
                                                return "Please Provide Cart Number";
                                              }
                                              return null;
                                            },
                                            controller: authenticationController
                                                .cartNumberController,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            decoration: InputDecoration(
                                                hintText: 'Cart Number',
                                                prefixIcon: SizedBox(
                                                  width: 60,
                                                  height: 57,
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppColors.primary,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                        CupertinoIcons
                                                            .creditcard,
                                                        size: 25,
                                                        color: AppColors.white,
                                                      )),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      width: .5,
                                                      color: AppColors.primary),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: .1,
                                                        color: AppColors.primary
                                                            .withOpacity(.5)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                hintStyle: AppTextStyles
                                                    .boldstyle
                                                    .copyWith(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16))),
                                      )
                                    : const Center();
                      }),
                      Obx(() {
                        return authenticationController.timelineIndex.value == 0
                            ? SlideInLeft(
                                from: 300,
                                delay: 300.ms,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Provide Zip Code";
                                        }
                                        return null;
                                      },
                                      controller: authenticationController
                                          .zipCodeController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: 'Zip Code',
                                          prefixIcon: SizedBox(
                                            width: 60,
                                            height: 57,
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: const BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: const Icon(
                                                  FontAwesomeIcons
                                                      .solidFileZipper,
                                                  size: 25,
                                                  color: AppColors.white,
                                                )),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                width: .5,
                                                color: AppColors.primary),
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: .1,
                                                  color: AppColors.primary
                                                      .withOpacity(.5)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          hintStyle: AppTextStyles.boldstyle
                                              .copyWith(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16))),
                                ),
                              )
                            : authenticationController.timelineIndex.value == 1
                                ? SlideInRight(
                                    from: 300,
                                    delay: 300.ms,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                authenticationController
                                                        .passwordSignUpController
                                                        .text !=
                                                    value) {
                                              return "Password Not Matched";
                                            }
                                            return null;
                                          },
                                          controller: authenticationController
                                              .retypePasswordSignUpController,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: InputDecoration(
                                              hintText: 'Re-type password',
                                              prefixIcon: SizedBox(
                                                width: 60,
                                                height: 57,
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AppColors.primary,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        topLeft:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: const Icon(
                                                      CupertinoIcons.lock,
                                                      size: 25,
                                                      color: AppColors.white,
                                                    )),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    width: .5,
                                                    color: AppColors.primary),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: .1,
                                                      color: AppColors.primary
                                                          .withOpacity(.5)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              hintStyle: AppTextStyles.boldstyle
                                                  .copyWith(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16))),
                                    ),
                                  )
                                : const Center();
                      }),
                      Obx(() => authenticationController.timelineIndex.value ==
                              3
                          ? FadeIn(
                              delay: 300.ms,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Cart Details",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Company: ${"${authenticationController.firstNameController.text} ${authenticationController.lastNameController.text}"}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Zip Code : ${authenticationController.zipCodeController.text}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Location: ${"${authenticationController.selectDivision.value == null ? "" : authenticationController.selectDivision.value!.name!} ${authenticationController.selectDistrict.value == null ? "" : authenticationController.selectDistrict.value!.name!}"}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 16),
                                  const SizedBox(height: 15),
                                  const Text(
                                    "Your Details",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Name: ${"${authenticationController.firstNameController.text} ${authenticationController.lastNameController.text}"}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "E-mail: ${authenticationController.emailSignUpController.text}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Phone number: ${authenticationController.phoneSignUpController.text}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 16),
                                  const SizedBox(height: 15),
                                  const Text(
                                    "Payment Details",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Cart number: ${authenticationController.cartNumberController.text}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Payment Method: ${authenticationController.selectPaymentType.value ?? ''}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Subscriptions:  ${authenticationController.selectSubscription.value ?? ''}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 16)
                                ],
                              ),
                            )
                          : const Center()),
                      const SizedBox(height: 15),
                      Center(child: Obx(() {
                        return OutlinedButton(
                          onPressed: () {
                            if (authenticationController.timelineIndex.value >
                                2) {
                              _signUpUser(authenticationController, context);
                              return;
                            } else {
                              if(authenticationController.timelineIndex.value==2){
                                if(authenticationController.selectPaymentType.value==null || authenticationController.selectSubscription.value==null) {
                                  showErrorDialogInTop("Warning",
                                    "Please Select Payment Method & Subscriptions", context);
                                  return;
                                }

                              }
                              if (authenticationController
                                      .selectDistrict.value ==
                                  null) {
                                showErrorDialogInTop("Warning",
                                    "Please Select Location", context);
                                return;
                              }
                              if (authenticationController
                                  .signupFromKey.currentState!
                                  .validate()) {
                                authenticationController.timelineIndex.value++;
                              }
                            }
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  authenticationController.timelineIndex.value >
                                          2
                                      ? AppColors.primary
                                      : null,
                              side: authenticationController
                                          .timelineIndex.value >
                                      2
                                  ? BorderSide.none
                                  : const BorderSide(color: AppColors.white),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15)),
                          child: Text(
                            authenticationController.timelineIndex.value > 2
                                ? "Create Account"
                                : "Next ",
                            style: AppTextStyles.boldstyle.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        );
                      })),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.offAll(const LoginScreen(),
                              curve: Curves.bounceInOut,
                              transition: Transition.upToDown);
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
        ),
      ),
    );
  }

  void _signUpUser(
      AuthenticationController authenticationController, BuildContext context) {
    authenticationController.signUpUser(context);
  }
}
