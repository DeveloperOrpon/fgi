import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../../constants/var_const.dart';
import '../../Dialog/Authentication_Message.dart';
import '../../product_details/components/body.dart';
import '../../product_details/details_screen.dart';
import '../../view_products/Model/Product.dart';

class SearchProductUI extends StatelessWidget {
  const SearchProductUI({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(product: products[0]),transition: Transition.fadeIn);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 3),
        height: 230,
        width: Get.width * .4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(2, 2),
              )
            ]),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/demo/demo1.png",
                      height: 110,
                      fit: BoxFit.cover,
                      width: Get.width * .5 - 29,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Double Patty Burger",
                style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
              ),
            ),
            const ProductInfoRow(
                title: "Brand", product: "KFC",fontSize: 10,),
            const ProductInfoRow(
                title: "Code", product:"SHFAHJ1232",fontSize: 10),
            const ProductInfoRow(
                title: "Category", product: "Hot Dog",fontSize: 10,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  textAlign: TextAlign.left,
                  "122.00 $currencySymbol",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          showSuccessToastTop("Information", "Product Added To cart", context);
                        }, child: Text("Add To Cart")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
