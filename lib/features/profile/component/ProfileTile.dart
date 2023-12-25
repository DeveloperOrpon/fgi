import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/profile/controller/profileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../authentication/controller/AuthenticationController.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthenticationController());

    final profileController=Get.put(ProfileController());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Obx((){
                  return CachedNetworkImage(
                    height: 110,
                    fit: BoxFit.cover,
                    width: Get.width * .5,
                    imageUrl: authController.userModel.value!.profilePicture ??
                        "",
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                          Border.all(color: AppColors.primary, width: .5)),
                      child: Center(
                        child: Text(
                          "$appName",
                          style: TextStyle(color: Colors.grey.shade200),
                        ),
                      ),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                    const SpinKitFoldingCube(
                      color: AppColors.primary,
                      size: 50.0,
                    ),
                    imageBuilder: (context, imageProvider) =>               CircleAvatar(

                      backgroundImage:imageProvider,
                      backgroundColor: AppColors.primary,
                    ).animate().scaleXY() ,
                  );
                }
              ),

              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.white),
                      ),
                      primary: Colors.white,
                      backgroundColor: const Color(0xFFF5F6F9),
                    ),
                    onPressed: () {
                      profileController.pickImage(context: context);
                    },
                    child: const Icon(CupertinoIcons.photo_camera_solid,color: Colors.black,),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
         Obx(() {
             return Text("${authController.userModel.value!.firstName} ${authController.userModel.value!.lastName}",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold),).animate().blurXY(begin:5,end: 0 );
           }
         ),
    const SizedBox(height: 5),
         Obx(() {
             return Text("${authController.userModel.value!.email}",
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
        ).animate().blurXY(begin:5,end: 0 );
           }
         ),
      ],
    );
  }
}
