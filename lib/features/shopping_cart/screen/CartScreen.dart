import 'dart:developer';

import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/notification/screen/NotificationScreen.dart';
import 'package:fgi_y2j/features/shopping_cart/component/CartItemsListUi.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/shopping_cart/screen/place_picker.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/text_style.dart';
import '../../dashboard/screen/DashboardScreen.dart';
import '../../notification/controller/notificationController.dart';
import '../component/CartProductUi.dart';
import '../model/CartRes.dart';
import 'MapScreen.dart';
import 'checkoutScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final dateTimeController = TextEditingController();

  final notificationController = Get.put(AppNotificationController());
  bool isShowGrid = true;
  final cartController = Get.put(CartController());
  final allController = Get.put(AllProductController());
  final authController = Get.put(AuthenticationController());
  DateTime dt = DateTime.now();
  String? pickDate;
  String? pickTime;

  intMethod() async {
    cartController.additionalController.text = '';
    cartController.getAllCartProduct(authController.userModel.value!);
    cartController.addressController.text =
        authController.currentAddress.value.isEmpty
            ? authController.userModel.value!.location ?? ""
            : authController.currentAddress.value;
    super.initState();
    if (authController.currentAddress.value == '') {
      await authController.getCurrentLocation();
    }
  }

  @override
  void initState() {
    intMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.transparent,
        title: const Text("My Cart"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    AppRoute().notificationScreen();
                  },
                  icon: const Icon(
                    CupertinoIcons.bell,
                    color: Colors.black,
                  )),
              Obx(() {
                return notificationController.countUnRead().isGreaterThan(0)
                    ? Positioned(
                        top: 0,
                        right: 5,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Center(
                            child: Text(
                              "${notificationController.countUnRead()}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      )
                    : Center();
              })
            ],
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_sharp,
                color: Colors.amber,
              ))
        ],
      ),
      body: SmartRefresher(
        physics: const BouncingScrollPhysics(),
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(
          waterDropColor: AppColors.primary,
          refresh: CupertinoActivityIndicator(
            color: AppColors.black,
            radius: 15,
          ),
        ),
        footer: CustomFooter(
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("--End Page--");
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = const Text("No more Data");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: cartController.refreshCartController,
        onRefresh: () {
          printLog("onRefresh");
          cartController.onRefreshCartPage();
          setState(() {});
        },
        onLoading: () {
          printLog("onLoading");
          cartController.onLoadingCartPage();
          setState(() {});
        },
        child: Obx(() {
          return cartController.cartRes.value != null &&
                  cartController.cartItems.value.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Lottie.asset('assets/animation/no_product_cart.json'),
                      const Text(
                        "Cart is Empty",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        "Please add some product and try again",
                        style: TextStyle(fontSize: 12),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.offAll(
                              const DashboardScreen(),
                              transition: Transition.cupertino,
                            );
                          },
                          child: const Text(
                            "Continue Shopping",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                )
              : CustomScrollView(
                  shrinkWrap: true,
                  controller: cartController.cartHomeScrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Products",
                                style: AppTextStyles.drawerTextStyle.copyWith(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShowGrid = !isShowGrid;
                                  });
                                },
                                icon: Icon(
                                    !isShowGrid? CupertinoIcons.rectangle_grid_2x2_fill:CupertinoIcons.list_bullet_indent),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: InkWell(
                          onTap: () async {
                            startLoading('');
                            await cartController.removeHoleCart(
                                authController.userModel.value!.email ?? "");
                            cartController.cartItems.value = [];
                            // cartController.getAllCartProduct(authController.userModel.value!);
                            EasyLoading.dismiss();
                          },
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.delete_right_fill,
                                  color: AppColors.red),
                              SizedBox(width: 5),
                              const Text(
                                'Clear All Items',
                                style: TextStyle(
                                    color: AppColors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Obx(() => cartController.cartRes.value == null
                          ? Lottie.asset("assets/animation/loadingScreen.json")
                          : const Center())
                    ])),
                    isShowGrid
                        ? SliverGrid.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return CartProductUi(
                                  index: index,
                                  cartModel:
                                      cartController.cartItems.value[index]);
                            },
                            itemCount: cartController.cartItems.value.length,
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) => CartItemListUi(
                                    index: index,
                                    cartModel:
                                        cartController.cartItems.value[index]),
                                childCount:
                                    cartController.cartItems.value.length)),
                    // SliverList(
                    //     delegate: SliverChildListDelegate([
                    //   const SizedBox(height: 20),
                    //   Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           vertical: 8.0, horizontal: 14),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             "Pick Date and Time",
                    //             style: AppTextStyles.drawerTextStyle.copyWith(
                    //                 fontSize: 20,
                    //                 color: Colors.black,
                    //                 fontWeight: FontWeight.w500),
                    //           ),
                    //         ],
                    //       )),
                    // ])),
                    // SliverList(
                    //     delegate: SliverChildListDelegate([
                    //   Padding(
                    //     padding: const EdgeInsets.all(12.0),
                    //     child: TextFormField(
                    //       controller: dateTimeControlller,
                    //       enabled: false,
                    //       decoration: InputDecoration(
                    //         suffixIcon: const Icon(
                    //           Icons.calendar_month,
                    //           size: 30,
                    //         ),
                    //         hintText: "DD-MM-YYYY",
                    //         hintStyle: const TextStyle(
                    //             color: Colors.grey, fontSize: 16),
                    //         filled: true,
                    //         fillColor: Colors.grey.shade200,
                    //       ),
                    //     ),
                    //   )
                    // ])),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                            border: Border.all(
                                color: Colors.grey.shade200, width: 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 5,
                                  offset: Offset(3, 3),
                                  blurRadius: 5)
                            ],
                            borderRadius: BorderRadius.circular(8)),
                        child: DateTimePicker(
                          initialSelectedDate: dt,
                          startDate: dt,
                          endDate: dt.add(const Duration(days: 60)),
                          startTime: DateTime(dt.year, dt.month, dt.day, 0),
                          endTime: DateTime(dt.year, dt.month, dt.day, 23),
                          timeInterval: const Duration(minutes: 60),
                          datePickerTitle: 'Pick-up Date',
                          timePickerTitle: 'Pick-up Time',
                          timeOutOfRangeError: 'Sorry is not available',
                          is24h: false,
                          onDateChanged: (date) {
                            log("Pick Date : $date");
                            pickDate = DateFormat('E, d MMM, y').format(date);
                          },
                          onTimeChanged: (time) {
                            pickTime = DateFormat('hh:mm:ss aa').format(time);
                          },
                        ),
                      )
                    ])),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      const SizedBox(height: 20),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Additional Instructions",
                                style: AppTextStyles.drawerTextStyle.copyWith(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                    ])),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cartController.additionalController,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 16),
                          minLines: 8,
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText: "Type Here Additional Instructions",
                            hintStyle: const TextStyle(
                                color: Colors.black38, fontSize: 16),
                            helperText: "Type Here Max 200 Characters",
                            filled: true,
                            fillColor: Colors.grey.shade300,
                          ),
                        ),
                      )
                    ])),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.all(4),
                            width: Get.width * .4,
                            decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: const Center(
                              child: Text(
                                'Your Current Address',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      IgnorePointer(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 2,
                            color: AppColors.primary,
                          )),
                          child: const SizedBox(
                            height: 150,
                            child: MapScreen(),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Full Address Information",
                                style: AppTextStyles.drawerTextStyle.copyWith(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    Get.to(const PlacePicker(
                                        "AIzaSyDyY3eKda8jkxg76meC_MFq5C8f4vhQPow"));
                                  },
                                  child: const Text("Address Search")),
                            ],
                          )),
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Current Address :${authController.currentAddress.value}",
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cartController.addressController,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 16),
                          minLines: 3,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "Type Your Full Address",
                            hintStyle: const TextStyle(
                                color: Colors.black38, fontSize: 16),
                            helperText: "Type Here Max 100 Characters",
                            filled: true,
                            fillColor: Colors.grey.shade300,
                          ),
                        ),
                      ),
                     if(!isCheckOutButton(cartController.cartItems.value??[])) Obx(() {
                         return SizedBox(
                            height: 60,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size.fromWidth(Get.width*.6)
                                  ),
                                  // color: Colors.green ,
                                    // style: OutlinedButton.styleFrom(
                                    //     backgroundColor: Colors.green,
                                    //     side: const BorderSide(
                                    //         color: AppColors.primary)),
                                    onPressed:!cartController.startIncrease.value? () {
                                      if (pickTime == null || pickDate == null) {
                                        log("Pick : $pickDate -- $pickTime");
                                        showSuccessToastTop(
                                            "Warning",
                                            "Please Select Pick Date And Time",
                                            context);
                                        return;
                                      }
                                      Get.to(
                                              CheckoutScreen(
                                                pickDate: pickDate ?? "",
                                                pickTime: pickTime ?? "",
                                              ),
                                              transition: Transition.upToDown)!
                                          .then((value) {
                                        cartController.cartHomeScrollController
                                            .jumpTo(00);
                                        if (value != null) {
                                          cartController.cartHomeScrollController
                                              .animateTo(
                                                  cartController
                                                      .cartHomeScrollController
                                                      .position
                                                      .maxScrollExtent,
                                                  duration:
                                                      const Duration(seconds: 1),
                                                  curve: Curves.linearToEaseOut);
                                        }
                                      });
                                    }:null,
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Checkout",
                                        style: TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          );
                       }
                     ),
                      const SizedBox(height: 60)
                    ])),
                  ],
                );
        }),
      ),
    );
  }
  isCheckOutButton(List<CartModel> cartItems){
    final value=cartItems.where((element) => element.isCheck).toList();
    return value.isEmpty;
  }

}
