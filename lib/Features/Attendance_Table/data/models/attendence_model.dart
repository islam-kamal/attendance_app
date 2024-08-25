import 'package:attendance_app_code/Base/network/network-mappers.dart';

class AttendanceModel extends BaseMappable {
  bool? success;
  String? message;
  Data? data;

  AttendanceModel({this.success, this.message, this.data});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
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
    return AttendanceModel(success: success,data: data,message: message);
  }
}

class Data {
  int? currentPage;
  List<Attendance>? attendance;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.attendance,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      attendance = <Attendance>[];
      json['data'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.attendance != null) {
      data['data'] = this.attendance!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Attendance {
  int? id;
  String? attendanceDate;
  String? registerIn;
  String? registerOut;
  int? lateHours;
  int? lateMin;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? userId;
  User? user;

  Attendance(
      {this.id,
      this.attendanceDate,
      this.registerIn,
      this.registerOut,
      this.lateHours,
      this.lateMin,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.user});

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendanceDate = json['attendance_date'];
    registerIn = json['in'];
    registerOut = json['out'];
    lateHours = json['late_hours'];
    lateMin = json['late_min'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attendance_date'] = this.attendanceDate;
    data['in'] = this.registerIn;
    data['out'] = this.registerOut;
    data['late_hours'] = this.lateHours;
    data['late_min'] = this.lateMin;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  String? fullNameLatin;
  String? email;
  String? fcmToken;
  String? phone;
  int? countryId;
  String? profilePhotoPath;
  String? twoFactorSecret;
  String? twoFactorRecoveryCodes;
  String? twoFactorConfirmedAt;
  String? emailVerifiedAt;
  int? active;
  String? createdBy;
  String? updatedBy;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? viban;
  String? resetCode;
  String? acceptTermsFlag;

  User(
      {this.id,
      this.fullName,
      this.fullNameLatin,
      this.email,
      this.fcmToken,
      this.phone,
      this.countryId,
      this.profilePhotoPath,
      this.twoFactorSecret,
      this.twoFactorRecoveryCodes,
      this.twoFactorConfirmedAt,
      this.emailVerifiedAt,
      this.active,
      this.createdBy,
      this.updatedBy,
      this.lastLogin,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.viban,
      this.resetCode,
      this.acceptTermsFlag});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    fullNameLatin = json['full_name_latin'];
    email = json['email'];
    fcmToken = json['fcm_token'];
    phone = json['phone'];
    countryId = json['country_id'];
    profilePhotoPath = json['profile_photo_path'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    emailVerifiedAt = json['email_verified_at'];
    active = json['active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    viban = json['viban'];
    resetCode = json['reset_code'];
    acceptTermsFlag = json['accept_terms_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['full_name_latin'] = this.fullNameLatin;
    data['email'] = this.email;
    data['fcm_token'] = this.fcmToken;
    data['phone'] = this.phone;
    data['country_id'] = this.countryId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['two_factor_secret'] = this.twoFactorSecret;
    data['two_factor_recovery_codes'] = this.twoFactorRecoveryCodes;
    data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['active'] = this.active;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['last_login'] = this.lastLogin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['viban'] = this.viban;
    data['reset_code'] = this.resetCode;
    data['accept_terms_flag'] = this.acceptTermsFlag;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
