import 'dart:io';

import 'package:fgi_y2j/config/config.dart';
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/authentication/model/UserRes.dart';
import 'package:fgi_y2j/features/shopping_cart/model/OrderRes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

Future<Uint8List> makePdf(BuildContext context, OrderResModel orderResModel,
    UserModel userModel) async {
  final fontStyle = await PdfGoogleFonts.robotoMonoRegular();

  final authController = Get.put(AuthenticationController());
  final category = Get.put(CategoryController());
  var format = NumberFormat.simpleCurrency(locale: 'en');
  printLog(format.currencySymbol);
  final pdf = pw.Document(pageMode: PdfPageMode.fullscreen);
  // final ByteData bytes = await rootBundle.load('assets/images/tickIcon.png');
  // final Uint8List byteList = bytes.buffer.asUint8List();
  ///pw.MultiPage
  pdf.addPage(pw.Page(
      theme: pw.ThemeData(defaultTextStyle: pw.TextStyle(font: fontStyle)),
      margin: const pw.EdgeInsets.only(left: 30, right: 30, bottom: 5, top: 5),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Stack(alignment: pw.Alignment.topRight, children: [
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              pw.Text("Invoice",
                  style: pw.TextStyle(
                      font: fontStyle, decoration: TextDecoration.underline)),
            ]),
            pw.Text('${DateFormat('E, d MMM, y').format(DateTime.now())}',
                style: pw.TextStyle(font: fontStyle, fontSize: 10))
          ]),
          pw.SizedBox(height: 10),
          // pw.Image(NetworkImage(url),width: 50,height: 50),
          pw.Text("${authController.userModel.value!.company}",
              style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  font: fontStyle)),
          pw.Text("${category.brandList[0].brandEmail}",
              style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.normal,
                  color: PdfColors.black,
                  font: fontStyle)),
          pw.Text("${category.brandList[0].brandAddress}",
              style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                  color: PdfColors.black,
                  font: fontStyle)),
          pw.SizedBox(height: 10),
          pw.RichText(
              text: pw.TextSpan(children: [
            pw.TextSpan(
                text: 'Order ID : ',
                style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                    font: fontStyle)),
            pw.TextSpan(
                text: '#${orderResModel.sId}',
                style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                    font: fontStyle))
          ])),
          pw.Text(
              'Order Date  : ${DateFormat('E, d MMM, y').format(DateTime.parse(orderResModel.createdAt!).toLocal())} ',
              style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                  color: PdfColors.black,
                  font: fontStyle)),
          pw.Text('Pickup Date : ${orderResModel.pickupTime} ',
              style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.normal,
                  color: PdfColors.black,
                  font: fontStyle)),
          pw.SizedBox(height: 10),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                    '${userModel.firstName == null ? "" : userModel.firstName![0].toUpperCase() + userModel.firstName!.substring(1)} ${userModel.lastName} ',
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                        font: fontStyle)),
              ]),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('${userModel.email} ',
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                        font: fontStyle)),
              ]),
          pw.SizedBox(height: 10),
          pw.Divider(color: PdfColors.grey),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Status ',
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                        font: fontStyle)),
                pw.Text('${statusGet(orderResModel.orderStatus ?? 0)} ',
                    style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                        font: fontStyle)),
              ]),
          pw.SizedBox(height: 5),
          pw.Row(children: [
            pw.Expanded(
              flex: 7,
              child: pw.Text('Products ',
                  style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                      font: fontStyle)),
            ),
            pw.Expanded(
              flex: 2,
              child: pw.Text(
                  textAlign: pw.TextAlign.center,
                  'Qty ',
                  style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                      font: fontStyle)),
            ),
            pw.Expanded(
              flex: 4,
              child: pw.Text(
                  textAlign: pw.TextAlign.right,
                  'Price ',
                  style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                      font: fontStyle)),
            )
          ]),
          pw.SizedBox(height: 8),
          ...List.generate(
            orderResModel.items!.length.isGreaterThan(24)?24: orderResModel.items!.length,
            (index) => pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Expanded(
                  flex: 7,
                  child: pw.Text(
                    maxLines: 1,
                    overflow: pw.TextOverflow.clip,
                    '${index + 1} ${orderResModel.items![index].productName}',
                    style: pw.TextStyle(
                      fontSize: 13,
                      fontWeight: pw.FontWeight.normal,
                      color: PdfColors.black,
                    ),
                  ),
                ),
                pw.Expanded(
                    flex: 3,
                    child: pw.Center(
                      child: pw.Text(
                        "(${orderResModel.items![index].productUnitType}-${orderResModel.items![index].product_unit_value})x${orderResModel.items![index].productQuantity}",
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.normal,
                            color: PdfColors.black,
                          )
                      ),
                    )),
                pw.Expanded(
                  flex: 4,
                  child: pw.Text(
                    textAlign: pw.TextAlign.right,
                    '${(orderResModel.items![index].productPrice! * orderResModel.items![index].productQuantity!).toStringAsFixed(2)} ${format.currencyName} ',
                    style: pw.TextStyle(
                      fontSize: 13,
                      fontWeight: pw.FontWeight.normal,
                      color: PdfColors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          pw.SizedBox(height: 5),

          pw.Divider(color: PdfColors.grey),
          pw.SizedBox(height: 5),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total Amount ',
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                        font: fontStyle)),
                pw.Text('${orderResModel.totalCost} ${format.currencyName} ',
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                        font: fontStyle)),
              ]),
          pw.Expanded(
              child: pw.Center(
                  child: pw.Text("${category.brandList[0].brandLabel}",
                      style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.normal,
                          color: PdfColors.black,
                          font: fontStyle))))
        ]);
      }));
  if (orderResModel.items!.length > 24)
    pdf.addPage(pw.Page(
        theme: pw.ThemeData(defaultTextStyle: pw.TextStyle(font: fontStyle)),
        margin:
            const pw.EdgeInsets.only(left: 30, right: 30, bottom: 5, top: 5),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Stack(alignment: pw.Alignment.topRight, children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text("Invoice",
                            style: pw.TextStyle(
                                font: fontStyle,
                                decoration: TextDecoration.underline)),
                      ]),
                  pw.Text('${DateFormat('E, d MMM, y').format(DateTime.now())}',
                      style: pw.TextStyle(font: fontStyle, fontSize: 10))
                ]),
                pw.SizedBox(height: 10),
                // pw.Image(NetworkImage(url),width: 50,height: 50),
                pw.Text("${authController.userModel.value!.company}",
                    style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        font: fontStyle)),
                pw.Text("${category.brandList[0].brandEmail}",
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                        font: fontStyle)),
                pw.Text("${category.brandList[0].brandAddress}",
                    style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                        font: fontStyle)),
                pw.SizedBox(height: 10),
                pw.RichText(
                    text: pw.TextSpan(children: [
                  pw.TextSpan(
                      text: 'Order ID : ',
                      style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                          font: fontStyle)),
                  pw.TextSpan(
                      text: '#${orderResModel.sId}',
                      style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                          font: fontStyle))
                ])),
                pw.Text(
                    'Order Date  : ${DateFormat('E, d MMM, y').format(DateTime.parse(orderResModel.createdAt!).toLocal())} ',
                    style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                        font: fontStyle)),
                pw.Text('Pickup Date : ${orderResModel.pickupTime} ',
                    style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                        font: fontStyle)),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                          '${userModel.firstName == null ? "" : userModel.firstName![0].toUpperCase() + userModel.firstName!.substring(1)} ${userModel.lastName} ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('${userModel.email} ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Divider(color: PdfColors.grey),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Status ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                      pw.Text('${statusGet(orderResModel.orderStatus ?? 0)} ',
                          style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.normal,
                              color: PdfColors.black,
                              font: fontStyle)),
                    ]),
                pw.SizedBox(height: 5),
                pw.Row(children: [
                  pw.Expanded(
                    flex: 7,
                    child: pw.Text('Products ',
                        style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                            font: fontStyle)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                        textAlign: pw.TextAlign.center,
                        'Qty ',
                        style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                            font: fontStyle)),
                  ),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Text(
                        textAlign: pw.TextAlign.right,
                        'Price ',
                        style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                            font: fontStyle)),
                  )
                ]),
                pw.SizedBox(height: 8),
                ...List.generate(
                  orderResModel.items!.length.isGreaterThan(48)?48-24: orderResModel.items!.length - 24,
                  (index) {
                    index += 24;
                    return pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Expanded(
                          flex: 7,
                          child: pw.Text(
                            maxLines: 1,
                            overflow: pw.TextOverflow.clip,
                            '${index + 1} ${orderResModel.items![index].productName}',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.normal,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Expanded(
                            flex: 2,
                            child: pw.Center(
                                child: pw.Text(
                                    "(${orderResModel.items![index].productUnitType}-${orderResModel.items![index].product_unit_value})x${orderResModel.items![index].productQuantity}",style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.normal,
                                  color: PdfColors.black,
                                )),)),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Text(
                            textAlign: pw.TextAlign.right,
                            '${(orderResModel.items![index].productPrice! * orderResModel.items![index].productQuantity!).toStringAsFixed(2)} ${format.currencyName} ',
                            style: pw.TextStyle(
                              fontSize: 13,
                              fontWeight: pw.FontWeight.normal,
                              color: PdfColors.black,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                pw.SizedBox(height: 5),

                pw.Divider(color: PdfColors.grey),
                pw.SizedBox(height: 5),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total Amount ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                      pw.Text(
                          '${orderResModel.totalCost} ${format.currencyName} ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                    ]),
                pw.Expanded(
                    child: pw.Center(
                        child: pw.Text("${category.brandList[0].brandLabel}",
                            style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.normal,
                                color: PdfColors.black,
                                font: fontStyle))))
              ]);
        }));

  if (orderResModel.items!.length > 48)
    pdf.addPage(pw.Page(
        theme: pw.ThemeData(defaultTextStyle: pw.TextStyle(font: fontStyle)),
        margin:
        const pw.EdgeInsets.only(left: 30, right: 30, bottom: 5, top: 5),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Stack(alignment: pw.Alignment.topRight, children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text("Invoice",
                            style: pw.TextStyle(
                                font: fontStyle,
                                decoration: TextDecoration.underline)),
                      ]),
                  pw.Text('${DateFormat('E, d MMM, y').format(DateTime.now())}',
                      style: pw.TextStyle(font: fontStyle, fontSize: 10))
                ]),
                pw.SizedBox(height: 10),
                // pw.Image(NetworkImage(url),width: 50,height: 50),
                pw.Text("${authController.userModel.value!.company}",
                    style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        font: fontStyle)),
                pw.Text("${category.brandList[0].brandEmail}",
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                        font: fontStyle)),
                pw.Text("${category.brandList[0].brandAddress}",
                    style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                        font: fontStyle)),
                pw.SizedBox(height: 10),
                pw.RichText(
                    text: pw.TextSpan(children: [
                      pw.TextSpan(
                          text: 'Order ID : ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                      pw.TextSpan(
                          text: '#${orderResModel.sId}',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle))
                    ])),
                pw.Text(
                    'Order Date  : ${DateFormat('E, d MMM, y').format(DateTime.parse(orderResModel.createdAt!).toLocal())} ',
                    style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                        font: fontStyle)),
                pw.Text('Pickup Date : ${orderResModel.pickupTime} ',
                    style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                        font: fontStyle)),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                          '${userModel.firstName == null ? "" : userModel.firstName![0].toUpperCase() + userModel.firstName!.substring(1)} ${userModel.lastName} ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('${userModel.email} ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Divider(color: PdfColors.grey),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Status ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                      pw.Text('${statusGet(orderResModel.orderStatus ?? 0)} ',
                          style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.normal,
                              color: PdfColors.black,
                              font: fontStyle)),
                    ]),
                pw.SizedBox(height: 5),
                pw.Row(children: [
                  pw.Expanded(
                    flex: 7,
                    child: pw.Text('Products ',
                        style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                            font: fontStyle)),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                        textAlign: pw.TextAlign.center,
                        'Qty ',
                        style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                            font: fontStyle)),
                  ),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Text(
                        textAlign: pw.TextAlign.right,
                        'Price ',
                        style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                            font: fontStyle)),
                  )
                ]),
                pw.SizedBox(height: 8),
                ...List.generate(
                   orderResModel.items!.length - 48,
                      (index) {
                    index += 24;
                    return pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Expanded(
                          flex: 7,
                          child: pw.Text(
                            maxLines: 1,
                            overflow: pw.TextOverflow.clip,
                            '${index + 1} ${orderResModel.items![index].productName}',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.normal,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Expanded(
                            flex: 2,
                            child: pw.Padding(
                                child: pw.Text(
                                    "${orderResModel.items![index].productUnitType}-${orderResModel.items![index].product_unit_value}x${orderResModel.items![index].productQuantity}"),
                                padding:
                                pw.EdgeInsets.symmetric(horizontal: 10))),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Text(
                            textAlign: pw.TextAlign.right,
                            '${(orderResModel.items![index].productPrice! * orderResModel.items![index].productQuantity!).toStringAsFixed(2)} ${format.currencyName} ',
                            style: pw.TextStyle(
                              fontSize: 13,
                              fontWeight: pw.FontWeight.normal,
                              color: PdfColors.black,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                pw.SizedBox(height: 5),

                pw.Divider(color: PdfColors.grey),
                pw.SizedBox(height: 5),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total Amount ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                      pw.Text(
                          '${orderResModel.totalCost} ${format.currencyName} ',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                              font: fontStyle)),
                    ]),
                pw.Expanded(
                    child: pw.Center(
                        child: pw.Text("${category.brandList[0].brandLabel}",
                            style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.normal,
                                color: PdfColors.black,
                                font: fontStyle))))
              ]);
        }));

  return pdf.save();
}

String statusGet(num index) {
  if (index == 0) {
    return 'Pending';
  }
  if (index == 1) {
    return 'Order Accept';
  }
  if (index == 2) {
    return 'Order Cancel';
  }
  return "Order Delivered";
}
