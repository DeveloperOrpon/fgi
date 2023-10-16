
import 'package:fgi_y2j/features/view_products/screen/AllProductHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/helper/helperFunction.dart';
import '../../../config/route.dart';
import '../../dashboard/Component/dashDrawer.dart';

class AllProductGridScreen extends StatelessWidget {
  const AllProductGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            backgroundColor: Colors.transparent,
            title: const Text("Products"),
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
          body: const AllProductsHome(),
        ));

  }

}
