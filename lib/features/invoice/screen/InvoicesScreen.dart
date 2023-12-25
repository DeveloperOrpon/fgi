import 'package:data_table_2/data_table_2.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:fgi_y2j/features/invoice/screen/InvoiceScreenPreview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../../order/controller/orderController.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final authController = Get.put(AuthenticationController());
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFFF1C700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () {},
          label: Row(
            children: [
              const SizedBox(width: 5),
              const Icon(FontAwesomeIcons.cartShopping),
              const SizedBox(width: 10),
              Text(
                'Add new order',
                style: AppTextStyles.drawerTextStyle.copyWith(
                    fontWeight: FontWeight.w400, color: Colors.black),
              ),
              const SizedBox(width: 5),
            ],
          )),
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text("Invoices"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.bell,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                AppRoute().cartPage();
              },
              icon: const Icon(
                CupertinoIcons.shopping_cart,
                color: Colors.black,
              ))
        ],
      ),
      body: SmartRefresher(
        physics: const BouncingScrollPhysics(),
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(
          waterDropColor: AppColors.primary,
          refresh: CupertinoActivityIndicator(
            color: AppColors.black,
            radius: 15,
          ),
        ),
        footer: CustomFooter(
          builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("Pull up load");
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = const Text("No more Data");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: orderController.refreshInvoiceController,
        onRefresh: () {
          printLog("onRefresh");
          orderController.onRefreshInvoicePage();
        },
        onLoading: () {
          printLog("onLoading");
          orderController.onLoadingInvoicePage();
        },
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Center(child: Text("Long Press To Order Items For Preview Or Download The Invoice",style: TextStyle(color: Colors.grey,fontSize: 10),),),
            ),
            Expanded(
              child: CustomScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          height: Get.height*.8,
                          padding: const EdgeInsets.all(12),
                          child: Obx(() {
                            return DataTable2(
                                headingRowColor: MaterialStatePropertyAll(Colors.grey.shade200),

                                columnSpacing: 12,
                                horizontalMargin: 8,
                                minWidth: 800,
                                columns: const [
                                  DataColumn2(
                                    label: Text('Order ID'),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Text('Items'),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Text('Provider'),
                                    size: ColumnSize.M,
                                  ),
                                  DataColumn2(
                                    label: Text('Receiver'),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text('Inv.No.'),
                                    numeric: true,
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text(''),
                                    numeric: true,
                                    size: ColumnSize.M,
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                    orderController.allOrderList.value.length,
                                        (index){
                                      final order=orderController.allOrderList.value[index];
                                      return  DataRow(
                                          onLongPress:()  {
                                            Get.to( InvoiceScreenPreview(orderResModel: order),transition: Transition.fadeIn);
                                          },
                                          cells: [
                                        DataCell(Text('${order.sId!.substring(0,6)}..')),
                                        DataCell(Text('${order.items!.length}')),
                                        DataCell(Text('${authController.userModel.value!.company}')),
                                        DataCell(Text('${authController.userModel.value!.firstName}')),
                                        DataCell(Text('${order.sId!}',maxLines: 2,)),
                                        DataCell(ElevatedButton(onPressed: () {
                                          Get.to( InvoiceScreenPreview(orderResModel:order ),transition: Transition.fadeIn);
                                        }, child: Text("Invoice")))
                                      ]);
                                    }));
                          }
                          ),

                        ),
                        SizedBox(height: 50)
                      ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
