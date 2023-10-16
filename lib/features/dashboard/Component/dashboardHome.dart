import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/config/config.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/BrandRes.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/CategoryRes.dart';
import 'package:fgi_y2j/features/order/controller/orderController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import '../../Category_Brand/Controller/CategoryController.dart';
import '../../Category_Brand/Screen/AllBrandPage.dart';
import '../../Category_Brand/Screen/AllCategoryListScreen.dart';
import '../../Category_Brand/Screen/CategoryByProductScreen.dart';
import '../../Category_Brand/Controller/CategoryController.dart';
import '../../order/screen/CompleteOrdersScreen.dart';
import '../../order/screen/PendingOrdersScreen.dart';
import '../../search_product/screen/search_screen.dart';
import '../controller/dashboardController.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String catDemo =
        "https://www.insidevancouver.ca/wp-content/uploads/2022/07/Praguery7-664x830.jpeg";
    final dashBoardController = Get.put(DashBoardController());
    final orderController = Get.put(OrderController());
    final categoryController = Get.put(CategoryController());
    // return SmartRefresher(
    //   physics: const BouncingScrollPhysics(),
    //   enablePullDown: true,
    //   enablePullUp: true,
    //   header: const WaterDropHeader(
    //     waterDropColor: AppColors.primary,
    //     refresh: CupertinoActivityIndicator(color:  AppColors.black,radius: 15,),
    //   ),
    //   footer: CustomFooter(
    //     builder: (context, mode){
    //       Widget body ;
    //       if(mode==LoadStatus.idle){
    //         body =  const Text("Pull up load");
    //       }
    //       else if(mode==LoadStatus.loading){
    //         body =  const CupertinoActivityIndicator();
    //       }
    //       else if(mode == LoadStatus.failed){
    //         body = const Text("Load Failed!Click retry!");
    //       }
    //       else if(mode == LoadStatus.canLoading){
    //         body = const Text("release to load more");
    //       }
    //       else{
    //         body = const Text("No more Data");
    //       }
    //       return SizedBox(
    //         height: 55.0,
    //         child: Center(child:body),
    //       );
    //     },
    //   ),
    //   controller: dashBoardController.refreshController,
    //   onRefresh: () {
    //     printLog("onRefresh");
    //     dashBoardController.onRefreshPage();
    //   },
    //   onLoading: () {
    //     printLog("onLoading");
    //     dashBoardController.onLoadingPage();
    //   },
    ///comment Remove
    return CustomScrollView(
      controller: dashBoardController.homeScrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          InkWell(
            onTap: () {
              Get.to(const SearchScreen(), transition: Transition.fadeIn);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                  filled: true,
                  fillColor: Colors.grey.shade200,
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
          Row(
            children: [
              Expanded(
                child: FadeInLeft(
                  duration: 300.ms,
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Total Orders",
                          style: AppTextStyles.summeryTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "(Today)",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            PullDownButton(
                              itemBuilder: (context) => [
                                PullDownMenuItem.selectable(
                                  onTap: () {},
                                  selected: true,
                                  title: 'Today',
                                  icon: CupertinoIcons.circle_fill,
                                  iconColor: CupertinoColors.systemGreen
                                      .resolveFrom(context),
                                ),
                                PullDownMenuItem.selectable(
                                  onTap: () {},
                                  selected: false,
                                  title: 'Tomorrow',
                                  icon: CupertinoIcons.circle_fill,
                                  iconColor: CupertinoColors.systemOrange
                                      .resolveFrom(context),
                                ),
                                PullDownMenuItem.selectable(
                                  onTap: () {},
                                  selected: false,
                                  title: 'Yesterday',
                                  icon: CupertinoIcons.circle_fill,
                                  iconColor: CupertinoColors.systemIndigo
                                      .resolveFrom(context),
                                )
                              ],
                              buttonBuilder: (context, showMenu) => InkWell(
                                onTap: showMenu,
                                child: const Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "30",
                          style: AppTextStyles.summeryTextStyle
                              .copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(const PendingOrderScreen(),
                        transition: Transition.upToDown);
                  },
                  child: FadeInLeft(
                    duration: 300.ms,
                    delay: 300.ms,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
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
                          Text(
                            "02",
                            style: AppTextStyles.summeryTextStyle
                                .copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(const CompleteOrderScreen(),
                        transition: Transition.upToDown);
                  },
                  child: FadeInLeft(
                    duration: 300.ms,
                    delay: 600.ms,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
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
                          Text(
                            "15",
                            style: AppTextStyles.summeryTextStyle
                                .copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ])),

        ///product category
        SliverList(
            delegate: SliverChildListDelegate([
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              dashBoardController.selectDrawerIndex.value = 2;
              dashBoardController.pageController.animateToPage(
                  dashBoardController.selectDrawerIndex.value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutExpo);
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          child:
                              Opacity(opacity: .1, child: const Text(appName)),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 150,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    CategoryModel categoryModel =
                        categoryController.categoryList[index];
                    return InkWell(
                      onTap: () {
                        Get.to(
                            CategoryByProductScreen(
                              categoryName: demoCategories[index]['name'],
                            ),
                            transition: Transition.upToDown);
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: 150,
                                width: Get.width * .3,
                                fit: BoxFit.cover,
                                imageUrl: categoryModel.image ?? '',
                                errorWidget: (context, url, error) =>
                                    CachedNetworkImage(
                                      height: 150,
                                      width: Get.width * .3,
                                      fit: BoxFit.cover,
                                      imageUrl: catDemo,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>const SpinKitFoldingCube(
                                            color: AppColors.primary,
                                            size: 50.0,
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
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
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
                              style: AppTextStyles.summeryTextStyle
                                  .copyWith(letterSpacing: .5,fontWeight: FontWeight.normal,fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ).animate().blurXY(begin:5,end: 0 );
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
        ]))  ,
        ///Brand information
        SliverList(
            delegate: SliverChildListDelegate([

          InkWell(
            onTap: () {
              Get.to(const AllBrandScreen(),transition: Transition.upToDown);
            },
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Brands",
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
          () => categoryController.brandList.isEmpty
              ? SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          child:
                              const Opacity(opacity: .1, child: Text(appName)),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 80,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    BrandModel brandModel=categoryController.brandList[index];
                    return Padding(
                      padding:  EdgeInsets.only(left:index%2!=0? 8.0:0,right: index%2==0 &&index!=0?8:0),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                              const AllBrandScreen(
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
                                  fit: BoxFit.cover,
                                  imageUrl: brandModel.brandImage ?? '',
                                  errorWidget: (context, url, error) =>
                                      CachedNetworkImage(
                                        height: 80,
                                        width: Get.width * .4,
                                        fit: BoxFit.cover,
                                        imageUrl: catDemo,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>const SpinKitFoldingCube(
                                              color: AppColors.primary,
                                              size: 50.0,
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
                                    .copyWith(letterSpacing: .5,fontWeight: FontWeight.normal,fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ).animate().blurXY(begin:5,end: 0 ),
                    );
                  },
                  itemCount:
                      categoryController.brandList.length.isGreaterThan(6)
                          ? 6
                          : categoryController.brandList.length,
                ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          TextButton(
            onPressed: () {
              Get.to(const AllBrandScreen(),
                  transition: Transition.upToDown);
            },
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: const Center(
                child: Text("More Brands",
                    style: TextStyle(decoration: TextDecoration.underline))),
          ),
              const SizedBox(height: 200,)
        ]))
      ],
      // ),
    );
  }
}
