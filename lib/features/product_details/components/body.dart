import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/product_details/components/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../constants/var_const.dart';
import '../../common_component/Screen/PreviewFullScreenImages.dart';
import '../../view_products/Model/Product.dart';
import 'cart_counter.dart';
import 'color_and_size.dart';
import 'description.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                height: Get.height * .35,
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Spacer(),
                                ProductInfo(
                                    title: "Brand", product: product.brand ?? ""),
                                const SizedBox(height: kDefaultPadding / 2),
                                ProductInfo(
                                    title: "Code", product: product.code ?? ""),
                                const SizedBox(height: kDefaultPadding / 2),
                                const ProductInfo(
                                    title: "Category", product: "Hot Dog"),
                                const SizedBox(height: kDefaultPadding / 2),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  child: const Text(
                                    "Variant",
                                    style: TextStyle(
                                      color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                              
                              child:   ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CarouselSlider(
                                  options: CarouselOptions(

                                    aspectRatio: 1.0,
                                    viewportFraction:.56,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: false,
                                    autoPlayInterval: const Duration(seconds: 3),
                                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: false,
                                    enlargeFactor: 0,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: [1,2,3,4,5].map((i) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to( PreviewFullScreenImages(index: i),transition: Transition.upToDown);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/image4.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                        child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...List.generate(
                            10,
                            (index) => Container(

                                  height: 40,
                                  width: Get.width*.3,
                                  margin: const EdgeInsets.only(left: 5,top: 3),
                                  decoration: BoxDecoration(
                                     border: index==0? Border.all(
                                       color: Colors.lightBlue,
                                       width: 1,
                                     ):null,
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(8)),
                                ))
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: kDefaultPadding / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                "Double Patty Burger",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "$currencySymbol${product.price + 100}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.pink,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          "  $currencySymbol${product.price}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                const Sizes(),
                const SizedBox(height: kDefaultPadding / 2),
                Description(product: product),
                const SizedBox(height: kDefaultPadding / 2),
                const SizedBox(height: kDefaultPadding / 2),
                SizedBox(height: Get.height*.3)
              ],
            ),
          )
        ],
      ),
    );

  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    Key? key,
    required this.product,
    required this.title,
     this.fontSize=14,
  }) : super(key: key);

  final String product;
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          maxLines: 1,
          title,
          style: TextStyle(
            color: Color(0xFF8B2833),
            fontSize: fontSize
          ),
        ),
        Text(
          maxLines: 1,
          product,
          style: TextStyle(
            color: Color(0xFF8B2833).withOpacity(0.5),
              fontSize: fontSize
          ),
        ),
      ],
    );
  }
}

class ProductInfoRow extends StatelessWidget {
  const ProductInfoRow({
    Key? key,
    required this.product,
    required this.title,
     this.fontSize=14,
  }) : super(key: key);

  final String product;
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          maxLines: 1,
          "$title: ",
          style: TextStyle(
            color: Color(0xFF8B2833),
            fontSize: fontSize
          ),
        ),
        Text(
          maxLines: 1,
          product,
          style: TextStyle(
            color: Color(0xFF8B2833).withOpacity(0.5),
              fontSize: fontSize
          ),
        ),
      ],
    );
  }
}
