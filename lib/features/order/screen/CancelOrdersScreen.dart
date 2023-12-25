import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/features/shopping_cart/model/OrderRes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/config.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../invoice/screen/InvoiceScreenPreview.dart';
import '../../notification/controller/notificationController.dart';
import '../../search_product/screen/search_screen.dart';
import '../../shopping_cart/controller/cartController.dart';
import '../component/ItemsUiList.dart';
import '../controller/orderController.dart';

class CancelOrdersScreen extends StatelessWidget {
  const CancelOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final notificationController=Get.put(AppNotificationController());
    final orderController=Get.put(OrderController());
    if(orderController.cancelOrderResponse.value==null){
      orderController.cancelOrderInformation(1);
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BounceInUp(
        child: FloatingActionButton.extended(
            backgroundColor: Color(0xFFF1C700),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: () {},
            label: Row(
              children: [
                const SizedBox(width: 5),
                const Icon(FontAwesomeIcons.cartShopping),
                const SizedBox(width: 10),
                Text(
                  'Add new order',
                  style: AppTextStyles.drawerTextStyle.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.black),
                ),
                const SizedBox(width: 5),
              ],
            )),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios_new)),

        title: const Text("Cancel Orders"),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    AppRoute().notificationScreen();
                  },
                  icon: const Icon(
                    CupertinoIcons.bell,
                    color: Colors.black,
                  )),
              Obx(() {
                return notificationController.countUnRead().isGreaterThan(0)
                    ? Positioned(
                  top: 0,
                  right: 5,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Center(
                      child: Text(
                        "${notificationController.countUnRead()}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                )
                    : Center();
              })
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    onPressed: () {
                      AppRoute().cartPage();
                    },
                    icon: const Icon(
                      CupertinoIcons.shopping_cart,
                      color: Colors.black,
                    )),
              ),
              Obx(() {
                return cartController.cartItems.value.isNotEmpty
                    ? Positioned(
                  top: 0,
                  right: 5,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Center(
                      child: Text(
                        "${cartController.cartItems.length}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                )
                    : Center();
              })
            ],
          )
        ],
      ),
      body: Obx(() {
          return SmartRefresher(
            physics: const BouncingScrollPhysics(),
            enablePullDown: true,
            enablePullUp: true,
            header: const WaterDropHeader(
              waterDropColor: AppColors.primary,
              refresh: CupertinoActivityIndicator(color:  AppColors.black,radius: 15,),
            ),
            footer: CustomFooter(
              builder: (context, mode){
                Widget body ;
                if(mode==LoadStatus.idle){
                  body =  const Text("Pull up load");
                }
                else if(mode==LoadStatus.loading){
                  body =  const CupertinoActivityIndicator();
                }
                else if(mode == LoadStatus.failed){
                  body = const Text("Load Failed!Click retry!");
                }
                else if(mode == LoadStatus.canLoading){
                  body = const Text("release to load more");
                }
                else{
                  body = const Text("No more Data");
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child:body),
                );
              },
            ),
            controller: orderController.refreshCancelController,
            onRefresh: () {
              printLog("onRefresh");
              orderController.onRefreshCancelPage();
            },
            onLoading: () {
              printLog("onLoading");
              orderController.onLoadingCancelPage();
            },
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                ///Pending Order History
                SliverList(
                    delegate: SliverChildListDelegate([
                      // const SizedBox(height: 15),
                      Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx((){
                                  return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Cancel Order's :",
                                        style: GoogleFonts.robotoMono(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),TextSpan(
                                        text:
                                        orderController.cancelOrderResponse.value==null?"0": "  ${orderController.cancelOrderResponse.value!.meta!.totalOrders}(Orders)",

                                        style: GoogleFonts.robotoMono(
                                            fontSize: 18,
                                            color: AppColors.primary,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ]
                                  ),
                                  );
                                }
                              ),
                            ],
                          )),
                    ])),
                (orderController.cancelOrderResponse.value==null)?
                SliverList(delegate: SliverChildListDelegate([
                  Lottie.asset('assets/animation/loadingScreen.json')
                ])):orderController.cancelOrderResponse.value!=null && orderController.cancelOrderList.value.isEmpty?
                SliverList(delegate: SliverChildListDelegate([
                  Lottie.asset('assets/animation/nodata.json')
                ]))
                    :SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final orderModel=orderController.cancelOrderList.value[index];
                      String productInfo='';
                      for(Items items in orderModel.items??[]){
                        productInfo="$productInfo ${items.productName }:${items.productQuantity}psc ,";
                      }
                      return  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: OrderItemsUI(orderResModel: orderModel,color: AppColors.red,),
                      );
                    },childCount: orderController.cancelOrderList.value.length)),

              ],
            ),
          );
        }
      ),
    );
  }
}
