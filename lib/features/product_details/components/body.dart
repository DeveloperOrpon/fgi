import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/product_details/components/sizes.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';
import '../../../constants/var_const.dart';
import '../../common_component/Screen/PreviewFullScreenImages.dart';
import '../../view_products/Model/Product.dart';
import '../../view_products/component/SingleProductListUI.dart';
import 'cart_counter.dart';
import 'color_and_size.dart';
import 'description.dart';

class Body extends StatefulWidget {
  final ProductModel productModel;

  const Body({Key? key, required this.productModel}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> allImages=[];
  @override
  void initState() {
    allImages = widget.productModel.fetImage ?? [];
    allImages.add(widget.productModel.productImage ?? '');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          BounceInDown(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  height: Get.height * .35,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        offset: Offset(3, 3),
                        spreadRadius: 5,
                        blurRadius: 5,
                      )
                    ]
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 1.0,
                                viewportFraction: .56,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: false,
                                enlargeFactor: 0,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: allImages.map((i) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                        PreviewFullScreenImages(
                                            images: allImages),
                                        transition: Transition.upToDown);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: i,
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.primary,
                                                  width: .5)),
                                          child: Center(
                                            child: Text(
                                              "$appName",
                                              style: TextStyle(
                                                  color: Colors.grey.shade300),
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
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProductInfo(
                              title: "Brand",
                              product: widget.productModel.brandName ?? ""),
                          Container(
                            height: kDefaultPadding ,
                            width: 2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          ProductInfo(
                              title: "Category",
                              product: widget.productModel.categoryName ?? ""),
                          Container(
                            height: kDefaultPadding ,
                            width: 2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          ProductInfo(
                              title: "Sub-Category",
                              product: widget.productModel.subcategoryName.toString()),
                          Container(
                            height: kDefaultPadding ,
                            width: 2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          ProductInfo(
                              title: "Unit",
                              product: widget.productModel.productUnitType.toString()),
                          const SizedBox(height: kDefaultPadding / 2),
                        ],
                      )
                    ],
                  ),
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
                    Expanded(
                      child: Text(
                        "${widget.productModel.name}",
                        style: GoogleFonts.robotoSlab(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                 Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Row(
                       children: [
                         Text(
                           "$currencySymbol${widget.productModel.price}",
                           style: const TextStyle(
                             fontWeight: FontWeight.w700,
                             fontSize: 14,
                             color: Colors.grey,
                             decoration: TextDecoration.lineThrough,
                           ),
                         ),
                         Text(
                           "  $currencySymbol ${productRegularPrice(widget.productModel.price.toString(), widget.productModel.discount.toString())}",
                           style: const TextStyle(
                             fontWeight: FontWeight.w700,
                             fontSize: 18,
                             color: Colors.pink,
                           ),
                         ),
                       ],
                     ),
                     Text(
                       "(Box Items ${widget.productModel.productUnitQuantity} Piece)",
                       style: const TextStyle(
                         fontWeight: FontWeight.w300,
                         fontSize: 14,
                         color: Colors.pink,
                         decoration: TextDecoration.underline
                       ),
                     ),
                   ],
                 )
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Sizes(
                  productModel: widget.productModel,
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Description(productModel: widget.productModel),
                const SizedBox(height: kDefaultPadding / 2),
                const SizedBox(height: kDefaultPadding / 2),
                SizedBox(height: Get.height * .3)
              ],
            ),
          ).animate().moveY(delay: 400.ms)
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
    this.fontSize = 14,
  }) : super(key: key);

  final String product;
  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 3,right: 3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,

              maxLines: 1,
              title,
              style: TextStyle(color: Color(0xFF8B2833), fontSize: fontSize,fontWeight: FontWeight.bold),
            ),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              product,
              style: TextStyle(
                  color: Color(0xFF8B2833).withOpacity(0.5), fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductInfoRow extends StatelessWidget {
  const ProductInfoRow({
    Key? key,
    required this.product,
    required this.title,
    this.fontSize = 14,
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
          style: TextStyle(color: Colors.black, fontSize: fontSize),
        ),
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            product,
            style: TextStyle(
                color: AppColors.primary,
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}
