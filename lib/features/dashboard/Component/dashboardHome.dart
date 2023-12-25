import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/Api/Interceptors/OfflineInterceptor.dart';

import 'package:fgi_y2j/config/config.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/BrandRes.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/CategoryRes.dart';
import 'package:fgi_y2j/features/notification/controller/notificationController.dart';
import 'package:fgi_y2j/features/order/controller/orderController.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import '../../Category_Brand/Controller/CategoryController.dart';
import '../../Category_Brand/Screen/AllBrandPage.dart';
import '../../Category_Brand/Screen/AllCategoryListScreen.dart';
import '../../Category_Brand/Screen/BrandCatProduct.dart';
import '../../Category_Brand/Screen/CategoryByProductScreen.dart';
import '../../Category_Brand/Controller/CategoryController.dart';
import '../../Dialog/Authentication_Message.dart';
import '../../order/screen/AcceptOrdersScreen.dart';
import '../../order/screen/CancelOrdersScreen.dart';
import '../../order/screen/CompleteOrdersScreen.dart';
import '../../order/screen/PendingOrdersScreen.dart';
import '../../product_details/details_screen.dart';
import '../../search_product/screen/search_screen.dart';
import '../../view_products/Model/Product.dart';
import '../../view_products/component/SingleProductListUI.dart';
import '../../view_products/component/single_product_ui.dart';
import '../../view_products/screen/AllProductHome.dart';
import '../../view_products/screen/AllProductListScreen.dart';
import '../controller/dashboardController.dart';

String catDemo =
    "https://www.insidevancouver.ca/wp-content/uploads/2022/07/Praguery7-664x830.jpeg";

class DashboardHome extends StatelessWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.put(DashBoardController());
    final notificationController = Get.put(AppNotificationController());
    final orderController = Get.put(OrderController());
    final allProductController = Get.put(AllProductController());
    final categoryController = Get.put(CategoryController());
    final RefreshController refreshController = RefreshController(initialRefresh: false);

    return SmartRefresher(
      physics: const BouncingScrollPhysics(),
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(
        waterDropColor: AppColors.primary,
        refresh: CupertinoActivityIndicator(color:  AppColors.black,radius: 15,),
      ),
      footer: CustomFooter(
        builder: (context, mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  const Text("Pull up load");
          }
          else if(mode==LoadStatus.loading){
            body =  const CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = const Text("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
            body = const Text("release to load more");
          }
          else{
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      controller: refreshController,
      onRefresh: () async {
        printLog("onRefresh");
        await  DataCacheService.removeAllLocalData();
        categoryController.brandPage=1;
        categoryController.categoryPage=1;
        categoryController.categoryList.value=[];
        categoryController.brandList.value=[];
        await categoryController.getAllBrands();
        await  categoryController.getCategories();
        allProductController.allProduct.value=[];
        allProductController.allProductPage=1;
        await allProductController. getAllProduct();
        orderController.pendingOrderList.value=[];
        orderController.completedOrderList.value=[];
        orderController.acceptOrderList.value=[];
        orderController.pendingOrderInformation(1);
        orderController.completedOrderInformation(1);
        orderController.acceptOrderInformation(1);
        notificationController.page=1;
        notificationController.getNotification();
        refreshController.refreshCompleted();

      },
      onLoading: () {
        allProductController.allProductPage++;;
        allProductController.getAllProduct();
        Future.delayed(Duration(seconds: 3),(){
          refreshController.loadComplete();
        });
      },
    ///comment Remove
    child: CustomScrollView(
        controller: dashBoardController.homeScrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            InkWell(
              onTap: () {
                Get.to(const SearchScreen(), transition: Transition.fadeIn);
              },
              child: IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0,right: 12),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      hintText: "Search Product",
                      hintStyle:
                           GoogleFonts.robotoMono(color: Colors.grey, fontSize: 14),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                ),
              ),
            )
          ])),

          ///order summery
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Summery",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        dashBoardController.selectDrawerIndex.value = 1;
                        dashBoardController.pageController.animateToPage(
                            dashBoardController.selectDrawerIndex.value,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutExpo);
                      },
                      child: Text(
                        "See All",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 95,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  FadeInLeft(
                    duration: 300.ms,
                    child: InkWell(
                      onTap: () {
                        Get.to(const AcceptOrdersScreen(),transition: Transition.upToDown);
                      },
                      child: Container(
                        margin: EdgeInsets.all(6),
                        height: 100,
                        width: Get.width*.28,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(14),
                              bottomLeft: Radius.circular(14)
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Orders",
                            style:    AppTextStyles.summeryTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Accept",
                                  style: AppTextStyles.summeryTextStyle,
                                ),

                              ],
                            ),
                        Padding(
                          padding: EdgeInsets.only(top: 3,bottom: 3),
                          child: Obx((){
                            return Text(
                              "${orderController.acceptOrderResponse.value==null?"0":orderController.acceptOrderResponse.value!.meta!.totalOrders}",
                              style: AppTextStyles.summeryTextStyle
                                  .copyWith(fontSize: 18),
                            );
                          }),
                        )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const PendingOrderScreen(),
                          transition: Transition.upToDown);
                    },
                    child: FadeInLeft(
                      duration: 300.ms,
                      delay: 300.ms,
                      child: Container(
                        margin: EdgeInsets.all(6),
                        height: 100,
                        width: Get.width*.28,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            bottomRight: Radius.circular(14)
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Pending",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Text(
                              "Orders",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Obx((){
                                return Text(
                                  "${orderController.pendingOrderResponse.value==null?"0":orderController.pendingOrderResponse.value!.meta!.totalOrders}",
                                  style: AppTextStyles.summeryTextStyle
                                      .copyWith(fontSize: 18),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const CompleteOrderScreen(),
                          transition: Transition.upToDown);
                    },
                    child: FadeInLeft(
                      duration: 300.ms,
                      delay: 600.ms,
                      child: Container(
                        margin: EdgeInsets.all(6),
                        height: 100,
                        width: Get.width*.28,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(14),
                              bottomLeft: Radius.circular(14)
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Completed",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Text(
                              "Orders",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Obx(() {
                                return Text(
                                  "${orderController.completedOrderList.length}",
                                  style: AppTextStyles.summeryTextStyle
                                      .copyWith(fontSize: 18),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const CancelOrdersScreen(),
                          transition: Transition.upToDown);
                    },
                    child: FadeInLeft(
                      duration: 300.ms,
                      delay: 600.ms,
                      child: Container(
                        margin: EdgeInsets.all(6),
                        height: 100,
                        width: Get.width*.28,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              bottomRight: Radius.circular(14)
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Cancel",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Text(
                              "Orders",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Obx(() {
                                return Text(
                                  orderController.cancelOrderResponse.value==null?"00":"${orderController.cancelOrderResponse.value!.meta!.totalOrders}",
                                  style: AppTextStyles.summeryTextStyle
                                      .copyWith(fontSize: 18),
                                );
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ])),

          ///product category
          SliverList(
              delegate: SliverChildListDelegate([

            InkWell(
              onTap: () {
                Get.to(AllCategoryListScreen(),transition: Transition.upToDown);
              },
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Categories",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "See All",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  )),
            ),
          ])),
          Obx(
            () => categoryController.categoryList.isEmpty
                ? SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 120,
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
                            child: Opacity(
                                opacity: .1, child: const Text(appName)),
                          ),

                        ],
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(
                              color: Colors.white,
                              duration: 700.ms,
                              delay: 700.ms);
                    },
                    itemCount: demoCategories.length,
                  )
                : SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 120,
                            mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      CategoryModel categoryModel =
                          categoryController.categoryList[index];
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
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  height: 150,
                                  width: Get.width * .4,
                                  fit: BoxFit.cover,
                                  imageUrl: categoryModel.image ?? '',
                                  errorWidget: (context, url, error) => Center(
                                    child: Text(
                                      "$appName",
                                      style: TextStyle(
                                          color: Colors.grey.shade400),
                                    ),
                                  ),
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const SpinKitFoldingCube(
                                    color: AppColors.primary,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.primary, width: .5),
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
                              margin: const EdgeInsets.only(bottom: 15),
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                categoryModel.categoryLabel ?? 'No Name',
                                style: AppTextStyles.summeryTextStyle.copyWith(
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4,left: 4),
                              width: 40,
                              padding: EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: const Text(
                                textAlign: TextAlign.center,
                                "NEW",
                                style: TextStyle(fontSize: 10, color: Colors.white),
                              ),
                            ).animate(onPlay: (controller) => controller.repeat(),).shake(duration: 600.ms,hz: 1,delay: 4000.ms),
                          ],
                        ),
                      ).animate().blurXY(begin: 5, end: 0);
                    },
                    itemCount:
                        categoryController.categoryList.length.isGreaterThan(6)
                            ? 6
                            : categoryController.categoryList.length,
                  ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            TextButton(
              onPressed: () {
                Get.to(const AllCategoryListScreen(),
                    transition: Transition.upToDown);
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Center(
                  child: Text("More Categories",
                      style: TextStyle(decoration: TextDecoration.underline))),
            ),
          ])),

          ///Brand information
          SliverList(
              delegate: SliverChildListDelegate([
            InkWell(
              onTap: () {
                // Get.to(const AllBrandScreen(), transition: Transition.upToDown);
              },
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Company",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      // Text(
                      //   "See All",
                      //   style: AppTextStyles.drawerTextStyle.copyWith(
                      //       fontSize: 18,
                      //       color: Colors.grey,
                      //       fontWeight: FontWeight.normal,
                      //       decoration: TextDecoration.underline),
                      // ),
                    ],
                  )),
            ),
                SizedBox(height: 5,)

          ])),
          Obx(
            () => categoryController.brandList.isEmpty
                ? SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 80,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(),
                            alignment: Alignment.center,
                            child: const Opacity(
                                opacity: .1, child: Text(appName)),
                          )
                        ],
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(
                              color: Colors.white,
                              duration: 700.ms,
                              delay: 700.ms);
                    },
                    itemCount: demoCategories.length,
                  )
                : SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 80,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      BrandModel brandModel =
                          categoryController.brandList[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            right: (index+1) % 3 == 0 ? 8.0 : 0,
                            left: index== 0 || index == 3 ? 8 : 0),

                        child: InkWell(
                          onTap: () {
                            // Get.to(const AllBrandScreen(),
                            //     transition: Transition.upToDown);
                            Get.to(
                                BrandCatProduct(
                                  brandModel: brandModel,
                                ),
                                transition: Transition.upToDown);
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    height: 80,
                                    width: Get.width * .4,
                                    fit: BoxFit.fill,
                                    imageUrl: brandModel.brandImage ?? '',
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: Text(
                                        "$appName",
                                        style: TextStyle(
                                            color: Colors.grey.shade400),
                                      ),
                                    ),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            const SpinKitFoldingCube(
                                      color: AppColors.primary,
                                      size: 50.0,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.primary, width: .5),
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
                                margin: const EdgeInsets.only(bottom: 5),
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  brandModel.brandLabel ?? 'No Name',
                                  style: AppTextStyles.summeryTextStyle
                                      .copyWith(
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12),
                                ),
                              ),
                              Container(
                                width: 40,
                                padding: EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: const Text(
                                  textAlign: TextAlign.center,
                                  "NEW",
                                  style: TextStyle(fontSize: 10, color: Colors.white),
                                ),
                              ).animate(onPlay: (controller) => controller.repeat(),).shake(duration: 600.ms,hz: 1,delay: 4000.ms)
                            ],
                          ),
                        ).animate().blurXY(begin: 5, end: 0),
                      );
                    },
                    itemCount:
                        categoryController.brandList.length.isGreaterThan(6)
                            ? 6
                            : categoryController.brandList.length,
                  ),
          ),
          // SliverList(
          //     delegate: SliverChildListDelegate([
          //   TextButton(
          //     onPressed: () {
          //       Get.to(const AllBrandScreen(), transition: Transition.upToDown);
          //     },
          //     style: TextButton.styleFrom(padding: EdgeInsets.zero),
          //     child: const Center(
          //         child: Text("More Brands",
          //             style: TextStyle(decoration: TextDecoration.underline))),
          //   ),
          // ])),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Product",
                          style: AppTextStyles.drawerTextStyle.copyWith(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const AllProductsHome(),transition: Transition.fadeIn );
                          },
                          child: Text("See All",
                              style: AppTextStyles.drawerTextStyle.copyWith(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline)),
                        )
                      ]))
            ],
          )),
          Obx(() {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _productUI(
                    context,
                    allProductController.allProduct.value[index],
                    allProductController),
                childCount:  allProductController.allProduct.value.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 300,
              ),
            );
          })

          // ),
        ]));
  }

  InkWell _productUI(BuildContext context, ProductModel productModel,
      final AllProductController allProductController) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(productModel: productModel),
            transition: Transition.fadeIn);
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 250,
        width: Get.width * .5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(2, 2),
              )
            ]),
        child: Stack  (
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 110,
                      fit: BoxFit.cover,
                      width: Get.width * .5,
                      imageUrl: productModel.productImage!=null ?productModel.productImage!:
                          productModel.fetImage==null || productModel.fetImage!.isEmpty?"":productModel.fetImage![0] ??
                          "",
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: AppColors.primary, width: .5)),
                        child: Center(
                          child: Text(
                            "$appName",
                            style: TextStyle(color: Colors.grey.shade200),
                          ),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const SpinKitFoldingCube(
                        color: AppColors.primary,
                        size: 50.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(left:5),
                  child: Text(
                    "${productModel.name?.trim()}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(color: Colors.black, fontSize: 15),
                  ),
                ),
            Row(
              children: [
                Container(

                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      "Category",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text("${productModel.categoryName}",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      )),
                ),
              ],
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Center(
                      child: Text(
                        "Company",
                        style: GoogleFonts.robotoMono(
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text("${productModel.brandName}",
                        style: GoogleFonts.robotoMono(
                          fontSize: 9,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      "Unit",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text("${productModel.productUnitType}",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      )),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      "Price",
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
                if(num.parse(productModel.discount.toString())>0)Text(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              showSuccessToastTop(
                                  "Information", "Product Added To cart", context);
                              allProductController
                                  .addToCartProduct(productModel)
                                  .then((value) {
                                if (!value) {
                                  showErrorDialogInTop(
                                      "Warning",
                                      "Something Error When Product Added To Cart",
                                      context);
                                }
                              });
                            },
                            child: const Text("Add To Cart")),
                      ),
                    ],
                  ),
                )
              ],
            ),
            if(num.parse(productModel.discount.toString())>0)Container(
              width: 40,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(2),
              decoration: const BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Text(
                textAlign: TextAlign.center,
                "-${productModel.discount}%",
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
