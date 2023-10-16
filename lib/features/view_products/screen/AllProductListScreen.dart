import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';

import '../../../config/style/text_style.dart';
import '../../Category_Brand/Screen/CategoryByProductScreen.dart';
import '../component/SingleProductListUI.dart';

class AllProductListScreen extends StatelessWidget {
  const AllProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allProductController=Get.put(AllProductController());
    return FadeIn(
      child : CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 30,
                            ),
                            hintText: "Search",
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 16),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();

                        },
                        icon: const Icon(
                          CupertinoIcons.grid_circle,
                          size: 35,
                        ))
                  ],
                )
              ])),
          SliverStickyHeader(
            header: Container(
              color: Colors.white,
              height: 50,
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Burgers",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const CategoryByProductScreen(categoryName:"Burgers" ),transition:Transition.upToDown);
                      },
                      child: Text(
                        "See All",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => SingleProductListUI(index: i,),
                childCount: 4,
              ),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              color: Colors.white,
              height: 50,
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hotdogs",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const CategoryByProductScreen(categoryName:"Hotdogs" ),transition:Transition.upToDown);
                      },
                      child: Text(
                        "See All",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => SingleProductListUI(index: i,),
                childCount: 4,
              ),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              color: Colors.white,
              height: 50,
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pizza",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const CategoryByProductScreen(categoryName:"Pizza" ),transition:Transition.upToDown);
                      },
                      child: Text(
                        "See All",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => SingleProductListUI(index: i,),
                childCount: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
