import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/authentication/screen/changePasswordScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../../constants/var_const.dart';

class InputPasswordScreen extends StatefulWidget {
  const InputPasswordScreen({Key? key}) : super(key: key);

  @override
  State<InputPasswordScreen> createState() => _InputPasswordScreenState();
}

class _InputPasswordScreenState extends State<InputPasswordScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    const length = 4;
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromRGBO(251, 0, 44, 1.0);
    const fillColor = Colors.white;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    final key=GlobalKey();
    return Scaffold(
      key:key,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: const Icon(CupertinoIcons.back,color: AppColors.primary,size: 25,)),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset(
            loginCarouselSliderImage[0],
            fit: BoxFit.contain,
            height: 350,
            width: Get.width,
          ),
          Container(
            height: Get.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(.5),
                  Colors.black,
                ], begin: Alignment.topCenter)),
          ),
          ListView(
            children: [
              const OtpHeader(),
              SizedBox(
                child: Pinput(
                  forceErrorState: showError,
                  length: length,
                  controller: controller,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  onCompleted: (pin) {
                    setState(() => showError = pin != '5555');
                    if(pin=='5555'){
                      Get.to(const ChangePasswordScreen(),transition: Transition.downToUp);
                    }else{
                      showErrorDialogInTop("Warning", "Your Input Pin Code is Wrong", context);
                    }
                  },
                  focusedPinTheme: defaultPinTheme.copyWith(
                    height: 68,
                    width: 64,
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: borderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      color: errorColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 40,right: 40),
                child: ElevatedButton(onPressed: () {
                  if(controller.text.trim()=='5555'){
                    Get.to(const ChangePasswordScreen(),transition: Transition.fadeIn);
                  }else{
                    showErrorDialogInTop("Warning", "Your Input Pin Code is Wrong", context);
                  }
                },style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(55)
                ), child: const Text("Code Verify",style: TextStyle(color: Colors.white),),),
              )
            ],
          ),
        ],
      ),
    );
  }
}
class OtpHeader extends StatelessWidget {
  const OtpHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 100),
          BounceInLeft(
            delay: const Duration(milliseconds: 200),
            child: Text(
              "Hello There",
              style: AppTextStyles.boldstyle
                  .copyWith(color: AppColors.strongAmer),
            ),
          ),
          BounceInLeft(
            delay: const Duration(milliseconds: 400),
            child: Text(
              'Welcome Back!',
              style: AppTextStyles.boldstyle.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 40),
          BounceInLeft(
            delay: const Duration(milliseconds: 600),
            child: Text(
              'Code Verification',
              style: AppTextStyles.boldstyle
                  .copyWith(color: AppColors.white),
            ),
          ),  BounceInLeft(
            delay: const Duration(milliseconds: 600),
            child:Text(
              "Please Provide Enter the code sent to the email address",
              style: AppTextStyles.boldstyle
                  .copyWith(color: AppColors.strongAmer,fontSize: 12,fontWeight: FontWeight.normal),
            ),
          ),
          Text(
            'develerorpon@gmal.com',
            style: AppTextStyles.boldstyle
                .copyWith(color: AppColors.white,fontSize: 20),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}