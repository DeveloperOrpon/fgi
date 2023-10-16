import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllProductController extends GetxController{
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  RxBool isLoadingAllProduct=RxBool(false);
  RxBool isListAllProduct=RxBool(false);

  void onRefreshPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoadingPage() async{
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }
}