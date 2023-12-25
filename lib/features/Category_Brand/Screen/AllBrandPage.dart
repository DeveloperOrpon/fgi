import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/BrandRes.dart';
import 'package:fgi_y2j/features/shopping_cart/controller/cartController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/config.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import '../Model/CategoryRes.dart';
import 'BrandCatProduct.dart';
import 'CategoryByProductScreen.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String catDemo =
        "https://www.insidevancouver.ca/wp-content/uploads/2022/07/Praguery7-664x830.jpeg";

    final categoryController=Get.put(CategoryController());
    final cartController=Get.put(CartController());
    return Scaffold(

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

        title: const Text("All Brands"),
        actions: [
          IconButton(
              onPressed: () {
                AppRoute().notificationScreen();
              },
              icon: const Icon(
                CupertinoIcons.bell,
                color: Colors.black,
              )),
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
        controller: categoryController.allBrandsRefreshController,
        onRefresh: () {
          printLog("onRefresh");
          categoryController.onAllBrandRefreshPage();
        },
        onLoading: () {
          printLog("onLoading");
          categoryController.onAllBrandLoadingPage();
        },
        child:Obx(() => categoryController.brandRes.value!=null && categoryController.brandList.value.isEmpty?Center(
          child: Lottie.asset(
            'assets/animation/nodata.json',

            fit: BoxFit.fill,
          ),
        ): categoryController.brandRes.value==null && categoryController.brandList.value.isEmpty?Lottie.asset(
          'assets/animation/loadingScreen.json',

          fit: BoxFit.fill,
        ):CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 150,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                BrandModel brandModel =
                categoryController.brandList[index];
                return InkWell(
                  onTap: () {
                    Get.to(
                        BrandCatProduct(
                          brandModel: brandModel,
                        ),
                        transition: Transition.upToDown);
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primary,width: .5)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            height: 150,
                            width: Get.width * .3,
                            fit: BoxFit.cover,
                            imageUrl: brandModel.brandImage ?? '',
                            errorWidget: (context, url, error) =>
                                Center(child: Text("$appName",style: TextStyle(color: Colors.grey.shade400))),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                            const SpinKitFoldingCube(
                              color: AppColors.primary,
                              size: 50.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                ],
                                stops: [
                                  .4,
                                  1
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            brandModel.brandLabel ?? 'No Name',
                            style: AppTextStyles.summeryTextStyle
                                .copyWith(letterSpacing: .5,fontWeight: FontWeight.normal,fontSize: 12)
                          ),
                        ),
                      )
                    ],
                  ),
                ).animate().blurXY(begin:5,end: 0 );
              },
              itemCount: categoryController.brandList.length,
            )
          ],
        )),
      ),
    );
  }
}
