import 'dart:developer';

import 'package:fgi_y2j/config/theme/themes.dart';
import 'package:fgi_y2j/features/profile/screen/CartNumberEdit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../config/style/app_colors.dart';
import '../component/ProfileTile.dart';
import '../component/menuTile.dart';
import 'edit_profile_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const EditProfilePage(),transition: Transition.rightToLeftWithFade);
              },
              icon: const Icon(
                Icons.edit,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              duration: 100.ms,
              text: "Account",
              icon: Icons.person,
              press: (){
                Get.to(const EditProfilePage(),transition: Transition.rightToLeftWithFade);
              },
            ),
            ProfileMenu(
              duration: 200.ms,
              text: "Cart Information",
              icon: CupertinoIcons.bell,
              press: () {
                Get.to(const CartNumberEdit(),transition: Transition.rightToLeftWithFade);

              },
            ),
            ProfileMenu(
              duration: 300.ms,
              text: "Settings",
              icon: CupertinoIcons.settings,
              press: (){

              },
            ),
            ProfileMenu(
              duration: 400.ms,
              text: "Help",
              icon: Icons.help,
              press: () {
              },
            ),
            ProfileMenu(
              duration: 500.ms,
              text: "Logout",
              icon: Icons.login,
              press: () async {
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: const Center(
                child: Text(
                  "Agree With Term & Conditions & Privacy Policy",
                  style: TextStyle(color: Colors.grey,fontSize: 12),
                ),
              ),
            ),

            SizedBox(height: Get.height*.4,)
          ],
        ),
      ),
    );
  }
}
