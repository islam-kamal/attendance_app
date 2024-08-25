import 'package:attendance_app_code/Base/network/network-mappers.dart';

class PenaltyModel extends BaseMappable{
  bool? success;
  String? message;
  List<Penalty>? data;

  PenaltyModel({this.success, this.message, this.data});

  PenaltyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Penalty>[];
      json['data'].forEach((v) {
        data!.add(new Penalty.fromJson(v));
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
      data = <Penalty>[];
      json['data'].forEach((v) {
        data!.add(new Penalty.fromJson(v));
      });
    }
    return PenaltyModel(success: success,message: message,data: data);
  }
}

class Penalty {
  int? id;
  String? amount;
  int? first;
  int? second;
  int? third;
  int? moreThanThree;
  String? amountType;
  String? timeType;
  String? type;
  int? createdBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Penalty(
      {this.id,
        this.amount,
        this.first,
        this.second,
        this.third,
        this.moreThanThree,
        this.amountType,
        this.timeType,
        this.type,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Penalty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    first = json['first'];
    second = json['second'];
    third = json['third'];
    moreThanThree = json['more_than_three'];
    amountType = json['amount_type'];
    timeType = json['time_type'];
    type = json['type'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['first'] = this.first;
    data['second'] = this.second;
    data['third'] = this.third;
    data['more_than_three'] = this.moreThanThree;
    data['amount_type'] = this.amountType;
    data['time_type'] = this.timeType;
    data['type'] = this.type;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}