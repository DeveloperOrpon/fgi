import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/product_details/details_screen.dart';
import 'package:fgi_y2j/features/view_products/Model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../../constants/var_const.dart';

class SingleProductListUI extends StatelessWidget {
  final int index;

  const SingleProductListUI({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(product: products[0]),
            transition: Transition.fadeIn);
      },
      child: Dismissible(
        confirmDismiss: (direction) async {
          showSuccessToastTop("Information", "Product Added To cart", context);
          return false;
        },
        key: Key(index.toString()),
        child: Container(
          height: 100,
          width: Get.width,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 2,
                  offset: const Offset(1, 3),
                  blurRadius: 2,
                )
              ]),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/image4.png',
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Double Patty Burger",
                    style:
                        GoogleFonts.roboto(color: Colors.black, fontSize: 16),
                  ),
                  const Text(
                    "Double Patty Burger Double Patty Burger Double Patty Burger Double Patty Burger",
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Colors.black45,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(1),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Center(
                            child: Text("Brand",style: GoogleFonts.robotoMono(
                              fontSize: 9,
                            ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:3.0),
                          child: Text("ABED",style: GoogleFonts.robotoMono(
                            fontSize: 9,
                          )),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$currencySymbol${100}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.pink,
                          // decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      // Text(
                      //   "  $currencySymbol 1000 X1",
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: 16,
                      //     color: AppColors.black,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              )),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(60,100),
                  backgroundColor: Colors.grey.shade200,
                ),
                  onPressed: () {
                    showSuccessToastTop(
                        "Information", "Product Added To cart", context);
                  },
                  child: const Icon(CupertinoIcons.shopping_cart))
            ],
          ),
        ),
      ),
    );
  }
}
