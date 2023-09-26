import 'package:fgi_y2j/features/shopping_cart/screen/CartScreen.dart';
import 'package:get/get.dart';

import '../features/notification/screen/NotificationScreen.dart';

class AppRoute{
    cartPage()=>Get.to(const CartScreen(),transition: Transition.upToDown);
    notificationScreen()=>Get.to(const NotificationScreen(),transition: Transition.upToDown);
}