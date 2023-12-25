// import 'package:animate_do/animate_do.dart';
// import 'package:fgi_y2j/features/Category_Brand/Controller/CategoryController.dart';
// import 'package:fgi_y2j/features/search_product/screen/search_screen.dart';
// import 'package:fgi_y2j/features/view_products/controller/allProductController.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../../config/style/text_style.dart';
// import '../../Category_Brand/Model/CategoryByProductRes.dart';
// import '../../Category_Brand/Screen/CategoryByProductScreen.dart';
// import '../component/SingleProductListUI.dart';
// import 'TabScreen.dart';
//
// class AllProductListScreen extends StatelessWidget {
//   const AllProductListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final categoryController = Get.put(CategoryController());
//     return FadeIn(
//       child: CustomScrollView(
//         slivers: [
//           SliverList(
//               delegate: SliverChildListDelegate([
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: InkWell(
//                       onTap: () {
//                         Get.to(const SearchScreen(),transition: Transition.fadeIn);
//                       },
//                       child: IgnorePointer(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(
//                               Icons.search,
//                               size: 30,
//                             ),
//                             hintText: "Search",
//                             hintStyle:
//                                 const TextStyle(color: Colors.grey, fontSize: 16),
//                             filled: true,
//                             fillColor: Colors.grey.shade200,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       Scaffold.of(context).openEndDrawer();
//                     },
//                     icon: const Icon(
//                       CupertinoIcons.grid_circle,
//                       size: 35,
//                     ))
//               ],
//             )
//           ])),
//
//           SliverList(
//               delegate: SliverChildBuilderDelegate(
//             childCount: categoryController.categoryList.value.length,
//             (context, index) {
//               final category = categoryController.categoryList.value[index];
//               return FutureBuilder<ProductSearchRes?>(
//                   future: categoryController.getProductByCategory(
//                       category.categoryLabel!, 1),
//                   builder: (context, snapshot) {
//                     if(snapshot.hasData){
//                       return (snapshot.data!.data!.isEmpty)
//                           ? Center(
//                         // child: Text(
//                         //   "No Product In This Category",
//                         //   style: TextStyle(
//                         //       color: Colors.grey.shade300),
//                         // ),
//                       ):StickyHeader(
//                         key: Key(category.sId ?? ""),
//                         header: Container(
//                             color: Colors.white,
//                             height: 50,
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 8.0, horizontal: 12),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "${category.categoryLabel}",
//                                   style: AppTextStyles.drawerTextStyle.copyWith(
//                                       fontSize: 20,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     Get.to(
//                                         CategoryProductTabScreen(
//                                             categoryName:
//                                             "${category.categoryLabel}"),
//                                         transition: Transition.upToDown);
//                                   },
//                                   child: Text(
//                                     "See All",
//                                     style: AppTextStyles.drawerTextStyle.copyWith(
//                                         fontSize: 18,
//                                         color: Colors.grey,
//                                         fontWeight: FontWeight.normal,
//                                         decoration: TextDecoration.underline),
//                                   ),
//                                 ),
//                               ],
//                             )),
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: snapshot.data!.data!
//                               .map((e) => SingleProductListUI(
//                             index: e.categoryId ?? "",
//                             productModel: e,
//                           ))
//                               .toList(),
//                         ),
//                       );
//                     }
//                     return Lottie.asset(
//                         'assets/animation/loadingScreen.json');
//                   });
//             },
//           )),
//         ],
//       ),
//     );
//   }
// }
