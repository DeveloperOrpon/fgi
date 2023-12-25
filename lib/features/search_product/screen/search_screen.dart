import 'dart:developer';
import 'package:async/async.dart';
import 'package:fgi_y2j/features/notification/controller/notificationController.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:fgi_y2j/features/view_products/Model/ProductRes.dart';
import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/route.dart';
import '../../../config/style/app_colors.dart';
import '../../view_products/component/single_product_ui.dart';
import '../component/searchProductUi.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int page=1;
  final allProductController=Get.put(AllProductController());
  final notificationController=Get.put(AppNotificationController());
  final cartController=Get.put(CartController());
  List<ProductModel> searchProductList=<ProductModel>[];
  final searchController=TextEditingController();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(

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
        body: SmartRefresher(
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
          controller: allProductController.refreshSearchController,
          onRefresh: () {
            page=1;
            _searchProduct('');
            Future.delayed(Duration(seconds: 1),() {
              allProductController.refreshSearchController.refreshCompleted();
            },);
          },
          onLoading: () {
            page++;
            _searchProduct('');
            Future.delayed(Duration(seconds: 1),() {
              allProductController.refreshSearchController.loadComplete();
            },);
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              ///home
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {

                      log("InPut^ ^ $value");
                      _searchProduct(value);
                    },
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
                ),
                   if (searchProductList.isEmpty &&!isLoading)
                      Lottie.asset('assets/animation/nodata.json'),
                    if(searchProductList.isEmpty &&isLoading)
                    Lottie.asset('assets/animation/loadingScreen.json')
              ])),

              ///product
             if(searchProductList.isNotEmpty) SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>  SearchProductUI(
                      productModel:searchProductList[index] ,
                    ),
                    childCount: searchProductList.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 270,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5)),
            ],
          ),
        ),
      ),
    );
  }
  RestartableTimer? timer;
  static const timeout = Duration(milliseconds: 1500);
  _searchProduct(String newQuery) {

    if(timer == null){
      timer = RestartableTimer(timeout, (){
        if(page==1){
            searchProductList=[];
        }
        setState(() {
          isLoading=true;
        });
        log("newQuery: ${searchController.text.trim()}");
        allProductController.searchProduct(searchController.text.trim(), page).then((value){
          log("search Data: ${value!.data!.length}");
          if(page==1){
            setState(() {
              isLoading=false;
              searchProductList=value!.data??[];
            });
          }else{
            setState(() {
              isLoading=false;
              searchProductList.addAll(value!.data??[]);
            });
          }
        });
      });
    }else{
      timer?.reset();
    }
  }

}
