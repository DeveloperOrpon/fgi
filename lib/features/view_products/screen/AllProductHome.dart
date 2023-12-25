import 'dart:developer';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/view_products/component/FilterProducts.dart';
import 'package:fgi_y2j/features/view_products/screen/AllProductHome.dart';
import 'package:fgi_y2j/features/view_products/component/single_product_ui.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:fgi_y2j/features/view_products/screen/AllProductListScreen.dart';
import 'package:fgi_y2j/features/view_products/screen/filterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/text_style.dart';
import '../../Category_Brand/Model/CategoryByProductRes.dart';
import '../../Category_Brand/Screen/CategoryByProductScreen.dart';
import '../../dashboard/Component/dashDrawer.dart';
import '../../notification/controller/notificationController.dart';
import '../../search_product/screen/search_screen.dart';
import 'TabScreen.dart';

class AllProductsHome extends StatefulWidget {
  const AllProductsHome({Key? key}) : super(key: key);

  @override
  State<AllProductsHome> createState() => _AllProductsHomeState();
}

class _AllProductsHomeState extends State<AllProductsHome> {
  @override
  Widget build(BuildContext context) {
    final controller1 = ScrollController();
    final notificationController = Get.put(AppNotificationController());
    final allProductController = Get.put(AllProductController());
    final categoryController = Get.put(CategoryController());
    final cartController = Get.put(CartController());
    return Obx(() {
      return DefaultTabController(
        length: categoryController.allCategoryList.value.length,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(FilterScreen(), transition: Transition.fadeIn);
            },
            child: Icon(Icons.filter_alt_rounded),
          ),
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            backgroundColor: Colors.transparent,
            title: Text("Products"),
            actions: [
              Obx(() {
                return IconButton(
                    onPressed: () {
                      allProductController.isListAllProduct.value =
                          !allProductController.isListAllProduct.value;
                    },
                    icon: allProductController.isListAllProduct.value
                        ? const Icon(
                            CupertinoIcons.square_grid_2x2,
                            color: Colors.black,
                          )
                        : const Icon(
                            CupertinoIcons.list_bullet_below_rectangle));
              }),
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
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: () {
                          AppRoute().cartPage();
                        },
                        icon: const Icon(
                          CupertinoIcons.shopping_cart,
                          color: Colors.black,
                        )),
                  ),
                  Obx(() {
                    return cartController.cartItems.value.isNotEmpty
                        ? Positioned(
                            top: 0,
                            right: 5,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.red,
                              child: Center(
                                child: Text(
                                  "${cartController.cartItems.length}",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          )
                        : Center();
                  })
                ],
              )
            ],
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: Obx(() {
                  return TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.black87,
                    indicatorColor: AppColors.primary,
                    tabs: categoryController.allCategoryList.value
                        .map((e) => Tab(
                              child: Text('${e.categoryLabel}'),
                            ))
                        .toList(),
                  );
                })),
          ),
          body: Obx(() {
            return TabBarView(
              children: categoryController.allCategoryList.value
                  .map((e) => CategoryProductTabScreen(
                        categoryName: e.categoryLabel ?? "",
                      ))
                  .toList(),
            );
          }),
        ),
      );
    });
  }
}
