import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartController extends GetxController{
  ScrollController cartHomeScrollController=ScrollController();
  /// order Complete
  final RefreshController refreshCartController = RefreshController(initialRefresh: false);
  void onRefreshCartPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshCartController.refreshCompleted();
  }

  void onLoadingCartPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshCartController.loadComplete();
  }
}