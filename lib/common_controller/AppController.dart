import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

class AppController extends GetxController{
  RxBool haveConnection =RxBool(true);

  @override
  void onInit() {
    Connectivity().onConnectivityChanged.listen((event) {
      if(event==ConnectivityResult.none){
        haveConnection.value=false;
      }else{
        haveConnection.value=true;
      }
    });
    super.onInit();
  }
}