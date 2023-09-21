import 'dart:developer';
import 'dart:ui';

import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../../constants/data/citiesRes.dart';
import '../../../constants/data/divisionJson.dart';

class AuthenticationController extends GetxController {
  Rxn<Divisions>selectDivision = Rxn<Divisions>();
  Rxn<Districts> selectDistrict = Rxn<Districts>();
  RxBool isShowCompany = RxBool(false);
  RxInt timelineIndex = RxInt(0);
  DivisionsRes divisionsRes = DivisionsRes.fromJson(division);
  DistrictRes districtRes = DistrictRes.fromJson(districts);

  showAddressBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      context: context,
      builder: (context) {
        return Container(
          height: Get.height * .3,
          width: Get.width,
          decoration: BoxDecoration(
              color: CupertinoColors.black,
              image: DecorationImage(
                  image: AssetImage('assets/images/image3.png'),
                  opacity: .3,
                  fit: BoxFit.cover)),
          child: Row(
            children: [
              Expanded(
                child: ListWheelScrollView(
                  onSelectedItemChanged: (value) {

                    selectDivision.value=(divisionsRes.divisions![value]);
                  },
                    itemExtent: 40,
                    diameterRatio: 1.6,
                    offAxisFraction: -0.4,
                    squeeze: 0.8,
                    clipBehavior: Clip.antiAlias,
                    children: divisionsRes.divisions!
                        .map((e) => Obx((){
                            return Text(
                                  e.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color:selectDivision.value!=null && selectDivision.value!.name==e.name!?AppColors.strongAmer: CupertinoColors.white),
                                );
                          }
                        ))
                        .toList()),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                width: 2,
                color: AppColors.strongAmer,
              ),
              Expanded(
                child: ListWheelScrollView(
                    onSelectedItemChanged: (value) {
                      selectDistrict.value=(districtRes.districts![value]);
                    },
                    itemExtent: 40,
                    diameterRatio: 1.6,
                    offAxisFraction: -0.4,
                    squeeze: 0.8,
                    clipBehavior: Clip.antiAlias,
                    children: districtRes.districts!
                        .map((e) => Obx((){
                            return Text(
                                  e.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color:selectDistrict.value!=null && selectDistrict.value!.name==e.name!?AppColors.strongAmer: CupertinoColors.white),
                                );
                          }
                        ))
                        .toList()),
              ),
            ],
          ),
        );
      },
    );
  }
}
