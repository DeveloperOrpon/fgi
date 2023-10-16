import 'package:fgi_y2j/config/config.dart';
import 'package:fgi_y2j/config/helper/helperFunction.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';

Future<Uint8List> makePdf(BuildContext context) async {

  var format = NumberFormat.simpleCurrency(locale: 'bn');
  printLog(format.currencySymbol);
  final pdf = pw.Document(pageMode: PdfPageMode.fullscreen);
  // final ByteData bytes = await rootBundle.load('assets/images/tickIcon.png');
  // final Uint8List byteList = bytes.buffer.asUint8List();
  ///pw.MultiPage
  pdf.addPage(pw.Page(

      margin: const pw.EdgeInsets.all(30),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Header(
                  text: "Invoice",
                  level: 1,
                ),
              ]),
              pw.SizedBox(height: 10),
              pw.Text("Company name",
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.Text("example123@gamil.com",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.normal,
                    color: PdfColors.black,
                  )),
              pw.SizedBox(height: 40),
              pw.RichText(
                  text: pw.TextSpan(children: [
                pw.TextSpan(
                    text: 'Order ID : ',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    )),
                pw.TextSpan(
                    text: '1233',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.normal,
                      color: PdfColors.black,
                    ))
              ])),
              pw.SizedBox(height: 40),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Jane Cooper ',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        )),
                    pw.Text('Order Date : 22-07-23 ',
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.normal,
                          color: PdfColors.black,
                        )),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('example123@gamil.com ',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        )),
                    pw.Text('Pickup Date : 22-07-23 ',
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.normal,
                          color: PdfColors.black,
                        )),
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
                        )),
                    pw.Text('Pending ',
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.normal,
                          color: PdfColors.black,
                        )),
                  ]),
              pw.SizedBox(height: 20),
              pw.Text('Products ',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  )),
              pw.SizedBox(height: 10),
              ...List.generate(15, (index) => pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text('$index psc buns',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                      )),
                  pw.Expanded(child: pw.Padding(child: pw.Divider(color: PdfColors.grey),padding: pw.EdgeInsets.symmetric(horizontal: 10))),
                  pw.Text('200 ${format.currencyName} ',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        color: PdfColors.black,
                      ))
                ],
              ),),
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
                        )),
                    pw.Text('20,000 ${format.currencyName} ',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        )),
                  ]),
              pw.Expanded(child:
              pw.Center(
                child: pw.Text('By Company Name ',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.normal,
                      color: PdfColors.black,
                    ))
              )
              )

            ]);
      }));
  return pdf.save();
}
