import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/shopping_cart/screen/CartScreen.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/var_const.dart';



class Sizes extends StatelessWidget {
  final ProductModel productModel;
  const Sizes({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allProductController=Get.put(AllProductController());
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: AppColors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: () {
                    Get.to(const CartScreen(),transition: Transition.rightToLeftWithFade);
                    allProductController.addToCartProduct(productModel);
                  },
                  child: Text(
                    "Buy Now".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
