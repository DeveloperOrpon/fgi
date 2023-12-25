import 'fstore_notification_item.dart';

class FStoreNotification {
  final bool enable;
  List<RSNotificationItem> listNotification = <RSNotificationItem>[];

  FStoreNotification.init(
    this.enable, {
    List<RSNotificationItem>? list,
  }) {
    if (list != null) {
      listNotification = list;
    }
  }

  FStoreNotification copyWith({
    bool? enable,
    List<RSNotificationItem>? listNotification,
  }) {
    return FStoreNotification.init(
      enable ?? this.enable,
      list: List.from(listNotification ?? this.listNotification),
    );
  }

  factory FStoreNotification.fromJson(Map json) {
    var listNotification = <RSNotificationItem>[];
    if (json['listNotification'] != null) {
      listNotification = List.from(json['listNotification']).map((json) {
        return RSNotificationItem.fromJson(json);
      }).toList();
    }
    return FStoreNotification.init(
      json['enable'] ?? true,
      list: listNotification,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enable': enable,
      'listNotification': listNotification.map((e) => e.toJson()).toList(),
    };
  }
}
