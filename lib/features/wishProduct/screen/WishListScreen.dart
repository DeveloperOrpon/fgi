import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/features/product_details/details_screen.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:fgi_y2j/features/wishProduct/controller/WishController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common_controller/AppController.dart';
import '../../../config/config.dart';
import '../../../config/route.dart';
import '../../../config/style/app_colors.dart';
import '../../dashboard/controller/dashboardController.dart';
import '../../notification/controller/notificationController.dart';
import '../../notification/screen/NotificationScreen.dart';
import '../../shopping_cart/controller/cartController.dart';
import '../../view_products/component/SingleProductListUI.dart';
import '../../view_products/controller/allProductController.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishController = Get.put(WishController());
    final appController = Get.put(AppController());
    final dashboardController = Get.put(DashBoardController());
    final allProductController = Get.put(AllProductController());
    final cartController = Get.put(CartController());
    final notificationController = Get.put(AppNotificationController());
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: !appController.haveConnection.value
              ? Size(Get.width, 25)
              : Size(0, 0),
          child: appController.haveConnection.value
              ? const Center()
              : Container(
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: const Text(
                    "No Internet",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.transparent,
        title: Text('Wish List'),
        actions: [
          Obx(() {
            return dashboardController.selectDrawerIndex.value == 2
                ? IconButton(
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
                            CupertinoIcons.list_bullet_below_rectangle))
                : const Center();
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
          controller: wishController.refreshController,
          onRefresh: () async {},
          onLoading: () {},

          ///comment Remove
          child: Obx(() => wishController.wishListProduct.value.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) => wishListTile(
                      wishController.wishListProduct.value[index],
                      wishController),
                  itemCount: wishController.wishListProduct.value.length,
                )
              : Center(
                  child: Text(
                    "No Product In Wish List",
                    style: GoogleFonts.robotoMono(color: Colors.grey),
                  ),
                ))),
    );
  }
}

Widget wishListTile(ProductModel productModel, WishController controller) {
  return InkWell(
    onTap: () {
      Get.to(ProductDetailsScreen(productModel: productModel));
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Container(
        height: 115,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(2, 6),
              color: Colors.white,
              blurRadius: 15,
              spreadRadius: 2)
        ]),
        child: Card(
          color: Colors.grey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: 80,
                          width: Get.width * .2,
                          fit: BoxFit.contain,
                          imageUrl: productModel.productImage ?? "",
                          errorWidget: (context, url, error) => Center(
                            child: Text(
                              "$appName",
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                          ),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const SpinKitFoldingCube(
                            color: AppColors.primary,
                            size: 20.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                maxLines: 2,
                                productModel.name ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 4, right: 5),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Category: ${productModel.categoryName ?? ''}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                              Row(
                                children: [
                                  if (num.parse(
                                          productModel.discount.toString()) >
                                      0)
                                    Text(
                                      "$currencySymbol ${productModel.price}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 14,
                                        color: Colors.grey,
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  Text(
                                    "  $currencySymbol ${productRegularPrice(productModel.price.toString(), productModel.discount.toString())}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.pink,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipPath(
                      clipper: MyClip(),
                      child: Container(
                        color: Colors.black54,
                        height: 200,
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.cart_fill,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          controller.removeOnWishList(productModel);
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                              )),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
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
