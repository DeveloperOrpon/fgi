import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../../config/style/app_colors.dart';
import '../../../constants/var_const.dart';
import '../../Dialog/Authentication_Message.dart';
import '../../common_component/Screen/PreviewFullScreenImages.dart';
import '../../product_details/components/body.dart';
import '../../product_details/details_screen.dart';
import '../../view_products/Model/Product.dart';
import '../../view_products/Model/ProductRes.dart';
import '../../view_products/component/SingleProductListUI.dart';

class SearchProductUI extends StatelessWidget {
  final ProductModel productModel;
  const SearchProductUI({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final allProductController=Get.put(AllProductController());
    List<String> allImages=productModel.fetImage??[];
    allImages.add(productModel.productImage??'');
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen( productModel: productModel,),transition: Transition.fadeIn);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 3),
        height: 280,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary,width: .5)
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.to(  PreviewFullScreenImages(images: allImages),transition: Transition.leftToRightWithFade);
                            },
                            child:CachedNetworkImage(
                              height: 110,
                              fit: BoxFit.cover,
                              width: Get.width * .5 - 30,
                              imageUrl: productModel.productImage??productModel.fetImage![0],
                              errorWidget: (context, url, error) =>
                                  Center(child: Text("$appName",style: TextStyle(color: Colors.grey.shade200))),
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                              const SpinKitFoldingCube(
                                color: AppColors.primary,
                                size: 50.0,
                              ),
                            ),

                          ),
                        ),

                      ),
                      if(productModel.discount!=null && productModel.discount!>0)   Container(
                        width: 44,
                        padding: EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: Text(
                          textAlign: TextAlign.center,
                          "-${productModel.discount}%",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.only(left: 6.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 // mainAxisSize: MainAxisSize.min,
                 children: [
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text(
                       "${productModel.name!.trim()}",
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                       style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
                     ),
                   ),
                   ProductInfoRow(
                     title: "Unit", product: "${productModel.productUnitType}",fontSize: 10,),
                   ProductInfoRow(
                       title: "Category", product:"${productModel.categoryName}",fontSize: 10),
                   ProductInfoRow(
                     title: "Sub-Category", product: "${productModel.subcategoryName}",fontSize: 10,),

                   Row(
                     children: [
                       if(productModel.discount!=null && productModel.discount!>0)  Text(
                         "${productModel.price}$currencySymbol ",
                         style: GoogleFonts.robotoMono(
                           fontWeight: FontWeight.w500,
                           decoration: TextDecoration.lineThrough,
                           fontSize: 14,
                           color: Colors.grey,
                           // decoration: TextDecoration.lineThrough,
                         ),
                       ),
                       Text(
                         overflow: TextOverflow.ellipsis,
                         "${productRegularPrice(productModel.price.toString(), productModel.discount.toString())}$currencySymbol",
                         style:  GoogleFonts.robotoMono(
                           fontWeight: FontWeight.w500,
                           fontSize: 16,
                           color: Colors.pink,
                         ),
                       ),
                     ],
                   ),
                 ],
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
                          allProductController
                              .addToCartProduct(productModel);
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
