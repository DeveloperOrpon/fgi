import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/shopping_cart/screen/CartScreen.dart';
import 'package:fgi_y2j/features/view_products/Model/Product.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:fgi_y2j/features/wishProduct/controller/WishController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../common_component/Screen/PreviewFullScreenImages.dart';
import '../../dashboard/Component/dashboardHome.dart';
import '../../notification/screen/NotificationScreen.dart';
import '../../product_details/details_screen.dart';

class SingleProductUiWidget extends StatefulWidget {
  final int index;
  final bool isShowCount;
  final bool isShowByNowButton;
  final ProductModel productModel;
  const SingleProductUiWidget({Key? key, required this.index,  this.isShowCount=true,  this.isShowByNowButton=true, required this.productModel}) : super(key: key);

  @override
  State<SingleProductUiWidget> createState() => _SingleProductUiWidgetState();
}

class _SingleProductUiWidgetState extends State<SingleProductUiWidget> {
  double countProduct = 1;
  Timer? _timer;
  bool _longPressCanceled = false;
final wish=Get.put(WishController());
  void _increaseAge() {
    setState(() {
      if (widget.productModel.productUnitValue!> 1) {
        countProduct = countProduct + .5;
      } else {
        countProduct++;
      }
    });
  }

  void _cancelIncrease() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _longPressCanceled = true;
  }
  List<String> totalImage=[];
  @override
  void initState() {
    totalImage=widget.productModel.fetImage??[];
    totalImage.add(widget.productModel.productImage??"");
    super.initState();
  }
final allProductController=Get.put(AllProductController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(productModel: widget.productModel),transition: Transition.upToDown);
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
        padding: const EdgeInsets.all(4),
        height: 160,
        width: Get.width * .4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 2,
                spreadRadius: 2,
                offset: const Offset(2, 2),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 100,
                aspectRatio: 2.0,
                viewportFraction:.4,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              items: totalImage.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary,width: .5)
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to( PreviewFullScreenImages(images: totalImage),transition: Transition.leftToRightWithFade);
                        },
                        child:CachedNetworkImage(
                          height: 110,
                          fit: BoxFit.cover,
                          width: Get.width * .4 - 4,
                          imageUrl: i,
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
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 5),
            Padding(

              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                maxLines: 2,
                "${widget.productModel.name??""}",
                style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              maxLines: 2,
              "${widget.productModel.name??""}",
              style: GoogleFonts.roboto(color: Colors.black26, fontSize: 13),
            ),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                textAlign: TextAlign.left,
                "${widget.productModel.price}$currencySymbol",
                style: GoogleFonts.robotoMono(
                    color: AppColors.red,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
         if(widget.isShowCount)   Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 38,
                          width: 45,
                          child: ElevatedButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ))),
                              onPressed: () {

                                if ( widget.productModel.productUnitValue!> 1?countProduct.isGreaterThan(.5):countProduct.isGreaterThan(1)) {
                                  setState(() {
                                    if(widget.productModel.productUnitValue!> 1){
                                      countProduct-=.5;
                                    }else{
                                      countProduct--;
                                    }
                                  });
                                }
                              },
                              child: Icon(CupertinoIcons.minus)),
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text:TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                    "$countProduct",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)
                                ),
                                TextSpan(
                                  text:" (${widget.productModel.productUnitType}- ${widget.productModel.productUnitValue})",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal)
                                )
                              ]
                            ),
                          ),
                        ),
                        GestureDetector(
                          onLongPressEnd: (details) {
                            _cancelIncrease();
                          },
                          onLongPress: () {
                            Future.delayed(Duration(milliseconds: 300), () {
                              if (!_longPressCanceled) {
                                _timer = Timer.periodic(Duration(milliseconds: 150),
                                        (timer) {
                                      _increaseAge();
                                    });
                              }
                            });
                          },
                          onTap: () {

                          },
                          child: SizedBox(
                            height: 38,
                            width: 45,
                            child: ElevatedButton(
                                style: IconButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ))),
                                onFocusChange: (value) {
                                  log("onFocusChange : $value");
                                },
                                onPressed: () {
                                  setState(() {
                                  if(widget.productModel.productUnitValue!> 1){
                                    countProduct+=.5;
                                  }else{
                                    countProduct++;
                                  }
                                  });
                                },

                                child: Icon(CupertinoIcons.plus)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  width: 50,
                  child: Center(
                    child: ElevatedButton(
                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ))),
                        onPressed: () async {
                          await wish.addOnWishList(widget.productModel);
                          await wish.getOnWishList();
                        },
                        child:  Obx(() {
                          return wish.wishListProduct.value.firstWhereOrNull((element) => element.pId==widget.productModel.pId)==null? const Icon(
                            CupertinoIcons.heart,
                            color: Colors.black,
                          ):Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.amber,
                          );
                        }
                        )),
                  ),
                ),
                const SizedBox(width: 10),
                // SizedBox(
                //   height: 40,
                //   width: 50,
                //   child: Center(
                //     child: ElevatedButton(
                //         style: IconButton.styleFrom(
                //             backgroundColor: AppColors.primary,
                //             shape: const RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.only(
                //                   topLeft: Radius.circular(10),
                //                   bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10),
                //                   topRight: Radius.circular(10),
                //                 ))),
                //         onPressed: () {
                //
                //         },
                //         child: const Icon(CupertinoIcons.bookmark,color: Colors.black,)),
                //   ),
                // ),
                const SizedBox(width: 10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          showSuccessDialogInTop("Information", "Product Added In Cart", context);
                          allProductController
                              .addToCartProduct(widget.productModel,quantity: countProduct)
                              .then((value) {
                            if (!value) {
                              showErrorDialogInTop(
                                  "Warning",
                                  "Something Error When Product Added To Cart",
                                  context);
                            }
                          });
                        }, child: const Text("Add To Cart")),
                  ),
                if(widget.isShowByNowButton)  const SizedBox(width: 10),
                  if(widget.isShowByNowButton)   Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          allProductController
                              .addToCartProduct(widget.productModel,quantity: countProduct);
                          Get.to(const CartScreen(),transition: Transition.upToDown);
                        }, child: const Text("Buy Now")),
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