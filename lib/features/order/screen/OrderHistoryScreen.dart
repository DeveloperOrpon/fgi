import 'package:animate_do/animate_do.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../../config/style/text_style.dart';
import '../../dashboard/Component/dashDrawer.dart';
import '../controller/orderController.dart';
import 'CompleteOrdersScreen.dart';
import 'InvoicesScreen.dart';
import 'PendingOrdersScreen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BounceInUp(
          child: FloatingActionButton.extended(
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
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: Colors.transparent,
          title: const Text("Order History"),
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
        drawer: const DashDrawer(),
        body: CustomScrollView(
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
      ),
    );
  }
}
