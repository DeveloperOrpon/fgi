import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../view_products/component/single_product_ui.dart';
import '../component/searchProductUi.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverAppBar(

              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              title: const Text(
                "Search Product",
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.bell,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.shopping_cart,
                      color: Colors.black,
                    ))
              ],
            ),

            ///home
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  style: const TextStyle(
                      fontSize: 16, decoration: TextDecoration.none),
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    suffixIcon: const Icon(
                      CupertinoIcons.xmark,
                      size: 25,
                    ),
                    hintText: "Search",
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 16),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                ),
              )
            ])),

            ///product
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const SearchProductUI(),
                  childCount: 20,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 255,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5)),
          ],
        ),
      ),
    );
  }
}
