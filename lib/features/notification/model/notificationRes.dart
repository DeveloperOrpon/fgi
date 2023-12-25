class NotificationRes {
  int? status;
  Meta? meta;
  List<NotificationModel>? notifications;

  NotificationRes({this.status, this.meta, this.notifications});

  NotificationRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      notifications = <NotificationModel>[];
      json['data'].forEach((v) {
        notifications!.add(new NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.notifications != null) {
      data['data'] = this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? totalNotifications;
  int? totalPage;
  int? currentPage;
  int? perPage;

  Meta(
      {this.totalNotifications,
        this.totalPage,
        this.currentPage,
        this.perPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalNotifications = json['total_Notifications'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    perPage = json['per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_Notifications'] = this.totalNotifications;
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    data['per_page'] = this.perPage;
    return data;
  }
}

class NotificationModel {
  String? sId;
  String? message;
  String? title;
  Data? data;
  String? color;
  String? bgColor;
  String? priority;
  bool? isRecent;
  bool? read;
  String? userEmail;
  String? category;
  String? date;
  int? iV;

  NotificationModel(
      {this.sId,
        this.message,
        this.title,
        this.data,
        this.color,
        this.bgColor,
        this.priority,
        this.isRecent,
        this.read,
        this.userEmail,
        this.category,
        this.date,
        this.iV});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    message = json['message'];
    title = json['title'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    color = json['color'];
    bgColor = json['bgColor'];
    priority = json['priority'];
    isRecent = json['isRecent'];
    read = json['read'];
    userEmail = json['user_email'];
    category = json['notify_category'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['message'] = this.message;
    data['title'] = this.title;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['color'] = this.color;
    data['bgColor'] = this.bgColor;
    data['priority'] = this.priority;
    data['isRecent'] = this.isRecent;
    data['read'] = this.read;
    data['user_email'] = this.userEmail;
    data['category'] = this.category;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}

class Data {
  dynamic imageUrl;
  String? appUrl;
  String? sId;

  Data({this.imageUrl, this.appUrl, this.sId});

  Data.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    appUrl = json['appUrl'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['appUrl'] = this.appUrl;
    data['_id'] = this.sId;
    return data;
  }
}