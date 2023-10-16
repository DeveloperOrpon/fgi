import 'package:flutter/material.dart';
import '../../../constants/var_const.dart';
import '../../view_products/Model/Product.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "About",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black,
              ),
            )),
        const SizedBox(height: kDefaultPadding / 5),
        Text(
          product.description??"",
          style: const TextStyle(height: 1.5),
        ),
      ],
    );
  }
}
