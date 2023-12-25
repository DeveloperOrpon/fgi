import 'dart:developer';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/config/config.dart';
import 'package:fgi_y2j/config/route.dart';
import 'package:fgi_y2j/config/style/text_style.dart';
import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/CategoryRes.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/common_component/simpleAppBar.dart';
import 'package:fgi_y2j/features/search_product/component/searchProductUi.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:fgi_y2j/features/view_products/screen/TabScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../Api/Interceptors/OfflineInterceptor.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/style/app_colors.dart';
import '../../notification/controller/notificationController.dart';
import '../../view_products/Model/ProductRes.dart';
import '../../view_products/component/SingleProductListUI.dart';
import '../../view_products/component/single_product_ui.dart';
import '../Model/CategoryByProductRes.dart';
import '../component/SingleProductUiWidget.dart';
import '../component/sort_multi_choice.dart';
import 'BrandCatSubCatProduct.dart';

class CategoryByProductScreen extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryByProductScreen({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  State<CategoryByProductScreen> createState() =>
      _CategoryByProductScreenState();
}

class _CategoryByProductScreenState extends State<CategoryByProductScreen> {
  final categoryController = Get.put(CategoryController());
  final notificationController = Get.put(AppNotificationController());
  final cartController = Get.put(CartController());
  final allProductController = Get.put(AllProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {},
      //     child: AnimateIcons(
      //       startIcon: Icons.filter_alt_sharp,
      //       endIcon: CupertinoIcons.xmark,
      //       size: 30.0,
      //       controller: categoryController.animation,
      //       onStartIconPress: () {
      //         categoryController.bottomBarController.openSheet();
      //
      //         return true;
      //       },
      //       onEndIconPress: () {
      //         categoryController.bottomBarController.closeSheet();
      //
      //         return true;
      //       },
      //       duration: const Duration(milliseconds: 500),
      //       startIconColor: Colors.white,
      //       endIconColor: Colors.white,
      //       clockwise: false,
      //     )),
      appBar: AppBar(
        title: Text(widget.categoryModel.categoryLabel ?? ''),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          Obx(() {
            return IconButton(
                onPressed: () {
                  allProductController.isListAllProduct.value =
                      !allProductController.isListAllProduct.value;
                },
                icon: categoryController.isListAllProduct.value
                    ? const Icon(
                        CupertinoIcons.square_grid_2x2,
                        color: Colors.black,
                      )
                    : const Icon(CupertinoIcons.list_bullet_below_rectangle));
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
      backgroundColor: Colors.white,
      body: CategoryProduct(categoryModel: widget.categoryModel),
    );
  }
}

class CategoryProduct extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryProduct({super.key, required this.categoryModel});

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  final RefreshController refreshPendingController =
      RefreshController(initialRefresh: false);
  bool initLoading = true;
  bool productLoadLoading = false;
  int page = 1;
  List<ProductModel> productList = [];
  ScrollController _scrollController = ScrollController();
  final categoryController = Get.put(CategoryController());
  final allProductController = Get.put(AllProductController());
  final authController = Get.put(AuthenticationController());
  int initialValue=1;
  @override
  void initState() {
    super.initState();
    loadCategory();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  loadCategory() {
    categoryController
        .getProductByCategory(widget.categoryModel.categoryLabel ?? "", page)
        .then((value) {
      productList.addAll(value!.data ?? []);
      setState(() {
        initLoading = false;
        productLoadLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return initLoading
        ? Lottie.asset('assets/animation/loadingScreen.json')
        : !initLoading && productList.isEmpty
            ? Lottie.asset('assets/animation/nodata.json')
            : Obx(() {
                return SmartRefresher(
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
                  controller: refreshPendingController,
                  onRefresh: () async {
                    printLog("onRefresh");
                    productList = [];
                    page = 1;
                    await DataCacheService.removeAllLocalData();
                    await loadCategory();
                    setState(() {});
                    refreshPendingController.refreshCompleted();
                  },
                  onLoading: () async {
                    printLog("onLoading");
                    page++;
                    await loadCategory();
                    refreshPendingController.loadComplete();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                            Hero(
                              tag: '${widget.categoryModel.image}',
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                imageBuilder: (context, imageProvider) => Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 140,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image:imageProvider ,fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomSlidingSegmentedControl<int>(
                                      initialValue: initialValue,
                                      children: {
                                        1: Text('All-Home'),
                                        2: Text('Sub-Category'),
                                        3: Text('All-Product'),
                                      },
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      thumbDecoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(.3),
                                            blurRadius: 4.0,
                                            spreadRadius: 1.0,
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInToLinear,
                                      onValueChanged: (v) {
                                        setState(() {
                                          initialValue=v;
                                        });
                                      },
                                    ),
                                  ),
                                ), imageUrl: '${widget.categoryModel.image}',
                              ),
                            ),
                            if(initialValue==1 || initialValue==2)  Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 4),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: Get.width*.4,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      )
                                    ),
                                    child: Text("Sub Category",style: GoogleFonts.roboto(color: AppColors.black,fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ).animate().slideX(),
                            )
                      ])),
                      if(initialValue==1 || initialValue==2)  SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisExtent: 120,
                                  mainAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            SubCategories subCategory =
                                widget.categoryModel.subCategories![index];
                            return InkWell(
                              onTap: () {
                                log("categoryModel${widget.categoryModel.toJson()  }");
                                log("subCategory${subCategory.slug  }");
                                // Get.to(
                                //     BrandCatSubCatProduct(
                                //       categoryName:
                                //           widget.categoryModel.categoryLabel ??
                                //               "",
                                //       brandSlug: authController
                                //               .userModel.value!.companySlug ??
                                //           "",
                                //       subCategory:
                                //           subCategory.slug ?? "",
                                //     ),
                                //     transition: Transition.upToDown);
                                Get.to(
                                    BrandCatSubCatProduct(
                                      categoryName: widget.categoryModel.categoryLabel ?? "",
                                      brandSlug:authController
                                                    .userModel.value!.companySlug??'',
                                      subCategory: subCategory.subcategoryName??"",
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
                                        imageUrl: subCategory.image ?? '',
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
                                    margin: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                    margin: const EdgeInsets.only(bottom: 15),
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      subCategory.subcategoryName ?? 'No Name',
                                      style: AppTextStyles.summeryTextStyle
                                          .copyWith(
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().blurXY(begin: 5, end: 0);
                          },
                          itemCount: (widget.categoryModel.subCategories ?? [])
                              .length),
                      if(initialValue==1 || initialValue==3)     SliverList(
                          delegate: SliverChildListDelegate([
                        const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 4),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: Get.width*.4,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        )
                                    ),
                                    child: Text("Category Product",style: GoogleFonts.roboto(color: AppColors.black,fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                            ).animate().slideX()
                      ])),
                      if(initialValue==1 || initialValue==3)   SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              allProductController.isListAllProduct.value
                                  ? 1
                                  : 2,
                          mainAxisExtent:
                              allProductController.isListAllProduct.value
                                  ? 125
                                  : 320,
                        ),
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          if (index < productList.length) {
                            return allProductController.isListAllProduct.value
                                ? SingleProductListUI(
                                    index: productList[index].categoryId ?? "",
                                    productModel: productList[index],
                                  )
                                : SingleProductUi(
                                    productModel: productList[index]);
                          } else {
                            return !productLoadLoading
                                ? const Center(
                                    child: CupertinoActivityIndicator(
                                      color: AppColors.primary,
                                    ),
                                  )
                                : const Center();
                          }
                        },
                      )
                    ],
                  ),
                );
              });
  }
}
