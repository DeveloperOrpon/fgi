import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/config/extend/string.dart';
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/Category_Brand/Model/BrandRes.dart';
import 'package:fgi_y2j/features/profile/controller/profileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../Dialog/Authentication_Message.dart';
import '../../authentication/controller/AuthenticationController.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final profileController = Get.put(ProfileController());
  final authenticationController = Get.put(AuthenticationController());
  final categoryController = Get.put(CategoryController());
  final emailController = TextEditingController();
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final zipController = TextEditingController();
  BrandModel? selectBrandModel;

  @override
  void initState() {
    profileController.pickImagePath.value = null;
    initUserData();
    super.initState();
  }

  initUserData() {
    emailController.text =
        '${authenticationController.userModel.value!.email ?? ""}';
    firstController.text =
        '${authenticationController.userModel.value!.firstName}';
    lastController.text =
        '${authenticationController.userModel.value!.lastName}';
    phoneController.text='${authenticationController.userModel.value!.phoneNumber}';
    zipController.text = '${authenticationController.userModel.value!.zipCode}';
    addressController.text =
        authenticationController.userModel.value!.location ?? "";
  }

  @override
  Widget build(BuildContext context) {
    log("EditProfilePage ");
    EasyLoading.dismiss();
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
        title: const Text("Edit Profile"),
      ),
      body: Form(
        key: profileController.profileEditFormKey,
        child: Center(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              BounceInDown(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Obx(() =>
                                profileController.pickImagePath.value == null
                                    ? CachedNetworkImage(
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            authenticationController.userModel.value!.profilePicture??"",
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                const SpinKitSpinningLines(
                                          color: AppColors.primary,
                                          size: 50.0,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          profileController.pickImage(context:context );
                                        },
                                        child: Image.file(
                                          File(profileController
                                              .pickImagePath.value!),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                          ),
                        ),
                        const SizedBox(height: 14),
                        RichText(
                          text: TextSpan(
                            text: 'Joined ',
                            style: DefaultTextStyle.of(context).style,
                            children: const [
                              TextSpan(
                                text: "12PM,12-5-2023",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 40,
                      right: 0,
                      left: 100,
                      child: CircleAvatar(
                        radius: 18,
                        child: IconButton(
                          splashColor: AppColors.primary,
                          onPressed: () {
                            profileController.pickImage(context: context);
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SlideInLeft(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        enabled: false,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 50,
                            decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )),
                            child: const Icon(
                              Icons.email,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                          labelText: 'Email Address',
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
                          if (value!.length < 3 || !value!.isValidEmail()) {
                            return 'Input Valid Email Minimum Six(3) digit';
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
                        controller: firstController,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 50,
                            decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )),
                            child: const Icon(FontAwesomeIcons.user,
                                size: 20, color: Colors.black),
                          ),
                          labelText: 'First Name',
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
                            return 'Input Valid First Minimum Six(3) digit';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SlideInLeft(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: lastController,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 50,
                            decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )),
                            child: const Icon(FontAwesomeIcons.user,
                                size: 20, color: Colors.black),
                          ),
                          labelText: 'Last Name',
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
                            return 'Input Valid Last Minimum Six(3) digit';
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
                        controller: phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 50,
                            decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )),
                            child: const Icon(FontAwesomeIcons.phone,
                                size: 20, color: Colors.black),
                          ),
                          labelText: 'Phone Number',
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
                            return 'Input Valid Phone Number Minimum Six(8) digit';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SlideInLeft(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 50,
                            decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )),
                            child: const Icon(FontAwesomeIcons.addressBook,
                                size: 20, color: Colors.black),
                          ),
                          labelText: 'Information Address',
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
                            return 'Input Valid Address Number Minimum Six(8) digit';
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
                        controller: zipController,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 50,
                            decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )),
                            child: const Icon(FontAwesomeIcons.code,
                                size: 20, color: Colors.black),
                          ),
                          labelText: 'Zip Code',
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
                            return 'Input Valid Zip COde Minimum Six(3) digit';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // SlideInLeft(
                  //   child: InkWell(
                  //     onTap: () {
                  //       showCupertinoModalPopup(
                  //         barrierDismissible: true,
                  //         builder: (context) => Container(
                  //           color: Theme.of(context).scaffoldBackgroundColor,
                  //           height: 120,
                  //           child: CupertinoPicker(
                  //             itemExtent: 32,
                  //             onSelectedItemChanged: (value) {
                  //               setState(() {
                  //                 selectBrandModel =
                  //                     categoryController.brandList[value];
                  //               });
                  //             },
                  //             children: categoryController.brandList.value
                  //                 .map((brand) => Center(
                  //                       child: Text(
                  //                         brand.brandLabel ?? "",
                  //                         style: const TextStyle(
                  //                             color: Colors.black87,
                  //                             fontSize: 13),
                  //                       ),
                  //                     ))
                  //                 .toList(),
                  //           ),
                  //         ),
                  //         context: context,
                  //       );
                  //     },
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         border:
                  //             Border.all(color: AppColors.primary, width: .5),
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       margin: const EdgeInsets.symmetric(horizontal: 16),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           SizedBox(
                  //             width: 60,
                  //             height: 50,
                  //             child: Container(
                  //                 margin: const EdgeInsets.only(right: 10),
                  //                 decoration: const BoxDecoration(
                  //                   color: AppColors.primary,
                  //                   borderRadius: BorderRadius.only(
                  //                     bottomLeft: Radius.circular(10),
                  //                     topLeft: Radius.circular(10),
                  //                   ),
                  //                 ),
                  //                 child: const Icon(
                  //                   CupertinoIcons.command,
                  //                   size: 25,
                  //                   color: AppColors.white,
                  //                 )),
                  //           ),
                  //           Expanded(
                  //             child: Text(
                  //                 selectBrandModel != null
                  //                     ? selectBrandModel!.brandLabel!
                  //                     : authenticationController.userModel
                  //                             .value!.company!.isNotEmpty
                  //                         ? "Chose Company"
                  //                         : authenticationController
                  //                             .userModel.value!.company!,
                  //                 style: AppTextStyles.boldstyle.copyWith(
                  //                     fontSize: 14,
                  //                     color: AppColors.black,
                  //                     fontWeight: FontWeight.normal)),
                  //           ),
                  //           Container(
                  //             width: 60,
                  //             height: 50,
                  //             decoration: BoxDecoration(
                  //               color: Colors.white.withOpacity(.25),
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: Obx(() {
                  //               return authenticationController
                  //                       .isShowCompany.value
                  //                   ? const Icon(
                  //                       Icons.arrow_drop_up_outlined,
                  //                       color: Colors.black,
                  //                     )
                  //                   : const Icon(
                  //                       Icons.arrow_drop_down_outlined,
                  //                       color: AppColors.black,
                  //                     );
                  //             }),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Text(
                  //   "You Are In : ${authenticationController.userModel.value!.company??""}",
                  //   style: TextStyle(color: Colors.grey, fontSize: 10),
                  // ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: const Center(
                      child: Text(
                        "Agree With Term & Conditions & Privacy Policy",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BounceInUp(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CupertinoButton.filled(
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (profileController.profileEditFormKey.currentState!
                    .validate()) {
                  if (authenticationController
                          .userModel.value!.company!.isEmpty &&
                      selectBrandModel == null) {
                    showInformationToastTop("Information",
                        "Profile Update Is Maintenance", context);
                    return;
                  }
                  startLoading("Please Wait");
                  Map<String, dynamic> userUpdateMap = {
                    "company": selectBrandModel == null
                        ? authenticationController.userModel.value!.company
                        : selectBrandModel!.brandLabel,
                    "location": addressController.text.trim(),
                    "zipCode": zipController.text,
                    "firstName": firstController.text.trim(),
                    "lastName": lastController.text.trim(),
                    "phoneNumber": phoneController.text.trim(),
                    "email": emailController.text.trim()
                  };
                  authenticationController
                      .userUpdate(userUpdateMap, context)
                      .then((value) {
                    if (value) {
                      EasyLoading.dismiss();
                      showSuccessToastTop(
                                "Information",
                                 "User Profile Update Successful",
                                context);
                      Get.back();
                    }
                  });
                }
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
