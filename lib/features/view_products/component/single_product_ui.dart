import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/config.dart';

class SingleProductUi extends StatefulWidget {
  const SingleProductUi({Key? key}) : super(key: key);

  @override
  State<SingleProductUi> createState() => _SingleProductUiState();
}

class _SingleProductUiState extends State<SingleProductUi> {
  int countProduct=1;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(8),
      height: 270,
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
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    "assets/demo/demo1.png",
                    height: 110,
                    fit: BoxFit.cover,
                    width: Get.width * .4 - 4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            "Double Patty Burger",
            style: GoogleFonts.roboto(
                color: Colors.black, fontSize: 16),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                textAlign: TextAlign.left,
                "122.00 $currencySymbol",
                style: GoogleFonts.roboto(
                    color: Colors.black, fontSize: 17,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if(countProduct.isGreaterThan(0)){
                        setState(() {
                          countProduct--;
                        });
                      }
                    },
                    child: Icon(CupertinoIcons.minus)),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    "$countProduct",
                    style: GoogleFonts.roboto(
                        color: Colors.black, fontSize: 17,fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                    style: IconButton.styleFrom(

                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        countProduct++;
                      });
                    },
                    child: Icon(CupertinoIcons.plus)),
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Add To Cart")),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
