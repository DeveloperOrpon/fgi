import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../constants/var_const.dart';
import '../../view_products/Model/Product.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    printLog("Product Details : ${productModel.toJson()}");
    String about = productModel.productInformation==null?"":productModel.productInformation!.replaceAll("&lt;", "<");

    return Column(
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Related Information",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black,
              ),
            )),
        const SizedBox(height: kDefaultPadding / 5),
        HtmlWidget(
          about,

          // style: const TextStyle(height: 1.5),
        ),
      ],
    );
  }
}
