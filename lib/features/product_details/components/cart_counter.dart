import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/var_const.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({Key? key}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
       color: Colors.grey.shade200,
      ),
      child: Row(
        children: <Widget>[
          buildOutlineMinButton(
              press: () {

                if (numOfItems > 1) {
                  setState(() {
                    numOfItems--;
                  });
                }
              }),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            child: Text(
              // if our item is less  then 10 then  it shows 01 02 like that
              numOfItems.toString().padLeft(2, "0"),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          buildOutlineDisButton(
            press: () {

                setState(() {
                  numOfItems++;
                });

            },
          ),
        ],
      ),
    );
  }

  SizedBox buildOutlineMinButton({required Function press}) {
    return SizedBox(
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
            press();
          },
          child: const Icon(CupertinoIcons.minus)),
    );
  }
}

SizedBox buildOutlineDisButton({required Function press}) {
  return SizedBox(
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

        onPressed: () {
          press();
        },
        child: const Icon(CupertinoIcons.plus),
      ));
}
