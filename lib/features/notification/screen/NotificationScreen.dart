import 'package:cached_network_image/cached_network_image.dart';
import 'package:fgi_y2j/Api/notification/NotificationController.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:fgi_y2j/features/common_component/simpleAppBar.dart';
import 'package:fgi_y2j/features/dashboard/Component/dashboardHome.dart';
import 'package:fgi_y2j/features/notification/model/notificationRes.dart';
import 'package:fgi_y2j/features/order/screen/AcceptOrdersScreen.dart';
import 'package:fgi_y2j/features/shopping_cart/screen/CartScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/config.dart';
import '../../../config/extend/string.dart';
import '../../../config/style/text_style.dart';
import '../component/NotificationContent.dart';
import '../component/TransactionContent.dart';
import '../controller/notificationController.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(AppNotificationController());
    return Scaffold(
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
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Notification'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.bell_solid,
                color: AppColors.primary,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Get.to(const CartScreen(), transition: Transition.upToDown);
              },
              icon: const Icon(
                CupertinoIcons.shopping_cart,
                color: Colors.black,
              ))
        ],
      ),
      body: Obx(() {
        return SmartRefresher(
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
          controller: notificationController.refreshController,
          onRefresh: () {
            notificationController.notificationList.value = [];
            notificationController.notificationRes.value = null;
            notificationController.page = 1;
            notificationController.getNotification();

            Future.delayed(
              Duration(seconds: 1),
              () {
                notificationController.refreshController.refreshCompleted();
              },
            );
          },
          onLoading: () async {
            notificationController.page++;
            notificationController.getNotification();
            Future.delayed(
              Duration(seconds: 1),
              () {
                notificationController.refreshController.loadComplete();
              },
            );
          },
          child: notificationController.notificationRes.value == null
              ? Lottie.asset("assets/animation/loadingScreen.json")
              : notificationController.notificationList.value.isEmpty
                  ? Lottie.asset("assets/animation/nodata.json")
                  : CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverList(
                            delegate: SliverChildListDelegate([
                          CupertinoButton(
                            child: Text("Mark All As Read"),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                          ),
                        ])),
                        SliverList.builder(
                          itemBuilder: (context, index) {
                            final item = notificationController
                                .notificationList.value[index];
                            final Color color =
                                HexColor.fromHex(item.color ?? "#000000");
                            return InkWell(
                              onTap: () {
                               if(item.read!=true) notificationController
                                    .readMarkNotification(item);
                                showNotificationInfo(context, item);
                                var notificationList = notificationController
                                    .notificationList.value;
                                notificationList
                                    .firstWhere((element) => element == item)
                                    .read = true;
                                notificationController.notificationList.value =
                                    [];
                                notificationController.notificationList.value =
                                    notificationList;
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Container(
                                  height: 116,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(2, 6),
                                        color: Colors.white,
                                        blurRadius: 15,
                                        spreadRadius: 2)
                                  ]),
                                  child: Card(
                                    color: Colors.grey.shade200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                item.data != null &&
                                                        item.data!.imageUrl !=
                                                            null
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            CachedNetworkImage(
                                                          height: 80,
                                                          width: Get.width * .1,
                                                          fit: BoxFit.contain,
                                                          imageUrl: item
                                                              .data!.imageUrl!,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Center(
                                                            child: Text(
                                                              "$appName",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                            ),
                                                          ),
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  const SpinKitFoldingCube(
                                                            color: AppColors
                                                                .primary,
                                                            size: 20.0,
                                                          ),
                                                        ),
                                                      )
                                                    : Image(
                                                        image: AssetImage(
                                                          "assets/images/tickIcon.png",
                                                        ),
                                                        height: 40,
                                                        width: 40,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Stack(
                                                          clipBehavior:
                                                              Clip.none,
                                                          children: [
                                                            Text(
                                                              item.title ??
                                                                  item.message ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 16),
                                                            ),
                                                            if (item.read !=
                                                                    null &&
                                                                !item.read!)
                                                              Positioned(
                                                                left: -30,
                                                                top: -8,
                                                                child:
                                                                    Container(
                                                                  child: Text(
                                                                    "${item.read! ? "" : "NEW"}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              2),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        color,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                        item.title == null
                                                            ? Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 4,
                                                                        right:
                                                                            5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: color
                                                                      .withOpacity(
                                                                          1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Text(
                                                                  (item.title == null
                                                                          ? item.category ??
                                                                              ''
                                                                          : item.message ??
                                                                              "")
                                                                      .toUpperCase(),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                              )
                                                            : Text(
                                                                item.title ==
                                                                        null
                                                                    ? item.category ??
                                                                        ''
                                                                    : item.message ??
                                                                        "",
                                                                maxLines: 3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700],fontSize: 11),
                                                              ),
                                                        item.title != null
                                                            ? Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 6,
                                                                        right:
                                                                            6,top: 2,bottom: 2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: color
                                                                      .withOpacity(
                                                                          1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Text(
                                                                  (item.title == null
                                                                          ? item.sId ??
                                                                              ""
                                                                          : item.category ??
                                                                              '')
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          11),
                                                                ),
                                                              )
                                                            : Text(
                                                                item.title ==
                                                                        null
                                                                    ? item.sId ??
                                                                        ""
                                                                    : item.category ??
                                                                        '',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: ClipPath(
                                            clipper: MyClip(),
                                            child: Container(
                                              color: color,
                                              height: 200,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // tTime: "12:38 PM 21/08/2022",
                                                  Text(
                                                      DateFormat('hh:mm a')
                                                          .format(
                                                              DateTime.parse(
                                                            item.date ??
                                                                DateTime.now()
                                                                    .toString(),
                                                          ).toLocal())
                                                          .toString(),
                                                      style: AppTextStyles
                                                          .drawerTextStyle!
                                                          .copyWith(
                                                        color: AppColors.white,
                                                      )),
                                                  Text(
                                                    textAlign: TextAlign.end,
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(DateTime.parse(item
                                                                    .date ??
                                                                DateTime.now()
                                                                    .toString())
                                                            .toLocal())
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: notificationController
                              .notificationList.value.length,
                        )
                      ],
                    ),
        );
      }),
    );
  }
}

class MyClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(10, size.height / 2 + 20, 5, size.height / 2);
    path.quadraticBezierTo(0, size.height / 3, 10, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

showNotificationInfo(
    BuildContext context, NotificationModel notificationModel) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(.2),
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text("${notificationModel.title ?? notificationModel.message}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            notificationModel.data != null &&
                    notificationModel.data!.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 100,
                      fit: BoxFit.contain,
                      imageUrl: notificationModel.data!.imageUrl!,
                      errorWidget: (context, url, error) => Center(
                        child: Text(
                          "$appName",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const SpinKitFoldingCube(
                        color: AppColors.primary,
                        size: 20.0,
                      ),
                    ),
                  )
                : Image(
                    image: AssetImage(
                      "assets/images/tickIcon.png",
                    ),
                    height: 40,
                    width: 40,
                    fit: BoxFit.fitWidth,
                  ),
            SizedBox(height: 10),
            Text(
                "${notificationModel.title == null ? "Notification Is About To ${notificationModel.category}" : notificationModel.message}",style: TextStyle(),)
          ],
        ),
        actions: <Widget>[
          // if (notificationModel.category!.toUpperCase() != 'NOTIFICATION')
          CupertinoDialogAction(
            child: Text('Details'),
            onPressed: () {
              Navigator.of(context).pop();
              if (notificationModel.title!.toLowerCase().contains("approve")) {
                Get.to(AcceptOrdersScreen());
              }
            },
            textStyle: TextStyle(color: Colors.blue),
          ),
          CupertinoDialogAction(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
            textStyle: TextStyle(color: Colors.green),
          ),
        ],
      );
    },
  );
}
