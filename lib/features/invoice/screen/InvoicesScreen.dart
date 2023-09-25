import 'package:data_table_2/data_table_2.dart';
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
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
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
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Invoices (Pending)",
                                style: AppTextStyles.drawerTextStyle.copyWith(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                      Container(
                        height: 500,
                        padding: const EdgeInsets.all(12),
                        child: DataTable2(
                          headingRowColor: MaterialStatePropertyAll(
                              Colors.redAccent.withOpacity(.2)),
                          columnSpacing: 12,
                          horizontalMargin: 8,
                          minWidth: 600,
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
                              size: ColumnSize.S,
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            8,
                            (index) =>  DataRow(
                              onLongPress:()  {
                                Get.to(const InvoiceScreenPreview(),transition: Transition.fadeIn);
                              },
                              cells: const [
                                DataCell(Text('0234')),
                                DataCell(Text('108')),
                                DataCell(Text('Y2J NYC')),
                                DataCell(Text('Riley’s Kitchen')),
                                DataCell(Text('234720345')),
                                DataCell(Text('>'))
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25)
                    ])),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Invoices",
                                style: AppTextStyles.drawerTextStyle.copyWith(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                      Container(
                        height: 500,
                        padding: const EdgeInsets.all(12),
                        child: DataTable2(
                            headingRowColor:
                                MaterialStatePropertyAll(Colors.grey.withOpacity(.2)),
                            columnSpacing: 12,
                            horizontalMargin: 8,
                            minWidth: 600,
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
                                size: ColumnSize.S,
                              ),
                            ],
                            rows: List<DataRow>.generate(
                                8,
                                (index) =>  DataRow(
                                    onLongPress:()  {
                                      Get.to(const InvoiceScreenPreview(),transition: Transition.fadeIn);
                                    },
                                    cells:const [
                                      DataCell(Text('0234')),
                                      DataCell(Text('108')),
                                      DataCell(Text('Y2J NYC')),
                                      DataCell(Text('Riley’s Kitchen')),
                                      DataCell(Text('234720345')),
                                      DataCell(Text('>'))
                                    ]))),
                      ),
                      SizedBox(height: 50)
                    ])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
