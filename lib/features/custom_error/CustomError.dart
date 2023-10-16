import 'package:fgi_y2j/redirectScreeen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Container errorWidget(){
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Center(child: Text("Some Thing Error Happened")),
        Center(
          child: OutlinedButton(
              onPressed: () {
                Get.deleteAll(force: true);
                Get.offAll(const RedirectScreen(),
                    transition: Transition.fadeIn);
              },
              child: const Text("Refresh")),
        )
      ],
    ),
  );
}