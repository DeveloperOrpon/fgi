import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/config/extend/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/style/app_colors.dart';
import '../../Dialog/Authentication_Message.dart';

class CartNumberEdit extends StatelessWidget {
  const CartNumberEdit({super.key});

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("Cart Number"),

      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const Icon(CupertinoIcons.creditcard_fill,color: Colors.blue,size: 100,),
              SlideInLeft(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 50,
                        decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            )
                        ),
                        child: const Icon(CupertinoIcons.creditcard,size: 20,color: Colors.black,),
                      ),
                      labelText: 'Old Cart Number',
                      labelStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 14),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,

                      //
                    ),
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'Input Valid Cart Minimum Six(3) digit';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SlideInRight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 50,
                        decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            )
                        ),
                        child: const Icon(CupertinoIcons.creditcard,size: 20,color: Colors.black),
                      ),
                      labelText: 'New Cart Number',
                      labelStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 14),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,

                      //
                    ),
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'Input Valid Cart Minimum Six(3) digit';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BounceInUp(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CupertinoButton.filled(
              onPressed: () async {
                showInformationToastTop(
                    "Information", "Profile Update Is Maintenance", context);
              },
              child: Text(
                "Update",
                style: GoogleFonts.robotoMono(),
              )),
        ),
      ),
    );

  }
}
