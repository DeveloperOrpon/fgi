import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/style/text_style.dart';

class ProductFilterDrawer extends StatelessWidget {
  const ProductFilterDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideInRight(

      child: Container(
        padding: const EdgeInsets.all(20),
        width: Get.width * .8,
        height: Get.height,
       decoration: BoxDecoration(
         color: Colors.white,
         border: Border.all(color: Colors.grey.shade200,width: 1),
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(20),
           bottomLeft: Radius.circular(20),

         )
       ),
        child: SafeArea(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Filter", style: AppTextStyles.drawerTextStyle.copyWith(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),
            IconButton(onPressed: () {
              Get.back();
            }, icon: const Icon(CupertinoIcons.xmark))
          ],
        ),
            Text("Select Brand", style: AppTextStyles.drawerTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
            const SizedBox(height: 8),
            Expanded(child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 60, mainAxisSpacing: 10,crossAxisSpacing: 5),itemBuilder:(context, index) =>
                      Container(decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(8)),)
            ,itemCount: 4,physics: const BouncingScrollPhysics(),)),
            const SizedBox(height: 8),

            Text("Select Category", style: AppTextStyles.drawerTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
            const SizedBox(height: 8),

            Expanded(child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 60, mainAxisSpacing: 10,crossAxisSpacing: 5),itemBuilder:(context, index) =>
                Container(decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(8)),)
              ,itemCount: 4,physics: const BouncingScrollPhysics(),)),
            const SizedBox(height: 8),

            Text("Select Sub-Category",style: AppTextStyles.drawerTextStyle.copyWith(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black),),
            const SizedBox(height: 8),

            Expanded(child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 60, mainAxisSpacing: 10,crossAxisSpacing: 5),itemBuilder:(context, index) =>
                Container(decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(8)),)
              ,itemCount: 4,physics: const BouncingScrollPhysics(),)),
            const SizedBox(height: 8),

          ],
            )),
      ),
    );
  }
}
