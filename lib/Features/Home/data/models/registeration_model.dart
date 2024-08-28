import 'dart:core';

import 'package:attendance_app_code/Base/network/network-mappers.dart';

class RegisterationModel extends BaseMappable{
  bool? success;
  String? message;
  Data? data;

  RegisterationModel({this.success, this.message, this.data});

  RegisterationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    return RegisterationModel(success: success,message: message,data: data);
  }
}

class Data {
  int? id;
  String? attendanceDate;
  String? register_in;
  String? register_out;
  int? lateHours;
  int? lateMin;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? userId;

  Data(
      {this.id, this.attendanceDate, this.register_in, this.register_out, this.lateHours, this.lateMin, this.deletedAt,
        this.createdAt, this.updatedAt, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendanceDate = json['attendance_date'];
    register_in = json['in'];
    register_out = json['out'];
    lateHours = int.parse(json['late_hours'].toString());
    lateMin = int.parse(json['late_min'].toString());
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attendance_date'] = this.attendanceDate;
    data['in'] = this.register_in;
    data['out'] = this.register_out;
    data['late_hours'] = this.lateHours;
    data['late_min'] = this.lateMin;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    return data;
  }
}

