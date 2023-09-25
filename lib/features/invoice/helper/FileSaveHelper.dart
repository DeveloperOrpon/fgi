
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> makePdf() async {
  final pdf = pw.Document();
  final ByteData bytes = await rootBundle.load('assets/images/tickIcon.png');
  final Uint8List byteList = bytes.buffer.asUint8List();
  pdf.addPage(
      pw.Page(
          margin: const pw.EdgeInsets.all(10),
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Header(text: "About Cat", level: 1),
                        pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight, height: 100, width: 100)
                      ]
                  ),
                  pw.Divider(borderStyle: pw.BorderStyle.dashed),
                  pw.Paragraph(text: "text"),
                ]
            );
          }
      ));
  return pdf.save();
}
