import 'package:animate_icons/animate_icons.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:fgi_y2j/config/config.dart';
import 'package:fgi_y2j/config/route.dart';
import 'package:fgi_y2j/config/style/text_style.dart';
import 'package:fgi_y2j/features/Category/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/common_component/simpleAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/style/app_colors.dart';
import '../component/SingleProductUiWidget.dart';
import '../component/sort_multi_choice.dart';

class CategoryByProductScreen extends StatelessWidget {
  final String categoryName;

  const CategoryByProductScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: AnimateIcons(
            startIcon: Icons.filter_alt_sharp,
            endIcon: CupertinoIcons.xmark,
            size: 30.0,
            controller: categoryController.animation,
            onStartIconPress: () {
              categoryController.bottomBarController.openSheet();

              return true;
            },
            onEndIconPress: () {
              categoryController.bottomBarController.closeSheet();

              return true;
            },
            duration: const Duration(milliseconds: 500),
            startIconColor: Colors.white,
            endIconColor: Colors.white,
            clockwise: false,
          )),
      backgroundColor: Colors.white,
      appBar: appBarComponent(
          title: categoryName,
          onTap: () {
            AppRoute().cartPage();
          }),
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
        controller: categoryController.refreshController,
        onRefresh: () {
          printLog("onRefresh");
          categoryController.onRefreshPage();
        },
        onLoading: () {
          printLog("onLoading");
          categoryController.onLoadingPage();
        },
        child: CustomScrollView(
          controller: categoryController.productScrollController,
          physics: const BouncingScrollPhysics(),
            slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 300, crossAxisCount: 1),
            delegate: SliverChildBuilderDelegate(
              childCount: 5,
              (BuildContext context, int index) {
                return SingleProductUiWidget(
                  index: index,
                );
              },
            ),
          )
        ]),
      ),
      bottomNavigationBar: BottomBarWithSheet(
        duration: const Duration(milliseconds: 600),
        curve: Curves.linearToEaseOut,
        disableMainActionButton: true,
        controller: categoryController.bottomBarController,
        bottomBarTheme: const BottomBarTheme(
          heightOpened: 310,
          heightClosed: 0,
          mainButtonPosition: MainButtonPosition.right,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          itemIconColor: Colors.grey,
          itemTextStyle: TextStyle(
            color: Colors.grey,
            fontSize: 10.0,
          ),
          selectedItemTextStyle: TextStyle(
            color: Colors.blue,
            fontSize: 10.0,
          ),
        ),
        onSelectItem: (index) => debugPrint('$index'),
        sheetChild: Container(
          padding: const EdgeInsets.only(left: 0, right: 0),
          height:  310,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Filter",
                  style: AppTextStyles.boldstyle.copyWith(fontSize: 18),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sort by Sub-Category",
                      style: AppTextStyles.boldstyle.copyWith(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Scroll Right",
                      ),
                    ),
                  ],
                ),
                const MultipleChipChoiceWidget(
                    reportList: ['Lower Price', 'Highest Price', "Discount"]),
                Row(
                  children: [
                    Text("Price Range ($currencySymbol)",
                        style: AppTextStyles.boldstyle.copyWith(fontSize: 18)),
                  ],
                ),
                SfSlider(
                  min: 0.0,
                  max: 2000.0,
                  interval: 500,
                  stepSize: 500,
                  showLabels: true,
                  showTicks: true,
                  showDividers: true,
                  enableTooltip: true,
                  shouldAlwaysShowTooltip: true,
                  value: 500,
                  onChanged: (dynamic newValue) {},
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            backgroundColor: AppColors.primary.withOpacity(.5),
                          ),
                          child: const Text("Reset"),
                          onPressed: () {
                            categoryController.animation.animateToStart();
                            categoryController.bottomBarController.closeSheet();
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                          ),
                          child: const Text("Apply Filter"),
                          onPressed: () {
                            categoryController.animation.animateToStart();
                            categoryController.bottomBarController.closeSheet();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        mainActionButtonBuilder: (context) => const Center(),
        items: const [],
      ),
    );
  }
}
