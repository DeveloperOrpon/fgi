import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/common_component/simpleAppBar.dart';
import 'package:fgi_y2j/features/shopping_cart/model/OrderRes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../helper/FileSaveHelper.dart';


class InvoiceScreenPreview extends StatelessWidget {
  final OrderResModel orderResModel;
  const InvoiceScreenPreview({Key? key, required this.orderResModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
final authController=Get.put(AuthenticationController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarComponent(title: "Invoice ", onTap: (){
        Get.back();
      }),
      body: PdfPreview(

        previewPageMargin: EdgeInsets.zero,
        allowPrinting: true,
        allowSharing: true,
        // loadingWidget: const CupertinoActivityIndicator(radius: 18),
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        build: (_) => makePdf(context,orderResModel,authController.userModel.value! ),
      ),
    );
  }
}
