import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/view_products/component/single_product_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/style/text_style.dart';
import '../../dashboard/Component/dashDrawer.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final controller1 = ScrollController();
    return WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            backgroundColor: Colors.transparent,
            title: const Text("Products"),
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
          drawer: const DashDrawer(),
          body: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.square_grid_2x2,
                          size: 35,
                        ))
                  ],
                )
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(height: 10),
                Padding(
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
                            // Get.to(const PendingOrderScreen(),transition:Transition.upToDown);
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
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(
                  height: 280,
                  child: AdaptiveScrollbar(
                    sliderDefaultColor: AppColors.strongAmer,
                    position: ScrollbarPosition.bottom,
                    sliderSpacing: const EdgeInsets.only(top: 10),
                    underSpacing: const EdgeInsets.only(top: 10,bottom: 10),
                    sliderActiveDecoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    underDecoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    controller: controller1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ListView(
                        controller: controller1,
                        scrollDirection: Axis.horizontal,
                        children: [
                          SingleProductUi(),
                          SingleProductUi(),
                          SingleProductUi(),
                          SingleProductUi(),
                        ],
                      ),
                    ),
                  ),
                )
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(height: 10),
                Padding(
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
                            // Get.to(const PendingOrderScreen(),transition:Transition.upToDown);
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
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(
                  height: 300,
                  child: AdaptiveScrollbar(
                    sliderDefaultColor: AppColors.strongAmer,
                    position: ScrollbarPosition.bottom,
                   sliderSpacing: const EdgeInsets.only(top: 10),
                    underSpacing: const EdgeInsets.only(top: 10,bottom: 10),
                    sliderActiveDecoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    underDecoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ListView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        children: [
                          SingleProductUi(),
                          SingleProductUi(),
                          SingleProductUi(),
                          SingleProductUi(),
                        ],
                      ),
                    ),
                  ),
                )
              ]))
            ],
          ),
        ));
  }
}
