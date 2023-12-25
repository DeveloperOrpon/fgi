import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/product_details/details_screen.dart';
import 'package:fgi_y2j/features/view_products/Model/Product.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../../constants/var_const.dart';
import '../controller/allProductController.dart';

class SingleProductListUI extends StatelessWidget {
  final String index;
  final ProductModel productModel;

  const SingleProductListUI({Key? key, required this.index, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allProductController = Get.put(AllProductController());

    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(productModel: productModel),
            transition: Transition.fadeIn);
      },
      child: Container(
        height: 115,
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          width: 100,
                          fit: BoxFit.fill,
                            imageUrl: productModel.productImage!=null ?productModel.productImage!:
                            productModel.fetImage==null || productModel.fetImage!.isEmpty?"":productModel.fetImage![0] ??
                                "",
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: AppColors.primary, width: .5)),
                            child: Center(
                              child: Text(
                                "$appName",
                                style: TextStyle(color: Colors.grey.shade200),
                              ),
                            ),
                          ),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                          const SpinKitFoldingCube(
                            color: AppColors.primary,
                            size: 50.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ),
               if(productModel.discount!>0) Container(
                  width: 44,
                  padding: EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),

                    )
                  ),
                  child: Text(textAlign: TextAlign.center,"-${productModel.discount}%",style: TextStyle(fontSize: 13,color: Colors.white),),
                )
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${productModel.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      GoogleFonts.roboto(color: Colors.black, fontSize: 16),
                ),
                Row(
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
                        child: Text("Category",style: GoogleFonts.robotoMono(
                          fontSize: 9,
                        ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:3.0),
                      child: Text("${productModel.categoryName}",style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      )),
                    ),
                  ],
                ),
                Row(
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
                        child: Text("Company",style: GoogleFonts.robotoMono(
                          fontSize: 9,
                        ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:3.0),
                      child: Text("${productModel.brandName}",style: GoogleFonts.robotoMono(
                        fontSize: 9,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(1),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Center(
                        child: Text(
                          "Unit",
                          style: GoogleFonts.robotoMono(
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: Text("${productModel.productUnitType}",
                          style: GoogleFonts.robotoMono(
                            fontSize: 9,
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if(productModel.discount!>0)  Text(
                      "$currencySymbol ${productModel.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 14,
                        color: Colors.grey,
                        // decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      "  $currencySymbol ${productRegularPrice(productModel.price.toString(), productModel.discount.toString())}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.pink,
                      ),
                    ),
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
                  showSuccessToastTop("Information", "Product Added To cart", context);
                  allProductController
                      .addToCartProduct(productModel);
                },
                child: const Icon(CupertinoIcons.shopping_cart))
          ],
        ),
      ),
    );
  }
}

productRegularPrice(String price,String discount){
  double priceNum=num.parse(price).toDouble();
  double discountNum=num.parse(discount).toDouble();
  num regularPrice=priceNum-((priceNum*discountNum)/100);
  return regularPrice.toInt();
}