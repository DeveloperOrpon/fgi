import 'package:flutter/cupertino.dart';

import 'NotificationWidgets.dart';


class NotificationContent extends StatelessWidget {
  const NotificationContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) => NotificationWidgets(
          offerscardIndex: index,
        ));
  }
}
