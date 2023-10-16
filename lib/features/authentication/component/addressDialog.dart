import 'dart:developer';
import 'dart:ui';

import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showAddressBottomSheet(BuildContext context) {
  final authController = Get.put(AuthenticationController());
  showCupertinoModalPopup(
    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
    context: context,
    builder: (context) {
      return Container(
        height: Get.height * .3,
        width: Get.width,
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.primary, width: 2, style: BorderStyle.solid),
            color: CupertinoColors.black,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            image: const DecorationImage(
                image: AssetImage('assets/images/image3.png'),
                opacity: .3,
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ListWheelScrollView(
                        onSelectedItemChanged: (value) {
                          authController.selectDivision.value =
                              (authController.divisionsRes.divisions![value]);
                          authController.selectDistrict.value = authController.districtRes.districts!.where((element) => element.divisionId==authController.selectDivision.value!.id).toList()[0];

                        },
                        itemExtent: 40,
                        diameterRatio: 1.6,
                        offAxisFraction: -0.4,
                        squeeze: 0.8,
                        clipBehavior: Clip.antiAlias,
                        children: authController.divisionsRes.divisions!
                            .map((e) => Obx(() {
                                  return Text(
                                    e.name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color:
                                                authController.selectDivision.value !=
                                                            null &&
                                                        authController.selectDivision
                                                                .value!.name ==
                                                            e.name!
                                                    ? AppColors.strongAmer
                                                    : CupertinoColors.white),
                                  );
                                }))
                            .toList()),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    width: 2,
                    color: AppColors.strongAmer,
                  ),
                  Expanded(
                    child: Obx(() {
                        return ListWheelScrollView(
                            onSelectedItemChanged: (value) {

                              authController.selectDistrict.value = authController.districtRes.districts!.where((element) => element.divisionId==authController.selectDivision.value!.id).toList()[value];
                            },
                            itemExtent: 40,
                            diameterRatio: 1.6,
                            offAxisFraction: -0.4,
                            squeeze: 0.8,
                            clipBehavior: Clip.antiAlias,
                            children: authController.selectDivision.value != null
                                ? authController.districtRes.districts!.where((element) => element.divisionId==authController.selectDivision.value!.id).toList()
                                    .map((e) => Obx(() {
                                          return Text(
                                            e.name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    color: authController.selectDistrict
                                                                    .value !=
                                                                null &&
                                                            authController.selectDistrict
                                                                    .value!.name ==
                                                                e.name!
                                                        ? AppColors.strongAmer
                                                        : CupertinoColors.white),
                                          );
                                        }))
                                    .toList()
                                : []);
                      }
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(child: Text("Selected"), onPressed: () {
              if(authController.selectDistrict.value==null || authController.selectDivision.value==null){
                showErrorDialog("Warning", "Please Select A Location", context);
                return;
              }
              Get.back();
            })
          ],
        ),
      );
    },
  );
}
