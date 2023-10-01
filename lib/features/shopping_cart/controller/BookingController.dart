import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../config/style/text_style.dart';
import '../../invoice/screen/InvoiceScreenPreview.dart';

class BookingController extends GetxController {
  ///show Booking Confirm Dialog
  showBookingConfirmDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.xmark),
            )
          ],
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tickIcon.png',
              width: 80,
              height: 80,
            ).animate(onPlay: (controller) => controller.repeat(reverse: true),).scaleXY(end: 1.2,delay: 400.ms),
            const SizedBox(height: 20),
            Text(
              "Congratulations!",
              style: AppTextStyles.drawerTextStyle.copyWith(
                  fontSize: 20,
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Text(
              "Your order placed successfully!",
              style: AppTextStyles.drawerTextStyle.copyWith(
                  fontSize: 16,
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              child: const Text("View Invoice"),
              onPressed: () {
                Get.back();
                Get.to(const InvoiceScreenPreview(),transition: Transition.fadeIn);
              },
            )
          ],
        ),
      ),
    );
  }
}
