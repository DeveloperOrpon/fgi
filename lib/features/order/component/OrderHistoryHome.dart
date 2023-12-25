import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/order/component/ItemsUiList.dart';
import 'package:fgi_y2j/features/order/controller/orderController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../config/config.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../Category_Brand/Controller/CategoryController.dart';
import '../../dashboard/controller/dashboardController.dart';
import '../../invoice/screen/InvoiceScreenPreview.dart';
import '../../search_product/screen/search_screen.dart';
import '../../shopping_cart/model/OrderRes.dart';
import '../../view_products/controller/allProductController.dart';
import '../screen/AcceptOrdersScreen.dart';
import '../screen/CancelOrdersScreen.dart';
import '../screen/CompleteOrdersScreen.dart';
import '../../invoice/screen/InvoicesScreen.dart';
import '../screen/PendingOrdersScreen.dart';

class OrderHistoryHome extends StatelessWidget {
  const OrderHistoryHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.put(DashBoardController());
    final orderController = Get.put(OrderController());
    final allProductController = Get.put(AllProductController());
    final authController = Get.put(AuthenticationController());
    // return SmartRefresher(
    //   physics: const BouncingScrollPhysics(),
    //   enablePullDown: true,
    //   enablePullUp: true,
    //   header: const WaterDropHeader(
    //     waterDropColor: AppColors.primary,
    //     refresh: CupertinoActivityIndicator(color:  AppColors.black,radius: 15,),
    //   ),
    //   footer: CustomFooter(
    //     builder: (context, mode){
    //       Widget body ;
    //       if(mode==LoadStatus.idle){
    //         body =  const Text("Pull up load");
    //       }
    //       else if(mode==LoadStatus.loading){
    //         body =  const CupertinoActivityIndicator();
    //       }
    //       else if(mode == LoadStatus.failed){
    //         body = const Text("Load Failed!Click retry!");
    //       }
    //       else if(mode == LoadStatus.canLoading){
    //         body = const Text("release to load more");
    //       }
    //       else{
    //         body = const Text("No more Data");
    //       }
    //       return SizedBox(
    //         height: 55.0,
    //         child: Center(child:body),
    //       );
    //     },
    //   ),
    //   controller: orderController.refreshHistoryController,
    //   onRefresh: () {
    //     printLog("onRefresh");
    //     orderController.onRefreshHistoryPage();
    //   },
    //   onLoading: () {
    //     printLog("onLoading");
    //     orderController.onLoadingHistoryPage();
    //   },
    ///comment Remove
    return Obx(() {
      return CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            InkWell(
              onTap: () {
                Get.to(const SearchScreen(), transition: Transition.fadeIn);
              },
              child: IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      hintText: "Search",
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 16),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                ),
              ),
            )
          ])),

          ///order summery
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Summery",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     dashBoardController.selectDrawerIndex.value = 1;
                    //     dashBoardController.pageController.animateToPage(
                    //         dashBoardController.selectDrawerIndex.value,
                    //         duration: const Duration(milliseconds: 300),
                    //         curve: Curves.easeOutExpo);
                    //   },
                    //   child: Text(
                    //     "See All",
                    //     style: AppTextStyles.drawerTextStyle.copyWith(
                    //         fontSize: 18,
                    //         color: Colors.grey,
                    //         fontWeight: FontWeight.normal,
                    //         decoration: TextDecoration.underline),
                    //   ),
                    // ),
                  ],
                )),
            SizedBox(
              height: 105,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  FadeInLeft(
                    duration: 300.ms,
                    child: InkWell(
                      onTap: () {
                        Get.to(const AcceptOrdersScreen(),
                            transition: Transition.upToDown);
                      },
                      child: Container(
                        margin: EdgeInsets.all(6),
                        height: 100,
                        width: Get.width * .28,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Orders",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Accept",
                                  style: AppTextStyles.summeryTextStyle,
                                ),
                                // PullDownButton(
                                //   itemBuilder: (context) => [
                                //     PullDownMenuItem.selectable(
                                //       onTap: () {},
                                //       selected: true,
                                //       title: 'Today',
                                //       icon: CupertinoIcons.circle_fill,
                                //       iconColor: CupertinoColors.systemGreen
                                //           .resolveFrom(context),
                                //     ),
                                //     PullDownMenuItem.selectable(
                                //       onTap: () {},
                                //       selected: false,
                                //       title: 'Tomorrow',
                                //       icon: CupertinoIcons.circle_fill,
                                //       iconColor: CupertinoColors.systemOrange
                                //           .resolveFrom(context),
                                //     ),
                                //     PullDownMenuItem.selectable(
                                //       onTap: () {},
                                //       selected: false,
                                //       title: 'Yesterday',
                                //       icon: CupertinoIcons.circle_fill,
                                //       iconColor: CupertinoColors.systemIndigo
                                //           .resolveFrom(context),
                                //     )
                                //   ],
                                //   buttonBuilder: (context, showMenu) => InkWell(
                                //     onTap: showMenu,
                                //     child: const Icon(
                                //       Icons.arrow_drop_down_outlined,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                            Obx(() {
                              return Text(
                                "${orderController.acceptOrderResponse.value == null ? "0" : orderController.acceptOrderResponse.value!.meta!.totalOrders}",
                                style: AppTextStyles.summeryTextStyle
                                    .copyWith(fontSize: 18),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const PendingOrderScreen(),
                          transition: Transition.upToDown);
                    },
                    child: FadeInLeft(
                      duration: 300.ms,
                      delay: 300.ms,
                      child: Container(
                        margin: EdgeInsets.all(6),
                        height: 100,
                        width: Get.width * .28,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Pending",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Text(
                              "Orders",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Obx(() {
                              return Text(
                                "${orderController.pendingOrderResponse.value == null ? "0" : orderController.pendingOrderResponse.value!.meta!.totalOrders}",
                                style: AppTextStyles.summeryTextStyle
                                    .copyWith(fontSize: 18),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const CompleteOrderScreen(),
                          transition: Transition.upToDown);
                    },
                    child: FadeInLeft(
                      duration: 300.ms,
                      delay: 600.ms,
                      child: Container(
                        margin: EdgeInsets.all(6),
                        height: 100,
                        width: Get.width * .28,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Completed",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Text(
                              "Orders",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Obx(() {
                              return Text(
                                "${orderController.completedOrderList.length}",
                                style: AppTextStyles.summeryTextStyle
                                    .copyWith(fontSize: 18),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const CancelOrdersScreen(),
                          transition: Transition.upToDown);
                    },
                    child: FadeInLeft(
                      duration: 300.ms,
                      delay: 600.ms,
                      child: Container(
                        margin: EdgeInsets.all(6),
                        height: 100,
                        width: Get.width * .28,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Cancel",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Text(
                              "Orders",
                              style: AppTextStyles.summeryTextStyle,
                            ),
                            Obx(() {
                              return Text(
                                orderController.cancelOrderResponse.value ==
                                        null
                                    ? "00"
                                    : "${orderController.cancelOrderResponse.value!.meta!.totalOrders}",
                                style: AppTextStyles.summeryTextStyle
                                    .copyWith(fontSize: 18),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ])),

          ///product category
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10)
              ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pending Orders",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const PendingOrderScreen(),
                            transition: Transition.upToDown);
                      },
                      child: Text(
                        "See All",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )),
          ])),

          ///Pending Order History
          (orderController.pendingOrderResponse.value == null)
              ? SliverList(
                  delegate: SliverChildListDelegate(
                      [Lottie.asset('assets/animation/loadingScreen.json')]))
              : orderController.pendingOrderResponse.value != null &&
                      orderController.pendingOrderList.value.isEmpty
                  ? SliverList(
                      delegate: SliverChildListDelegate(
                          [Lottie.asset('assets/animation/nodata.json')]))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                      final orderModel =
                          orderController.pendingOrderList.value[index];
                      String productInfo = '';
                      for (Items items in orderModel.items ?? []) {
                        productInfo =
                            "$productInfo ${items.productName}:${items.productQuantity}psc ,";
                      }
                      return OrderItemsUI(orderResModel: orderModel, color: Colors.red);
                    },
                          childCount:
                              orderController.pendingOrderList.value.length > 3
                                  ? 3
                                  : orderController.pendingOrderList.length)),

          ///Completed Order History
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 15),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Completed Orders",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const CompleteOrderScreen(),
                            transition: Transition.upToDown);
                      },
                      child: Text(
                        "See All",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )),
          ])),
          orderController.completedOrderList.value.isEmpty
              ? SliverList(
                  delegate: SliverChildListDelegate([
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("No Complete Order History"),
                  ))
                ]))
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                  final orderModel =
                      orderController.completedOrderList.value[index];
                  String productInfo = '';
                  for (Items items in orderModel.items ?? []) {
                    productInfo =
                        "$productInfo ${items.productName}:${items.productQuantity}psc ,";
                  }
                  return OrderItemsUI(orderResModel: orderModel, color: Colors.green);
                },
                      childCount:
                          orderController.completedOrderList.value.length)),
          ///Completed Order History
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 15),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Accept Orders",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const AcceptOrdersScreen(),
                            transition: Transition.upToDown);
                      },
                      child: Text(
                        "See All",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )),
          ])),
          orderController.acceptOrderList.value.isEmpty
              ? SliverList(
                  delegate: SliverChildListDelegate([
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("No Accept Order History"),
                  ))
                ]))
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                  final orderModel =
                      orderController.acceptOrderList.value[index];
                  String productInfo = '';
                  for (Items items in orderModel.items ?? []) {
                    productInfo =
                        "$productInfo ${items.productName}:${items.productQuantity}psc ,";
                  }
                  return OrderItemsUI(orderResModel: orderModel, color: Colors.green);
                },
                      childCount:
                          orderController.acceptOrderList.value.length)),

          ///invoices
          SliverList(delegate: SliverChildListDelegate([
            SizedBox(height: 100,)
          ]))
        ],
        // ),
      );
    });
  }
}
