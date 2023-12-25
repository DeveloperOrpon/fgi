// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// import '../../../common_controller/AppController.dart';
// import '../../../config/route.dart';
// import '../../dashboard/Component/dashDrawer.dart';
// import '../../dashboard/controller/dashboardController.dart';
// import '../../search_product/screen/search_screen.dart';
// import '../../shopping_cart/controller/cartController.dart';
// import '../component/ProductFilterDrawer.dart';
// import '../controller/allProductController.dart';
//
// class FilterAllProduct extends StatefulWidget {
//   const FilterAllProduct({super.key});
//
//   @override
//   State<FilterAllProduct> createState() => _FilterAllProductState();
// }
//
// class _FilterAllProductState extends State<FilterAllProduct> {
//   final appController =Get.put(AppController());
//   final dashboardController = Get.put(DashBoardController());
//   final allProductController = Get.put(AllProductController());
//   final cartController = Get.put(CartController());
//   final key = GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const DashDrawer(),
//       endDrawer: const ProductFilterDrawer(),
//       backgroundColor: CupertinoColors.white,
//       appBar: AppBar(
//         bottom: PreferredSize(
//           preferredSize:!appController.haveConnection.value? Size(Get.width,25):Size(0, 0),
//           child:appController.haveConnection.value?const Center(): Container(
//             padding: const EdgeInsets.all(4),
//             alignment: Alignment.center,
//             width: Get.width,
//             decoration: const BoxDecoration(
//               color: Colors.red,
//             ),
//             child: const Text("No Internet",style: TextStyle(color: Colors.white,fontSize: 14),),
//           ),
//         ),
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.white,
//           statusBarIconBrightness: Brightness.dark,
//           // For Android (dark icons)
//           statusBarBrightness: Brightness.light, // For iOS (dark icons)
//         ),
//         backgroundColor: Colors.transparent,
//         title:  const Text("Filter Products"),
//         actions: [
//           Obx(() {
//             return dashboardController.selectDrawerIndex.value == 2
//                 ? IconButton(
//                 onPressed: () {
//                   allProductController.isListAllProduct.value =
//                   !allProductController.isListAllProduct.value;
//                 },
//                 icon: allProductController.isListAllProduct.value
//                     ? const Icon(
//                   CupertinoIcons.square_grid_2x2,
//                   color: Colors.black,
//                 )
//                     : const Icon(
//                     CupertinoIcons.list_bullet_below_rectangle))
//                 : const Center();
//           }),
//           IconButton(
//               onPressed: () {
//                 AppRoute().notificationScreen();
//               },
//               icon: const Icon(
//                 CupertinoIcons.bell,
//                 color: Colors.black,
//               )),
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: IconButton(
//                     onPressed: () {
//                       AppRoute().cartPage();
//                     },
//                     icon: const Icon(
//                       CupertinoIcons.shopping_cart,
//                       color: Colors.black,
//                     )),
//               ),
//               Obx(() {
//                 return cartController.cartItems.value.isNotEmpty
//                     ? Positioned(
//                   top: 0,
//                   right: 5,
//                   child: CircleAvatar(
//                     radius: 12,
//                     backgroundColor: Colors.red,
//                     child: Center(
//                       child: Text(
//                         "${cartController.cartItems.length}",
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                   ),
//                 )
//                     : const Center();
//               })
//             ],
//           )
//         ],
//       ),
//
//       body: CustomScrollView(
//         slivers: [
//           SliverList(
//               delegate: SliverChildListDelegate([
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child:  InkWell(
//                         onTap: () {
//                           Get.to(const SearchScreen(),transition: Transition.fadeIn);
//                         },
//                         child: IgnorePointer(
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: TextFormField(
//                               enabled: false,
//                               decoration: InputDecoration(
//                                 prefixIcon: const Icon(
//                                   Icons.search,
//                                   size: 30,
//                                 ),
//                                 hintText: "Search",
//                                 hintStyle:
//                                 const TextStyle(color: Colors.grey, fontSize: 16),
//                                 filled: true,
//                                 fillColor: Colors.grey.shade200,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           Scaffold.of(context).openDrawer();
//                         },
//                         icon: const Icon(
//                           CupertinoIcons.grid_circle,
//                           size: 35,
//                         ))
//                   ],
//                 )
//               ])),
//         ],
//       ),
//     );
//   }
// }
