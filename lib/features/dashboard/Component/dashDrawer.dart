import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../config/style/text_style.dart';
import '../controller/dashboardController.dart';

class DashDrawer extends StatelessWidget {
  const DashDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.put(DashBoardController());
    final authController = Get.put(AuthenticationController());
    return SlideInLeft(
      child: Drawer(
        width: Get.width * .74,
        backgroundColor: Colors.white,
        elevation: 5,
        child: Container(
          height: Get.height,
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [

              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(CupertinoIcons.xmark)),
              ),
              const CircleAvatar(radius: 50),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${authController.userModel.value!.firstName!} ${authController.userModel.value!.firstName!}"),
                ),
              ),Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text("${authController.userModel.value!.email!}"),
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              ...dashBoardDrawerOption.map((e) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Obx(() {
                      return ListTile(
                        onTap: () {
                          if (dashBoardController.selectDrawerIndex.value ==
                              e['index']) {
                            Get.back();
                            return;
                          }
                          if (e['title'] == 'Log out') {
                            Get.back();
                            authController.logout();
                            return;
                          } else {
                            Get.back();
                            dashBoardController.selectDrawerIndex.value =
                                e['index'] as int;
                            Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                dashBoardController.pageController
                                    .animateToPage(
                                        dashBoardController
                                            .selectDrawerIndex.value,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOutExpo);
                              },
                            );
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
                                      dashBoardController
                                          .selectDrawerIndex.value
                                  ? FontWeight.w500
                                  : FontWeight.normal),
                        ),
                      );
                    }),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
