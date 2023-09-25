import 'package:animate_do/animate_do.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fgi_y2j/features/order/controller/orderController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/style/app_colors.dart';
import '../../../config/style/text_style.dart';
import '../screen/CompleteOrdersScreen.dart';
import '../screen/InvoicesScreen.dart';
import '../screen/PendingOrdersScreen.dart';

class OrderHistoryHome extends StatelessWidget {
  const OrderHistoryHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final orderController=Get.put(OrderController());
    return SmartRefresher(
      physics: const BouncingScrollPhysics(),
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(
        waterDropColor: AppColors.primary,
        refresh: CupertinoActivityIndicator(color:  AppColors.black,radius: 15,),
      ),
      footer: CustomFooter(
        builder: (context, mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  const Text("Pull up load");
          }
          else if(mode==LoadStatus.loading){
            body =  const CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = const Text("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
            body = const Text("release to load more");
          }
          else{
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      controller: orderController.refreshHistoryController,
      onRefresh: () {
        printLog("onRefresh");
        orderController.onRefreshHistoryPage();
      },
      onLoading: () {
        printLog("onLoading");
        orderController.onLoadingHistoryPage();
      },
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      hintText: "Search",
                      hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 16),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                )
              ])),

          ///order summery
          SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summery",
                          style: AppTextStyles.drawerTextStyle.copyWith(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Expanded(
                      child: FadeInLeft(
                        duration: 300.ms,
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Total Orders",
                                style: AppTextStyles.summeryTextStyle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "(Today)",
                                    style: AppTextStyles.summeryTextStyle,
                                  ),
                                  PullDownButton(
                                    itemBuilder: (context) => [
                                      PullDownMenuItem.selectable(
                                        onTap: () {},
                                        selected: true,
                                        title: 'Today',
                                        icon: CupertinoIcons.circle_fill,
                                        iconColor: CupertinoColors.systemGreen
                                            .resolveFrom(context),
                                      ),
                                      PullDownMenuItem.selectable(
                                        onTap: () {},
                                        selected: false,
                                        title: 'Tomorrow',
                                        icon: CupertinoIcons.circle_fill,
                                        iconColor: CupertinoColors.systemOrange
                                            .resolveFrom(context),
                                      ),
                                      PullDownMenuItem.selectable(
                                        onTap: () {},
                                        selected: false,
                                        title: 'Yesterday',
                                        icon: CupertinoIcons.circle_fill,
                                        iconColor: CupertinoColors.systemIndigo
                                            .resolveFrom(context),
                                      )
                                    ],
                                    buttonBuilder: (context, showMenu) => InkWell(
                                      onTap: showMenu,
                                      child: const Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "30",
                                style: AppTextStyles.summeryTextStyle
                                    .copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(const PendingOrderScreen(),transition:Transition.upToDown);
                        },
                        child: FadeInLeft(
                          duration: 300.ms,
                          delay: 300.ms,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Pending",
                                  style: AppTextStyles.summeryTextStyle,
                                ),
                                Text(
                                  "Orders",
                                  style: AppTextStyles.summeryTextStyle,
                                ),
                                Text(
                                  "02",
                                  style: AppTextStyles.summeryTextStyle
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child:  InkWell(
                        onTap: () {
                          Get.to(const CompleteOrderScreen(),transition:Transition.upToDown);
                        },
                        child: FadeInLeft(
                          duration: 300.ms,
                          delay: 600.ms,
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Completed",
                                  style: AppTextStyles.summeryTextStyle,
                                ),
                                Text(
                                  "Orders",
                                  style: AppTextStyles.summeryTextStyle,
                                ),
                                Text(
                                  "15",
                                  style: AppTextStyles.summeryTextStyle
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ])),

          ///product category
          SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 10),
                Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pending Orders",
                          style: AppTextStyles.drawerTextStyle.copyWith(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const PendingOrderScreen(),transition:Transition.upToDown);
                          },
                          child: Text(
                            "See All",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    )),
              ])),

          ///Pending Order History
          SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                      )
                          .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                          .scaleXY(delay: 1500.ms, end: 1.4),
                      const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                                'Triifol Burgers: 56psc buns, 20psc Mustard, 100 Coca-cola cans, 40pcs Tyson Chicken'),
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: Get.width * .09),
                    const Icon(CupertinoIcons.clock),
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "  Pickup in :",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " 2 days, 6 hours",
                            style: TextStyle(color: Colors.black)),
                      ]),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: Get.width * .09),
                    const Icon(Icons.calendar_today),
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "  Order Date :",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " 23-07-23",
                            style: TextStyle(color: Colors.black)),
                      ]),
                    )
                  ],
                ),
              ])),
          SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                      )
                          .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                          .scaleXY(delay: 1600.ms, end: 1.4),
                      const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                                'Triifol Burgers: 56psc buns, 20psc Mustard, 100 Coca-cola cans, 40pcs Tyson Chicken'),
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: Get.width * .09),
                    const Icon(CupertinoIcons.clock),
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "  Pickup in :",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " 2 days, 6 hours",
                            style: TextStyle(color: Colors.black)),
                      ]),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: Get.width * .09),
                    const Icon(Icons.calendar_today),
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: "  Order Date :",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " 23-07-23",
                            style: TextStyle(color: Colors.black)),
                      ]),
                    )
                  ],
                ),
              ])),

          ///Completed Order History
          SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 15),
                Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Completed Orders",
                          style: AppTextStyles.drawerTextStyle.copyWith(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const CompleteOrderScreen(),transition:Transition.upToDown);
                          },
                          child: Text(
                            "See All",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    )),
              ])),
          SliverList(
              delegate: SliverChildListDelegate([
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                                'Triifol Burgers: 56psc buns, 20psc Mustard, 100 Coca-cola cans, 40pcs Tyson Chicken'),
                          ))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('Riley’s Kitchen: 6psc buns, 2psc Mustard'),
                          ))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                                'Triifol Burgers: 56psc buns, 20psc Mustard, 100 Coca-cola cans, 40pcs Tyson Chicken'),
                          ))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.green,
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                                'Triifol Burgers: 56psc buns, 20psc Mustard, 100 Coca-cola cans, 40pcs Tyson Chicken'),
                          ))
                    ],
                  ),
                ),
              ])),

          ///invoices
          SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 15),
                Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
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
                        InkWell(
                          onTap: () {
                            Get.to(const InvoiceScreen(),transition:Transition.upToDown);
                          },
                          child: Text(
                            "See All",
                            style: AppTextStyles.drawerTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    )),
              ])),
          SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 500,
                  padding: const EdgeInsets.all(12),
                  child: DataTable2(
                      headingRowColor: MaterialStatePropertyAll(Colors.grey.shade200),

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
                              (index) => const DataRow(cells: [
                            DataCell(Text('0234')),
                            DataCell(Text('108')),
                            DataCell(Text('Y2J NYC')),
                            DataCell(Text('Riley’s Kitchen')),
                            DataCell(Text('234720345')),
                            DataCell(Text('>'))
                          ]))),

                ),
                SizedBox(height: 50)
              ]))
        ],
      ),
    );
  }
}
