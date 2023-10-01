import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderController extends GetxController{
  ///History Page
  final RefreshController refreshHistoryController = RefreshController(initialRefresh: false);
  void onRefreshHistoryPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshHistoryController.refreshCompleted();
  }

  void onLoadingHistoryPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshHistoryController.loadComplete();
  }

  /// order pending
  final RefreshController refreshPendingController = RefreshController(initialRefresh: false);
  void onRefreshPendingPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshPendingController.refreshCompleted();
  }

  void onLoadingPendingPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshPendingController.loadComplete();
  }
  /// order Complete
  final RefreshController refreshCompleteController = RefreshController(initialRefresh: false);
  void onRefreshCompletePage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshCompleteController.refreshCompleted();
  }

  void onLoadingCompletePage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshCompleteController.loadComplete();
  }
  /// order invoice
  final RefreshController refreshInvoiceController = RefreshController(initialRefresh: false);
  void onRefreshInvoicePage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshInvoiceController.refreshCompleted();
  }

  void onLoadingInvoicePage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshInvoiceController.loadComplete();
  }
}