import 'package:flutter/material.dart';
https://github.com/abdurrakibrafi/bKash_UI/blob/main/lib/widgets/notification_widget.dart
class NotificationWidgets extends StatelessWidget {
  const NotificationWidgets({super.key, required this.offerscardIndex});

  final int offerscardIndex;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        child: Column(
          children: [
            Image(
                image:
                AssetImage(NotificationProvide[offerscardIndex].NotifyImg)),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage(
                        NotificationProvide[offerscardIndex].NotifyImg2),
                    width: 65,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      NotificationProvide[offerscardIndex].NotifyTitleOne,
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text(
                      NotificationProvide[offerscardIndex].NotifyTitleTwo,
                      style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      )
    ]);
  }
}