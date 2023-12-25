import 'package:animate_do/animate_do.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press, required this.duration,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Duration duration;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay:duration ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextButton(

          style: TextButton.styleFrom(
            side: BorderSide(color: AppColors.primary,width: .5),
            padding: const EdgeInsets.all(0),
            primary: AppColors.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: const Color(0xFFF5F6F9),
          ),
          onPressed: press,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  )
                ),
                child: Icon(icon,color: Colors.white,),
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Text(
                text,
                style: const TextStyle(color: AppColors.black),
              )),
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
