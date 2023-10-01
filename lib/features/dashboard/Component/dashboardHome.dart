import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/features/order/controller/orderController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';
import '../../Category/Screen/CategoryByProductScreen.dart';
import '../../order/screen/CompleteOrdersScreen.dart';
import '../../order/screen/PendingOrdersScreen.dart';
import '../controller/dashboardController.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.put(DashBoardController());
    final orderController = Get.put(OrderController());
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
      controller: dashBoardController.refreshController,
      onRefresh: () {
        printLog("onRefresh");
        dashBoardController.onRefreshPage();
      },
      onLoading: () {
        printLog("onLoading");
        dashBoardController.onLoadingPage();
      },
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                  filled: true,
                  fillColor: Colors.grey.shade200,
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
                        InkWell(
                          onTap: () {
                            dashBoardController.selectDrawerIndex.value=1;
                            dashBoardController.pageController.animateToPage( dashBoardController.selectDrawerIndex.value, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);

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
                Row(
                  children: [
                    Expanded(
                      child: FadeInLeft(
                        duration: 300.ms,
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Total Orders",
                                style: AppTextStyles.summeryTextStyle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "(Today)",
                                    style: AppTextStyles.summeryTextStyle,
                                  ),
                                  PullDownButton(
                                    itemBuilder: (context) => [
                                      PullDownMenuItem.selectable(
                                        onTap: () {},
                                        selected: true,
                                        title: 'Today',
                                        icon: CupertinoIcons.circle_fill,
                                        iconColor: CupertinoColors.systemGreen
                                            .resolveFrom(context),
                                      ),
                                      PullDownMenuItem.selectable(
                                        onTap: () {},
                                        selected: false,
                                        title: 'Tomorrow',
                                        icon: CupertinoIcons.circle_fill,
                                        iconColor: CupertinoColors.systemOrange
                                            .resolveFrom(context),
                                      ),
                                      PullDownMenuItem.selectable(
                                        onTap: () {},
                                        selected: false,
                                        title: 'Yesterday',
                                        icon: CupertinoIcons.circle_fill,
                                        iconColor: CupertinoColors.systemIndigo
                                            .resolveFrom(context),
                                      )
                                    ],
                                    buttonBuilder: (context, showMenu) => InkWell(
                                      onTap: showMenu,
                                      child: const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "30",
                                style: AppTextStyles.summeryTextStyle
                                    .copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(const PendingOrderScreen(),transition:Transition.upToDown);
                        },
                        child: FadeInLeft(
                          duration: 300.ms,
                          delay: 300.ms,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
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
                                Text(
                                  "02",
                                  style: AppTextStyles.summeryTextStyle
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child:  InkWell(
                        onTap: () {
                          Get.to(const CompleteOrderScreen(),transition:Transition.upToDown);
                        },
                        child: FadeInLeft(
                          duration: 300.ms,
                          delay: 600.ms,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 100,
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
                                Text(
                                  "15",
                                  style: AppTextStyles.summeryTextStyle
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
          ])),

          ///product category
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                dashBoardController.selectDrawerIndex.value=2;
                dashBoardController.pageController.animateToPage( dashBoardController.selectDrawerIndex.value, duration: const Duration(milliseconds: 300), curve: Curves.easeOutExpo);

              },
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product categories",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "See All",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  )),
            ),
          ])),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisExtent: 160, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(CategoryByProductScreen(categoryName: demoCategories[index]['name'],),transition: Transition.upToDown);
                },
                child: BounceInUp(
                  delay: (200+(100*index)).ms,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            demoCategories[index]['url'],
                            height: 160,
                            width: Get.width*.3,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(colors: [
                            Colors.transparent,Colors.black,
                          ],stops: [.4,1],begin: Alignment.topCenter,end: Alignment.bottomCenter)
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.bottomCenter,
                        child: Text( demoCategories[index]['name'],style:  AppTextStyles.summeryTextStyle,),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: demoCategories.length,
          )
        ],
      ),
    );
  }
}
