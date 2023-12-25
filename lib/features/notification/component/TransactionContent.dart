

import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/style/text_style.dart';
import '../model/notificationRes.dart';
import '../model/transaction.dart';

class TransactionContent extends StatelessWidget {
  final List<NotificationModel> notificationList;
  const TransactionContent({Key? key, required  List<NotificationModel> this.notificationList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
        itemCount: notificationList.length,
        itemBuilder: (context, index) {
          final item = notificationList[index];
          return Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    offset: const Offset(2, 6),
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 2)
              ]),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all( 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage(
                                "assets/images/tickIcon.png",
                              ),
                              height: 40,
                              width: 40,
                              fit: BoxFit.fitWidth,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.message??"",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    item.category??'',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(
                                    item.sId??"",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // tTime: "12:38 PM 21/08/2022",
                              Text(DateFormat('HH:mm a').format(DateTime.parse(item.date??DateTime.now().toString())).toString(), style: AppTextStyles.drawerTextStyle!.copyWith(
                                color: AppColors.primary,
                              )),
                              Text(
                                textAlign: TextAlign.end,
                                DateFormat('dd/MM/yyyy').format(DateTime.parse(item.date??DateTime.now().toString())).toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
