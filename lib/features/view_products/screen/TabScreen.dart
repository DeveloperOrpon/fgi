import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/style/app_colors.dart';
import '../Model/ProductRes.dart';
import '../component/SingleProductListUI.dart';
import '../component/single_product_ui.dart';

class CategoryProductTabScreen extends StatefulWidget {
  final String categoryName;

  const CategoryProductTabScreen({super.key, required this.categoryName});

  @override
  State<CategoryProductTabScreen> createState() =>
      _CategoryProductTabScreenState();
}

class _CategoryProductTabScreenState extends State<CategoryProductTabScreen> {
  final RefreshController refreshPendingController =
      RefreshController(initialRefresh: false);
  bool initLoading = true;
  bool productLoadLoading = false;
  int page = 1;
  List<ProductModel> productList = [];
  ScrollController _scrollController = ScrollController();
  final categoryController = Get.put(CategoryController());
  final allProductController = Get.put(AllProductController());

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


  loadCategory({bool isRefresh=false}) {
    categoryController
        .getProductByCategory(widget.categoryName, page,refresh: isRefresh)
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
                    setState(() {});
                   await loadCategory(isRefresh: true);
                    refreshPendingController.refreshCompleted();
                  },
                  onLoading: () {
                    printLog("onLoading");

                    setState(() {
                      productLoadLoading = true;
                      page++;
                      loadCategory();
                    });
                    Future.delayed(Duration(seconds: 0),() async {
                      await loadCategory(isRefresh: true);
                      refreshPendingController.loadComplete();
                    },);
                  },
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          allProductController.isListAllProduct.value ? 1 : 2,
                      mainAxisExtent:
                          allProductController.isListAllProduct.value
                              ? 125
                              : 325,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                        return allProductController.isListAllProduct.value
                            ? SingleProductListUI(
                                index: productList[index].categoryId ?? "",
                                productModel: productList[index],
                              )
                            : SingleProductUi(productModel: productList[index]);
                    },
                  ),
                );
              });
  }
}
