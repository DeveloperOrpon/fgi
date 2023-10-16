import 'package:fgi_y2j/config/style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class NotificationContent extends StatelessWidget {
  const NotificationContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 66,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                  spreadRadius: 2,
                )
              ]),
          child: Row(
            children: [
              Container(
                margin:
                const EdgeInsets.only(left: 10, right: 10),
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  FontAwesomeIcons.clipboardCheck,
                  color: Colors.white,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Demo Notification Title $index" ,style: AppTextStyles.boldstyle.copyWith(fontSize: 15)),
                  const Text("10PM,12-12-2023",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      )),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
