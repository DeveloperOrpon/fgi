import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../constants/var_const.dart';



class Sizes extends StatefulWidget {
  const Sizes({Key? key}) : super(key: key);

  @override
  _SizesState createState() => _SizesState();
}

class _SizesState extends State<Sizes> {
  List<String> sizes = [
    "S",
    "M",
    "L",
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Size",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black,
              ),
            )),
        const SizedBox(height: kDefaultPadding / 5),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sizes.length,
                  itemBuilder: (context, index) => buildCategory(index),
                ),
              ),
              SizedBox(
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: AppColors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Buy Now".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 10),
        
        child: Container(
          width: 40,
          decoration: BoxDecoration(
            
            
            color: selectedIndex == index ?  AppColors.primary  : Colors.white,
            border: Border.all(
              color:  AppColors.primary .withOpacity(0.5),
            ),

            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  sizes[index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: selectedIndex == index ? AppColors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
