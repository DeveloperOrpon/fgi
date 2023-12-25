import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/BrandRes.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../common_controller/filterController.dart';
import '../../../config/config.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../Category_Brand/Model/CategoryRes.dart';

class ProductFilterDrawer extends StatefulWidget {
  const ProductFilterDrawer({Key? key}) : super(key: key);

  @override
  State<ProductFilterDrawer> createState() => _ProductFilterDrawerState();
}

class _ProductFilterDrawerState extends State<ProductFilterDrawer> {
  bool loadingCategory = false;
  bool loadingSubCat = false;
  List<CategoryModel> brandSelectedCategory = [];
  List<BrandModel> categorySelectedBrand = [];
  final categoryController = Get.put(CategoryController());
  final allProductController = Get.put(AllProductController());
  final filterController = Get.put(FilterController());

  getSelectBrandCategory(BrandModel brandModel) {
    loadingCategory = true;
    categoryController
        .getCategoriesByBrand(brandModel.brandLabel ?? "")
        .then((value) {
      setState(() {
        brandSelectedCategory = value;
        loadingCategory = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideInRight(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: Get.width * .8,
        height: Get.height,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),
        child: SafeArea(child: Obx(() {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(CupertinoIcons.back)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filter",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          allProductController.selectCategory.value = null;
                          allProductController.selectBrand.value = null;
                          allProductController.selectSubCategory.value = null;
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [Text("Clear"), Icon(CupertinoIcons.xmark)],
                        ))
                  ],
                ),
                Text(
                  "Select Brand",
                  style: AppTextStyles.drawerTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
              ])),
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 80,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5),
                itemBuilder: (context, index) {
                  final brandModel = categoryController.brandList[index];

                  return Obx(() {
                    return InkWell(
                      onTap: () {
                        allProductController.selectBrand.value = brandModel;
                        allProductController.selectCategory.value = null;
                        allProductController.selectSubCategory.value = null;
                        brandSelectedCategory = [];
                        getSelectBrandCategory(brandModel);
                        allProductController.getProductByBrandCategorySubCategory(1);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: allProductController.selectBrand.value ==
                                    brandModel
                                ? AppColors.primary.withOpacity(.3)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                            border: allProductController.selectBrand.value ==
                                    brandModel
                                ? Border.all(color: AppColors.primary, width: 2)
                                : Border.all(
                                    color: AppColors.primary, width: .4)),
                        child: brandModel.brandImage != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        height: 30,
                                        fit: BoxFit.cover,
                                        imageUrl: brandModel.brandImage ?? '',
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                          child: Icon(Icons.image),
                                        ),
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                const SpinKitFoldingCube(
                                          color: AppColors.primary,
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${brandModel.brandLabel}",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,

                                  )
                                ],
                              )
                            : Center(
                                child: Text(
                                  "${brandModel.brandLabel}",
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                ),
                              ),
                      ),
                    );
                  });
                },
                itemCount: categoryController.brandList.length > 4 &&
                        !filterController.showAllBrand.value
                    ? 4
                    : categoryController.brandList.length,
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                if (categoryController.brandList.length > 4)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          filterController.showAllBrand.value =
                              !filterController.showAllBrand.value;
                        },
                        child: Text(
                          !filterController.showAllBrand.value
                              ? "All Brand"
                              : "Collapse All Brand",
                          style: AppTextStyles.drawerTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              color: AppColors.primary),
                        ),
                      )
                    ],
                  ),
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Text(
                  "Select Category",
                  style: AppTextStyles.drawerTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
              ])),
              allProductController.selectBrand.value == null
                  ? SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 60,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        final catModel = categoryController.categoryList[index];

                        return Obx(() {
                          return InkWell(
                              onTap: () {
                                allProductController.selectCategory.value =
                                    catModel;
                                allProductController.selectSubCategory.value = null;
                                allProductController.getProductByBrandCategorySubCategory(1);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: allProductController
                                                .selectCategory.value ==
                                            catModel
                                        ? AppColors.primary.withOpacity(.3)
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                    border: allProductController
                                                .selectCategory.value ==
                                            catModel
                                        ? Border.all(
                                            color: AppColors.primary, width: 2)
                                        : Border.all(
                                            color: AppColors.primary,
                                            width: .4)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColors.primary, width: .4)),
                                  child: catModel.image != null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      catModel.image ?? '',
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Center(
                                                    child: Icon(Icons.image),
                                                  ),
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      const SpinKitFoldingCube(
                                                    color: AppColors.primary,
                                                    size: 20.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "${catModel.categoryLabel}",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                            )
                                          ],
                                        )
                                      : Center(
                                          child: Text(
                                            "${catModel.categoryLabel}",
                                            overflow: TextOverflow.fade,
                                            maxLines: 1,
                                          ),
                                        ),
                                ),
                              ));
                        });
                      },
                      itemCount: categoryController.categoryList.length > 4 &&
                              !filterController.showAllCategory.value
                          ? 4
                          : categoryController.categoryList.length,
                    )
                  : _fetchSelectBrandCategory(),
              SliverList(
                  delegate: SliverChildListDelegate([
                if (categoryController.categoryList.length > 4 || brandSelectedCategory.length>4)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          filterController.showAllCategory.value =
                              !filterController.showAllCategory.value;
                        },
                        child: Text(
                          !filterController.showAllCategory.value
                              ? "All Category"
                              : "Collapse All Category",
                          style: AppTextStyles.drawerTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              color: AppColors.primary),
                        ),
                      )
                    ],
                  ),
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Text(
                  "Select Sub-Category",
                  style: AppTextStyles.drawerTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
              ])),
              (allProductController.selectCategory.value == null)
                  ? SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 60,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5),
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      itemCount: 4,
                    )
                  : allProductController.selectCategory.value!.subCategories ==
                              null ||
                          allProductController
                              .selectCategory.value!.subCategories!.isEmpty
                      ? SliverList(
                          delegate: SliverChildListDelegate([
                          const Center(
                              child: Text(
                            "No Sub-Category Found",
                            style: TextStyle(color: Colors.grey),
                          ))
                        ]))
                      : SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 60,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 5),
                          itemBuilder: (context, index) {
                            final subCat = allProductController
                                .selectCategory.value!.subCategories![index];
                            return Obx(() {
                              return InkWell(
                                  onTap: () {
                                    allProductController
                                        .selectSubCategory.value = subCat;
                                    allProductController.getProductByBrandCategorySubCategory(1);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: allProductController
                                                    .selectSubCategory.value ==
                                                subCat
                                            ? AppColors.primary.withOpacity(.3)
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8),
                                        border: allProductController
                                                    .selectSubCategory.value ==
                                                subCat
                                            ? Border.all(
                                                color: AppColors.primary,
                                                width: 2)
                                            : Border.all(
                                                color: AppColors.primary,
                                                width: .4)),
                                    child: subCat.image != null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        bottom: 4.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                  child: CachedNetworkImage(
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        subCat.image ?? '',
                                                    errorWidget: (context,
                                                            url, error) =>
                                                        const Center(
                                                      child:
                                                          Icon(Icons.image),
                                                    ),
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            const SpinKitFoldingCube(
                                                      color:
                                                          AppColors.primary,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${subCat.subcategoryName}",
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                              )
                                            ],
                                          )
                                        : Center(
                                            child: Text(
                                              "${subCat.subcategoryName}",
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                            ),
                                          ),
                                  ));
                            });
                          },
                          itemCount: allProductController
                              .selectCategory.value!.subCategories!.length>4 && !filterController.showAllSubCategory.value?4:allProductController
                              .selectCategory.value!.subCategories!.length,
                        ),
              SliverList(
                  delegate: SliverChildListDelegate([
                    if (allProductController.selectCategory.value!=null && allProductController.selectCategory.value!.subCategories!=null && allProductController.selectCategory.value!.subCategories!.length>4)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              filterController.showAllSubCategory.value =
                              !filterController.showAllSubCategory.value;
                            },
                            child: Text(
                              !filterController.showAllSubCategory.value
                                  ? "All Category"
                                  : "Collapse All Category",
                              style: AppTextStyles.drawerTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  color: AppColors.primary),
                            ),
                          )
                        ],
                      ),
                  ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
              ]))
            ],
          );
        })),
      ),
    );
  }

  _fetchSelectBrandCategory() {
    return loadingCategory
        ? SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 60,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5),
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8)),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(duration: 800.ms),
            itemCount: 4,
          )
        : !loadingCategory && brandSelectedCategory.isEmpty
            ? SliverList(
                delegate: SliverChildListDelegate([
                const Center(
                    child: Text(
                  "No Category Found",
                  style: TextStyle(color: Colors.grey),
                ))
              ]))
            : SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 60,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5),
                itemBuilder: (context, index) {
                  final catModel = brandSelectedCategory[index];

                  return Obx(() {
                    return InkWell(
                        onTap: () {
                          allProductController.selectCategory.value = catModel;
                          allProductController.getProductByBrandCategorySubCategory(1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  allProductController.selectCategory.value ==
                                          catModel
                                      ? AppColors.primary.withOpacity(.3)
                                      : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  allProductController.selectCategory.value ==
                                          catModel
                                      ? Border.all(
                                          color: AppColors.primary, width: 2)
                                      : Border.all(
                                          color: AppColors.primary, width: .4)),
                          child: catModel.image != null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          height: 30,
                                          fit: BoxFit.cover,
                                          imageUrl: catModel.image ?? '',
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Center(
                                            child: Icon(Icons.image),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const SpinKitFoldingCube(
                                            color: AppColors.primary,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${catModel.categoryLabel}",
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    )
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    "${catModel.categoryLabel}",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ),
                                ),
                        ));
                  });
                },
                itemCount: brandSelectedCategory.length > 4 &&
                        !filterController.showAllCategory.value
                    ? 4
                    : brandSelectedCategory.length,
              );
  }
}
