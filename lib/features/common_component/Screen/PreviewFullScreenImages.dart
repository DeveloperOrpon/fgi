import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../config/style/app_colors.dart';

class PreviewFullScreenImages extends StatelessWidget {
final int index;
  const PreviewFullScreenImages({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images=[
      "https://www.insidevancouver.ca/wp-content/uploads/2022/07/Praguery7-664x830.jpeg",
      "https://www.insidevancouver.ca/wp-content/uploads/2022/07/Praguery-664x664.jpeg"
    ];
    PageController parkingImageSlider = PageController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.primary,
            )),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: images[0],
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: Get.height,
              color: Colors.white,
              child: PageView(
                controller: parkingImageSlider,
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  images.length,
                      (index) => CachedNetworkImage(
                    imageUrl: images[index],
                    fit: BoxFit.fitHeight,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => const SpinKitFoldingCube(
                      color: AppColors.primary,
                      size: 50.0,
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                    imageBuilder: (context, imageProvider) {
                      return PhotoView(

                        imageProvider: imageProvider,
                        backgroundDecoration:
                        const BoxDecoration(color: Colors.transparent),
                        enableRotation: false,
                        // heroAttributes: PhotoViewHeroAttributes(tag: index),

                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: SmoothPageIndicator(
              controller: parkingImageSlider,
              count: images.length,
              effect: ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: AppColors.primary,
                dotHeight: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}