import 'package:fgi_y2j/features/product_details/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../config/route.dart';
import '../../config/style/app_colors.dart';
import '../view_products/Model/Product.dart';
import 'components/cart_counter.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({ Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Body(product: product),
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(left: 30.0,right: 8),
        child: Row(
          children: [
            const CartCounter(),
            const SizedBox(width: 5),
            SizedBox(
              height: 40,
              width: 50,
              child: Center(
                child: ElevatedButton(
                    style: IconButton.styleFrom(
                      elevation: 6,
                        backgroundColor: AppColors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ))),
                    onPressed: () {

                    },
                    child: const Icon(CupertinoIcons.heart,color: Colors.black,)),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: () {},
                  child: Text(
                    "ADD TO CART".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade100,
        statusBarIconBrightness: Brightness.dark,
        // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      backgroundColor:  Colors.grey.shade100,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      actions: [
        IconButton(
            onPressed: () {
              AppRoute().notificationScreen();
            },
            icon: const Icon(
              CupertinoIcons.bell,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {
              AppRoute().cartPage();
            },
            icon: const Icon(
              CupertinoIcons.shopping_cart,
              color: Colors.black,
            ))
      ],
    );
  }
}
