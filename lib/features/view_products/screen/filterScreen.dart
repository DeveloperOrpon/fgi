import 'package:fgi_y2j/features/view_products/component/FilterProducts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/route.dart';
import '../../../config/style/app_colors.dart';
import '../../Category_Brand/Controller/CategoryController.dart';
import '../../dashboard/Component/dashDrawer.dart';
import '../../shopping_cart/controller/cartController.dart';
import '../component/ProductFilterDrawer.dart';
import '../controller/allProductController.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final allProductController = Get.put(AllProductController());
  final categoryController = Get.put(CategoryController());
  final cartController = Get.put(CartController());
  @override
  void initState() {
Future.delayed(Duration(seconds: 1),() {
  _scaffoldKey.currentState!.openEndDrawer();
},);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // drawer: const DashDrawer(),
      endDrawer: const ProductFilterDrawer(),
      backgroundColor: CupertinoColors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {
        _scaffoldKey.currentState!.openEndDrawer();
      },child: Icon(Icons.filter_alt_rounded),),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.transparent,
        title: const Text("Filter Product"),

        actions: [
          Obx(() {
            return IconButton(
                onPressed: () {
                  allProductController.isListAllProduct.value =
                  !allProductController.isListAllProduct.value;
                },
                icon: allProductController.isListAllProduct.value
                    ? const Icon(
                  CupertinoIcons.square_grid_2x2,
                  color: Colors.black,
                )
                    : const Icon(
                    CupertinoIcons.list_bullet_below_rectangle));
          }),
          IconButton(
              onPressed: () {
                AppRoute().notificationScreen();
              },
              icon: const Icon(
                CupertinoIcons.bell,
                color: Colors.black,
              )),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    onPressed: () {
                      AppRoute().cartPage();
                    },
                    icon: const Icon(
                      CupertinoIcons.shopping_cart,
                      color: Colors.black,
                    )),
              ),
              Obx(() {
                return cartController.cartItems.value.isNotEmpty
                    ? Positioned(
                  top: 0,
                  right: 5,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Center(
                      child: Text(
                        "${cartController.cartItems.length}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                )
                    : Center();
              })
            ],
          )
        ],
      ),
      body: FilterProduct(),
    );
  }
}
