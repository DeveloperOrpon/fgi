import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/BrandRes.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/CategoryRes.dart';
import 'package:fgi_y2j/features/Category_Brand/Screen/CategoryByProductScreen.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/config.dart';
import '../../../config/route.dart';
import '../../../config/style/app_colors.dart';
import '../../notification/controller/notificationController.dart';
import '../../search_product/component/searchProductUi.dart';
import '../../view_products/Model/ProductRes.dart';
import '../Model/CategoryByProductRes.dart';
import 'BrandCatSubCatProduct.dart';
import 'BrandCategoryByProductScreen.dart';

class BrandCatProduct extends StatefulWidget {
  final BrandModel brandModel;

  const BrandCatProduct({super.key, required this.brandModel});

  @override
  State<BrandCatProduct> createState() => _BrandCatProductState();
}

class _BrandCatProductState extends State<BrandCatProduct> {
  List<ProductModel> brandProductList = [];
  ProductSearchRes? brandByProductRes;
  final categoryController = Get.put(CategoryController());
  final cartController = Get.put(CartController());
  final notificationController=Get.put(AppNotificationController());

  int page = 1;

  @override
  void initState() {
    intBrandCat();
    intBrandProduct(page);
    super.initState();
  }

  intBrandProduct(int page) {
    categoryController
        .getProductByBrand(widget.brandModel.brandSlug!, page)
        .then((value) {
      brandByProductRes = value;
      page++;
      if (brandByProductRes != null) {
        if (page == 1) {
          brandProductList = [];
        }
        brandProductList.addAll(brandByProductRes!.data ?? []);
        setState(() {});
      }
    });
  }

  List<CategoryModel> brandCategories = <CategoryModel>[];

  intBrandCat() {
    categoryController
        .getCategoriesByBrand(widget.brandModel.brandLabel!)
        .then((value) {
      setState(() {
        brandCategories = value;
      });
    });
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
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text("${widget.brandModel.brandLabel}"),
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
        controller: categoryController.refreshControllerBrand,
        onRefresh: () {
          setState(() {
            brandCategories = [];
            brandByProductRes = null;
            brandProductList = [];
          });
          page = 1;
          intBrandCat();
          intBrandProduct(page);
          Future.delayed(
            Duration(seconds: 1),
            () {
              categoryController.refreshControllerBrand.refreshCompleted();
            },
          );
        },
        onLoading: () async {
          page++;
          intBrandProduct(page);
          Future.delayed(
            Duration(seconds: 1),
            () {
              categoryController.refreshControllerBrand.loadComplete();
            },
          );
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                  top: 0,
                ),
                child: Text("Company Categories:"),
              ),
              Row(
                children: [
                  Container(
                    height: 2,
                    width: Get.width * .2,
                    color: AppColors.primary,
                    margin: EdgeInsets.only(left: 8, bottom: 10),
                  ),
                ],
              ),

              ///start cat
              ...brandCategories.map((e) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.primary, width: .1)),
                    child: ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.centerLeft,
                      collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side:
                              BorderSide(color: AppColors.primary, width: .5)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side:
                              BorderSide(color: AppColors.primary, width: .5)),
                      leading: Container(
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.primary, width: .5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            height: 110,
                            fit: BoxFit.cover,
                            width: 705,
                            imageUrl: e.image ?? "",
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.primary, width: .5)),
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
                              size: 25.0,
                            ),
                          ),
                        ),
                      ),
                      subtitle: Text(
                        "Company: ${widget.brandModel.brandLabel}",
                        style: TextStyle(fontSize: 10, color: Colors.black),
                      ),
                      trailing: Icon(CupertinoIcons.add),
                      title: Text(
                        "${e.categoryLabel}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      childrenPadding: EdgeInsets.symmetric(horizontal: 40),
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(
                                BrandCategoryByProductScreen(
                                  categoryName: e.categoryLabel ?? "",
                                  brandName: widget.brandModel.brandSlug??"",
                                ),
                                transition: Transition.upToDown);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColors.primary, width: .5)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 45,
                                      height: 45,
                                      imageUrl: e.image ?? "",
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.primary,
                                                width: .5)),
                                        child: Center(
                                          child: Text(
                                            "$appName",
                                            style: TextStyle(
                                              fontSize: 8,
                                                color: Colors.grey.shade200),
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              const SpinKitFoldingCube(
                                        color: AppColors.primary,
                                        size: 25.0,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "All Category Product",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Category: ${e.categoryLabel}",
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        if (e.subCategories != null &&
                            e.subCategories!.isNotEmpty)
                          ...e.subCategories!.map(
                            (s) => InkWell(
                              onTap: () {
                                Get.to(
                                    BrandCatSubCatProduct(
                                      categoryName: e.categoryLabel ?? "",
                                      brandSlug: widget.brandModel.brandSlug??"",
                                      subCategory: s.subcategoryName??"",
                                    ),
                                    transition: Transition.upToDown);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: AppColors.primary,
                                              width: .5)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width: 45,
                                          height: 45,
                                          imageUrl: s.image ?? "",
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: AppColors.primary,
                                                    width: .5)),
                                            child: Center(
                                              child: Text(
                                                "$appName",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                    color:
                                                        Colors.grey.shade200),
                                              ),
                                            ),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const SpinKitFoldingCube(
                                            color: AppColors.primary,
                                            size: 25.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Sub-Category: ${s.subcategoryName}",
                                            overflow: TextOverflow.fade,

                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Category: ${e.categoryLabel}",
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  )),

              ///end cat
              const Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                  top: 16,
                ),
                child: Text("Company Products:"),
              ),
              Row(
                children: [
                  Container(
                    height: 2,
                    width: Get.width * .2,
                    color: AppColors.primary,
                    margin: EdgeInsets.only(left: 8),
                  ),
                ],
              )
            ])),
            brandProductList.isEmpty && brandByProductRes == null
                ? SliverList(
                    delegate: SliverChildListDelegate([
                    const Center(
                      child: SpinKitFoldingCube(
                        color: AppColors.primary,
                        size: 50.0,
                      ),
                    )
                  ]))
                : brandProductList.isEmpty && brandByProductRes != null
                    ? SliverList(
                        delegate: SliverChildListDelegate([
                        Center(
                            child: Lottie.asset("assets/animation/nodata.json"))
                      ]))
                    : SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 270,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                        delegate: SliverChildBuilderDelegate(
                          childCount: brandProductList.length,
                          (BuildContext context, int index) {
                            return SearchProductUI(
                              productModel: brandProductList[index],
                            );
                          },
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
