import 'package:attendance_app_code/Base/network/network-mappers.dart';

class NotificationModel extends BaseMappable{
  bool? success;
  String? message;
  List<Data>? data;

  NotificationModel({this.success, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    return NotificationModel(success: success,message: message,data: data);
  }
}

class Data {
  int? id;
  String? body;
  String? title;
  int? userId;
  String? userType;
  String? serviceName;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Null? appId;

  Data(
      {this.id,
        this.body,
        this.title,
        this.userId,
        this.userType,
        this.serviceName,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.appId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    title = json['title'];
    userId = json['user_id'];
    userType = json['user_type'];
    serviceName = json['service_name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    appId = json['app_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['service_name'] = this.serviceName;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['app_id'] = this.appId;
    return data;
  }
}