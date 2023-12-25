import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/config.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import '../../dashboard/controller/dashboardController.dart';
import '../../notification/controller/notificationController.dart';
import '../../order/controller/orderController.dart';
import '../../search_product/screen/search_screen.dart';
import '../../view_products/controller/allProductController.dart';
import '../Model/CategoryRes.dart';
import 'CategoryByProductScreen.dart';

class AllCategoryListScreen extends StatelessWidget {
  const AllCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    final notificationController = Get.put(AppNotificationController());
    final orderController = Get.put(OrderController());
    final cartController = Get.put(CartController());
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Text("All Categories"),
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
                  body = const Text("Pull up load");
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
            controller: categoryController.allCategoryRefreshController,
            onRefresh: () {
              printLog("onRefresh");

              categoryController.onAllCategoryRefreshPage();
            },
            onLoading: () {
              categoryController.onAllCategoryLoadingPage();
            },

            ///comment Remove
            child: CustomScrollView(
                // controller: dashBoardController.homeScrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  ///product category

                  Obx(
                    () => categoryController.categoryList.isEmpty
                        ? SliverGrid.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 150,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade100,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    alignment: Alignment.center,
                                    child: const Opacity(
                                        opacity: .1, child: Text(appName)),
                                  )
                                ],
                              )
                                  .animate(
                                      onPlay: (controller) =>
                                          controller.repeat())
                                  .shimmer(
                                      color: Colors.white,
                                      duration: 700.ms,
                                      delay: 700.ms);
                            },
                            itemCount: demoCategories.length,
                          )
                        : Obx(() {
                            return SliverGrid.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: 150,
                                      mainAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                CategoryModel categoryModel = categoryController
                                    .categoryList.value[index];
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                        CategoryByProductScreen(
                                          categoryModel: categoryModel,
                                        ),
                                        transition: Transition.upToDown);
                                  },
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Hero(
                                            tag: '${categoryModel.image}',
                                            child: CachedNetworkImage(
                                              height: 150,
                                              width: Get.width * .3,
                                              fit: BoxFit.cover,
                                              imageUrl: categoryModel.image ?? '',
                                              errorWidget:
                                                  (context, url, error) => Center(
                                                child: Text(
                                                  "$appName",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade400),
                                                ),
                                              ),
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  const SpinKitFoldingCube(
                                                color: AppColors.primary,
                                                size: 50.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.primary,
                                                width: .5),
                                            gradient: const LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black,
                                                ],
                                                stops: [
                                                  .4,
                                                  1
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter)),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          categoryModel.categoryLabel ??
                                              'No Name',
                                          style: AppTextStyles.summeryTextStyle
                                              .copyWith(
                                                  letterSpacing: .5,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                ).animate().blurXY(begin: 5, end: 0);
                              },
                              itemCount:
                                  categoryController.categoryList.value.length,
                            );
                          }),
                  ),

                  // ),
                ])));
  }
}
