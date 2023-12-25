import 'dart:developer';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/view_products/component/FilterProducts.dart';
import 'package:fgi_y2j/features/view_products/screen/AllProductHome.dart';
import 'package:fgi_y2j/features/view_products/component/single_product_ui.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:fgi_y2j/features/view_products/screen/AllProductListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/text_style.dart';
import '../../Category_Brand/Model/CategoryByProductRes.dart';
import '../../Category_Brand/Screen/CategoryByProductScreen.dart';
import '../../dashboard/Component/dashDrawer.dart';
import '../../search_product/screen/search_screen.dart';
import 'SingleProductListUI.dart';

class FilterProduct extends StatefulWidget {
  const FilterProduct({super.key});

  @override
  State<FilterProduct> createState() => _FilterProductState();
}

class _FilterProductState extends State<FilterProduct> {
  int page=1;
  final allProductController = Get.put(AllProductController());
  final categoryController = Get.put(CategoryController());

  // multiple choice value

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.to(const SearchScreen(),
                      transition: Transition.fadeIn);
                },
                child: IgnorePointer(
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
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontSize: 16),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(
                  CupertinoIcons.grid_circle,
                  size: 35,
                ))
          ],
        ),
        Expanded(
          child: Obx(() {
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
              controller: allProductController.refreshController,
              onRefresh: () {
                printLog("onRefresh");
                page=1;
                allProductController.filterProducts.value=[];
                allProductController.filterProductSearchRes.value=null;
                allProductController.getProductByBrandCategorySubCategory(page);
                allProductController.onRefreshPage();
              },
              onLoading: () {
                page++;
                allProductController.getProductByBrandCategorySubCategory(page);
                allProductController.onLoadingPage();
              },
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Obx(() {
                      return allProductController.filters.value.isEmpty?Center(): ChipsChoice<int>.single(
                        value: 10,
                        onChanged: (value) {},
                        choiceItems: C2Choice.listFrom<int, Map<String, dynamic>>(
                          source: allProductController.filters.value ?? [],
                          value: (i, v) => i,
                          label: (i, v) => v["value"],
                          tooltip: (i, v) => v['value'],
                          delete: (i, v) => () {
                            log("Lemgth Items: ${allProductController.filters.value.length}");
                            if (allProductController.filters.length == 1) {
                              allProductController.selectCategory.value = null;
                              allProductController.selectBrand.value = null;
                              allProductController.selectSubCategory.value = null;
                            } else {
                              if (allProductController.filters.value[i]['name'] ==
                                  'brand') {
                                allProductController.selectBrand.value = null;
                              }
                              if (allProductController.filters.value[i]['name'] ==
                                  'subCat') {
                                allProductController.selectSubCategory.value = null;
                              }
                              if (allProductController.filters.value[i]['name'] ==
                                  'cat') {
                                allProductController.selectCategory.value = null;
                              }
                            }

                            final temp = allProductController.filters.value;
                            temp.removeAt(i);
                            allProductController.filters.value = temp;
                            setState(() {

                            });

                            allProductController.getProductByBrandCategorySubCategory(1);
                          },
                        ),
                        choiceStyle: C2ChipStyle.toned(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        leading: const Text("Filter: "),
                        wrapped: true,
                      );
                    }),
                  ])),
                (allProductController.filterProducts.isEmpty && allProductController.filterProductSearchRes.value==null)? SliverList(delegate: SliverChildListDelegate([
                  Lottie.asset(
                      'assets/animation/loadingScreen.json')
                ])): (allProductController.filterProducts.isEmpty && allProductController.filterProductSearchRes.value!=null)?SliverList(delegate: SliverChildListDelegate([
                  Lottie.asset(
                      'assets/animation/nodata.json')
                ])): SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    final e = allProductController.filterProducts.value[index];
                    return SingleProductListUI(
                      index: e.categoryId ?? "",
                      productModel: e,
                    );
                  }, childCount: allProductController.filterProducts.value.length))
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
