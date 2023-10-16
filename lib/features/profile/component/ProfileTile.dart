import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/profile/controller/profileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const CircleAvatar(

                backgroundImage:
                AssetImage("assets/images/image1.png"),
                backgroundColor: AppColors.primary,
              ).animate().scaleXY(),
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
                      profileController.pickImage();
                    },
                    child: const Icon(CupertinoIcons.photo_camera_solid,color: Colors.black,),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text("Mofizol Hasan Arpon",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold),).animate().blurXY(begin:5,end: 0 ),
    const SizedBox(height: 5),
        const Text("developeropon@gmail.com",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal),
        ).animate().blurXY(begin:5,end: 0 ),
      ],
    );
  }
}
