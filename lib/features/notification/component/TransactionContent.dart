

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/style/text_style.dart';
import '../model/transaction.dart';

class TransactionContent extends StatelessWidget {
  const TransactionContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TransactionModel> list = [
      TransactionModel(
          tId: "9HEFG65JH",
          tImage: "assets/images/tickIcon.png",
          tType: "Purchase Order",
          tName: "Salman",
          tAmt: "৳5000",
          tTime: "7:20 AM 22/08/2 022",
          tCode: 2),
      TransactionModel(
          tId: "7HBFHHSJS",
          tImage: "assets/images/tickIcon.png",
          tType: "Purchase Order",
          tName: "Daraz",
          tAmt: "৳2090",
          tTime: "12:38 PM 21/08/2022",
          tCode: 2),
      TransactionModel(
          tId: "X7GDHSMNK",
          tImage: "assets/images/tickIcon.png",
          tType: "Purchase Order",
          tName: "RK Telecom",
          tAmt: "500",
          tTime: "8:17 AM 21/08/2022",
          tCode: 1),
      TransactionModel(
          tId: "QWEJCNDJM",
          tImage: "assets/images/tickIcon.png",
          tType: "Postpaid Bill",
          tName: "Airtel Biller",
          tAmt: "৳400",
          tTime: "11:22 PM 19/08/2022",
          tCode: 2),
      TransactionModel(
          tId: "9JGHBNBDC",
          tImage: "assets/images/tickIcon.png",
          tType: "Purchase Order",
          tName: "Imtiaz",
          tAmt: "৳500",
          tTime: "9:20 AM 18/08/2022",
          tCode: 1),
      TransactionModel(
          tId: "7HBFHHSJS",
          tImage: "assets/images/tickIcon.png",
          tType: "Purchase Order",
          tName: "Daraz",
          tAmt: "৳2090",
          tTime: "12:38 PM 21/08/2022",
          tCode: 2),
      TransactionModel(
          tId: "X7GDHSMNK",
          tImage: "assets/images/tickIcon.png",
          tType: "Purchase Order",
          tName: "RK Telecom",
          tAmt: "500",
          tTime: "8:17 AM 21/08/2022",
          tCode: 1),
      TransactionModel(
          tId: "QWEJCNDJM",
          tImage: "assets/images/tickIcon.png",
          tType: "Postpaid Bill",
          tName: "Airtel Biller",
          tAmt: "৳400",
          tTime: "11:22 PM 19/08/2022",
          tCode: 2),
      TransactionModel(
          tId: "7HBFHHSJS",
          tImage: "assets/images/tickIcon.png",
          tType: "Purchase Order",
          tName: "Daraz",
          tAmt: "৳2090",
          tTime: "12:38 PM 21/08/2022",
          tCode: 2),
      TransactionModel(
          tId: "X7GDHSMNK",
          tImage: "assets/images/tickIcon.png",
          tType: "Purchase Order",
          tName: "RK Telecom",
          tAmt: "500",
          tTime: "8:17 AM 21/08/2022",
          tCode: 1),
      TransactionModel(
          tId: "QWEJCNDJM",
          tImage: "assets/images/tickIcon.png",
          tType: "Postpaid Bill",
          tName: "Airtel Biller",
          tAmt: "৳400",
          tTime: "11:22 PM 19/08/2022",
          tCode: 2),
    ];
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
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
                                item.tImage,
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
                                    item.tType,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    item.tName,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(
                                    item.tId,
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
                              Text(item.tAmt, style: AppTextStyles.drawerTextStyle),
                              Text(
                                textAlign: TextAlign.end,
                                item.tTime,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
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
