import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DashBoardController extends GetxController{
  ScrollController homeScrollController=ScrollController();
  RxInt selectDrawerIndex=RxInt(0);
  RxDouble homeScrollPosition=RxDouble(0.0);
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final PageController pageController = PageController();

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
    homeScrollController.addListener(() {
      homeScrollPosition.value=homeScrollController.position.pixels;
    });
    super.onInit();
  }
}