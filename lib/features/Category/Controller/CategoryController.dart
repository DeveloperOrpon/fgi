import 'package:animate_icons/animate_icons.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryController extends GetxController with GetTickerProviderStateMixin{
  final bottomBarController = BottomBarWithSheetController(initialIndex: 0);
  final productScrollController = ScrollController();
 final animation= AnimateIconController();
  RxBool isDrawerOpen=RxBool(false);
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  void onRefreshPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoadingPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }
  @override
  void onInit() {
    bottomBarController.stream.listen((opened) {
       isDrawerOpen.value=opened;
    });
    productScrollController.addListener(() {
      animation.animateToStart();
      bottomBarController.closeSheet();
    });
    super.onInit();
  }
}