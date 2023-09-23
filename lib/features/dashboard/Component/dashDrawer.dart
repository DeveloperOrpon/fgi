import 'package:fgi_y2j/features/dashboard/screen/DashboardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../config/style/text_style.dart';
import '../../order/screen/OrderHistoryScreen.dart';
import '../../view_products/screen/AllProductScreen.dart';
import '../controller/dashboardController.dart';

class DashDrawer extends StatelessWidget {
  const DashDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.put(DashBoardController());
    return Drawer(
      width: Get.width * .74,
      backgroundColor: Colors.white,
      elevation: 5,
      child: Container(
        height: Get.height,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * .05,
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: IconButton(onPressed: () {
                Get.back();
              }, icon: const Icon(CupertinoIcons.xmark)),
            ),
            ...dashBoardDrawerOption.map((e) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Obx(() {
                    return ListTile(
                      onTap: () {
                        dashBoardController.selectDrawerIndex.value =
                            e['index'] as int;
                        if( e['index']==1){
                          dashBoardController.selectDrawerIndex.value=1;
                          Get.offAll(const OrderHistoryScreen(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 600));
                        }if( e['index']==2){
                          dashBoardController.selectDrawerIndex.value=2;
                          Get.offAll(const AllProductScreen(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 600));
                        }else{
                          dashBoardController.selectDrawerIndex.value=0;
                          Get.offAll(const DashboardScreen(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 600));
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: e['index'] ==
                              dashBoardController.selectDrawerIndex.value
                          ? Colors.grey.shade100
                          : Colors.white,
                      leading: Icon(e['icon'] as IconData?),
                      title: Text(
                        "${e['title']}",
                        style: AppTextStyles.drawerTextStyle.copyWith(
                            fontWeight: e['index'] ==
                                    dashBoardController.selectDrawerIndex.value
                                ? FontWeight.w500
                                : FontWeight.normal),
                      ),
                    );
                  }),
                )),
            // Expanded(
            //   child: Container(
            //     alignment: Alignment.bottomCenter,
            //     child: FutureBuilder(
            //       future: PackageInfo.fromPlatform(),
            //
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting){
            //           return const CupertinoActivityIndicator();
            //         }
            //         if (snapshot.hasError) {
            //           return Center(
            //             child: Text(
            //               '${snapshot.error} occurred',
            //               style: TextStyle(fontSize: 18),
            //             ),
            //           );
            //
            //           // if we got our data
            //         }
            //         return Text("Version : ${snapshot.data!.version??""}",
            //             style: AppTextStyles.drawerTextStyle);
            //       }
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
