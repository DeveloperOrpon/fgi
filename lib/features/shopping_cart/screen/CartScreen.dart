import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/style/text_style.dart';
import '../component/CartProductUi.dart';
import 'checkoutScreen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.now();
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
        title: const Text("Products"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.bell,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_sharp,
                color: Colors.amber,
              ))
        ],
      ),
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Products",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
          ])),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 250, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return const CartProductUi();
            },
            itemCount: 8,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 20),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pick Date and Time",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
          ])),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.calendar_month,
                    size: 30,
                  ),
                  hintText: "DD-MM-YYYY",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
              ),
            )
          ])),
          SliverList(
              delegate: SliverChildListDelegate([
            DateTimePicker(
              initialSelectedDate: dt,
              startDate: dt,
              endDate: dt.add(const Duration(days: 60)),
              startTime: DateTime(dt.year, dt.month, dt.day, 6),
              endTime: DateTime(dt.year, dt.month, dt.day, 18),
              timeInterval: const Duration(minutes: 15),
              datePickerTitle: 'Pick Date',
              timePickerTitle: 'Pick Time',
              timeOutOfRangeError: 'Sorry is not available',
              is24h: false,
              onDateChanged: (date) {
                // setState(() {
                //   _d1 = DateFormat('dd MMM, yyyy').format(date);
                // });
              },
              onTimeChanged: (time) {
                // setState(() {
                //   _t1 = DateFormat('hh:mm:ss aa').format(time);
                // });
              },
            )
          ])),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 20),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Additional Instructions",
                      style: AppTextStyles.drawerTextStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
          ])),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                minLines: 8,
                maxLines: 8,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade300,
                ),
              ),
            )
          ])),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 60,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary)),
                      onPressed: () {
                        Get.to(const CheckoutScreen(),transition: Transition.upToDown);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Place order"),
                      )),
                ),
              ),
            ),
            const SizedBox(height: 60)
          ])),
        ],
      ),
    );
  }
}
