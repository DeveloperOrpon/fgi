import 'package:fgi_y2j/features/common_component/simpleAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../helper/FileSaveHelper.dart';


class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarComponent(title: "Invoice (Pending)", onTap: (){
        Get.back();
      }),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }
}
