import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DashBoardController extends GetxController{
  RxInt selectDrawerIndex=RxInt(0);
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
}