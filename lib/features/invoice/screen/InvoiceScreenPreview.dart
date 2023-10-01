import 'package:fgi_y2j/features/common_component/simpleAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../helper/FileSaveHelper.dart';


class InvoiceScreenPreview extends StatelessWidget {
  const InvoiceScreenPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarComponent(title: "Invoice (Pending)", onTap: (){
        Get.back();
      }),
      body: PdfPreview(
        previewPageMargin: EdgeInsets.zero,

        loadingWidget: const CupertinoActivityIndicator(radius: 18),
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        build: (_) => makePdf(context ),
      ),
    );
  }
}
