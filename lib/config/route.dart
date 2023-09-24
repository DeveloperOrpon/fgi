import 'package:fgi_y2j/features/shopping_cart/screen/CartScreen.dart';
import 'package:get/get.dart';

class AppRoute{
    cartPage()=>Get.to(const CartScreen(),transition: Transition.upToDown);
}