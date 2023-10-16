import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../constants/var_const.dart';
import '../../view_products/Model/Product.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Color"),

            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.primary),
              children: [
                const TextSpan(text: "Size\n"),
                TextSpan(
                  text: "${product.size} cm",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      !.copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

