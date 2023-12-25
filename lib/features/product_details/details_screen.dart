import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/features/notification/controller/notificationController.dart';
import 'package:fgi_y2j/features/product_details/components/body.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:fgi_y2j/features/wishProduct/controller/WishController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../config/route.dart';
import '../../config/style/app_colors.dart';
import '../../constants/var_const.dart';
import '../Dialog/Authentication_Message.dart';
import '../view_products/Model/Product.dart';
import 'components/cart_counter.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailsScreen({Key? key, required this.productModel})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double numOfItems = 1;
  final productController = Get.put(AllProductController());
  final notificationController = Get.put(AppNotificationController());
  final wish = Get.put(WishController());
  final cartController = Get.put(CartController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Hero(
        tag: widget.productModel.pId??"",
        child: Body(productModel: widget.productModel),
      ),
      floatingActionButton: BounceInUp(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Row(
                  children: <Widget>[
                    buildOutlineMinButton(press: () {
                      if (numOfItems >(widget.productModel.unitFlag!.toInt()==0? .5:1)) {
                        setState(() {
                          if(widget.productModel.unitFlag!.toInt()==0){
                            numOfItems=numOfItems-.5;
                          }else{
                            numOfItems--;
                          }

                        });
                      }
                    }),
                    Padding(
                      padding: const EdgeInsets.only(left:
                       kDefaultPadding / 2),
                      child: Text(
                        // if our item is less  then 10 then  it shows 01 02 like that
                        "${numOfItems.toString().padLeft(2, "0")}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:
                      kDefaultPadding / 2),
                      child: Text("  (${widget.productModel.productUnitType})",style: TextStyle(fontSize: 10,color: AppColors.red),),
                    ),
                    buildOutlineDisButton(
                      press: () {
                        setState(() {
                          if(widget.productModel.unitFlag!.toInt()==0){
                            numOfItems=numOfItems+.5;
                          }else{
                            numOfItems++;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
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
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ))),
                      onPressed: () async {
                       await wish.addOnWishList(widget.productModel);
                       await wish.getOnWishList();
                        setState(() {

                        });
                      },
                      child: Obx(() {
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
                    onPressed: () {
                      showSuccessToastTop(
                          "Information", "Product Added To cart", context);
                      productController
                          .addToCartProduct(widget.productModel,
                              quantity: numOfItems)
                          .then((value) {
                        if (!value) {
                          showErrorDialogInTop(
                              "Warning",
                              "Something Error When Product Added To Cart",
                              context);
                        }
                      });
                    },
                    child: Text(
                      "ADD TO CART".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade100,
        statusBarIconBrightness: Brightness.dark,
        // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      backgroundColor: Colors.grey.shade100,
      title: Text(widget.productModel.name??""),
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
                onPressed: () {
                  AppRoute().notificationScreen();
                },
                icon: const Icon(
                  CupertinoIcons.bell,
                  color: Colors.black,
                )),
            Obx(() {
              return notificationController.countUnRead().isGreaterThan(0)
                  ? Positioned(
                top: 0,
                right: 5,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red,
                  child: Center(
                    child: Text(
                      "${notificationController.countUnRead()}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              )
                  : Center();
            })
          ],
        ),
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
    );
  }
}
