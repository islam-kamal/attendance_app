
import 'package:attendance_app_code/Base/network/network-mappers.dart';

class SiginModel extends BaseMappable{
  User? user;
  var accessToken;
 var error;
 var code;
 var message;
  SiginModel({this.user, this.accessToken,this.error,this.message,this.code});

  SiginModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    error = json['error'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['access_token'] = accessToken;
    data['error'] = this.error;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    error = json['error'];
    code = json['code'];
    message = json['message'];
    return SiginModel(user: user,accessToken: accessToken,message: message,error: error,code: code);
  }
}

class User {
  var id;
  var fullName;
  var fullNameLatin;
  var email;
  var phone;
 var countryId;
  var profilePhotoPath;
  var twoFactorSecret;
  var twoFactorRecoveryCodes;
  var twoFactorConfirmedAt;
  var emailVerifiedAt;
 var active;
  var createdBy;
  var updatedBy;
  var lastLogin;
  var createdAt;
  var updatedAt;
  var deletedAt;
  var viban;
  var resetCode;
  var acceptTermsFlag;
  Guardian? guardian;
  Student? student;
  Driver? driver;
  var admin;
  List<String>? permissions;
  List<Roles>? roles;

  User(
      {this.id,
        this.fullName,
        this.fullNameLatin,
        this.email,
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
        this.acceptTermsFlag,
        this.guardian,
        this.student,
        this.driver,
        this.admin,
        this.permissions,
        this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    fullNameLatin = json['full_name_latin'];
    email = json['email'];
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
    guardian = json['guardian'] != null
        ? Guardian.fromJson(json['guardian'])
        : null;
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    admin = json['admin'];
    permissions = json['permissions'] != null
        ? List<String>.from(json['permissions'])
        : null;
    roles = json['roles'] != null
        ? (json['roles'] as List).map((i) => Roles.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['full_name_latin'] = fullNameLatin;
    data['email'] = email;
    data['phone'] = phone;
    data['country_id'] = countryId;
    data['profile_photo_path'] = profilePhotoPath;
    data['two_factor_secret'] = twoFactorSecret;
    data['two_factor_recovery_codes'] = twoFactorRecoveryCodes;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['email_verified_at'] = emailVerifiedAt;
    data['active'] = active;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['last_login'] = lastLogin;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['viban'] = viban;
    data['reset_code'] = resetCode;
    data['accept_terms_flag'] = acceptTermsFlag;
    if (guardian != null) {
      data['guardian'] = guardian!.toJson();
    }
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    data['admin'] = admin;
    if (permissions != null) {
      data['permissions'] = permissions;
    }
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Guardian {
 var id;
 var nationalId;
 var userId;
  var address;
 var active;
 var createdBy;
 var updatedBy;
  var createdAt;
  var updatedAt;
  var deletedAt;
  var refund;
 var parentCategoryId;

  Guardian(
      {this.id,
        this.nationalId,
        this.userId,
        this.address,
        this.active,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.refund,
        this.parentCategoryId});

  Guardian.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nationalId = json['national_id'];
    userId = json['user_id'];
    address = json['address'];
    active = json['active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    refund = json['refund'];
    parentCategoryId = json['parent_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['national_id'] = nationalId;
    data['user_id'] = userId;
    data['address'] = address;
    data['active'] = active;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['refund'] = refund;
    data['parent_category_id'] = parentCategoryId;
    return data;
  }
}

class Student {
 var id;
 var lastAcademicDegreeId;
 var currentAcademicDegreeId;
  var studentStatusKey;
 var guardianId;
 var admissionRequestId;
 var upgradeRequestId;
 var currentActiveInvoiceId;
  var studentFirstName;
  var studentLastName;
  var studentFirstNameLatin;
  var studentLastNameLatin;
  var nationalId;
 var nationalityId;
  var chronicDisease;
  var address;
  var birthDate;
  var lastNoorSync;
 var isGraduated;
 var needCare;
 var genderTypeId;
 var createdBy;
  var updatedBy;
  var deletedAt;
  var createdAt;
  var updatedAt;
  var isOldSystem;
 var userId;

  Student(
      {this.id,
        this.lastAcademicDegreeId,
        this.currentAcademicDegreeId,
        this.studentStatusKey,
        this.guardianId,
        this.admissionRequestId,
        this.upgradeRequestId,
        this.currentActiveInvoiceId,
        this.studentFirstName,
        this.studentLastName,
        this.studentFirstNameLatin,
        this.studentLastNameLatin,
        this.nationalId,
        this.nationalityId,
        this.chronicDisease,
        this.address,
        this.birthDate,
        this.lastNoorSync,
        this.isGraduated,
        this.needCare,
        this.genderTypeId,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.isOldSystem,
        this.userId});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastAcademicDegreeId = json['last_academic_degree_id'];
    currentAcademicDegreeId = json['current_academic_degree_id'];
    studentStatusKey = json['student_status_key'];
    guardianId = json['guardian_id'];
    admissionRequestId = json['admission_request_id'];
    upgradeRequestId = json['upgrade_request_id'];
    currentActiveInvoiceId = json['current_active_invoice_id'];
    studentFirstName = json['student_first_name'];
    studentLastName = json['student_last_name'];
    studentFirstNameLatin = json['student_first_name_latin'];
    studentLastNameLatin = json['student_last_name_latin'];
    nationalId = json['national_id'];
    nationalityId = json['nationality_id'];
    chronicDisease = json['chronic_disease'];
    address = json['address'];
    birthDate = json['birth_date'];
    lastNoorSync = json['last_noor_sync'];
    isGraduated = json['is_graduated'];
    needCare = json['need_care'];
    genderTypeId = json['gender_type_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isOldSystem = json['is_old_system'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['last_academic_degree_id'] = lastAcademicDegreeId;
    data['current_academic_degree_id'] = currentAcademicDegreeId;
    data['student_status_key'] = studentStatusKey;
    data['guardian_id'] = guardianId;
    data['admission_request_id'] = admissionRequestId;
    data['upgrade_request_id'] = upgradeRequestId;
    data['current_active_invoice_id'] = currentActiveInvoiceId;
    data['student_first_name'] = studentFirstName;
    data['student_last_name'] = studentLastName;
    data['student_first_name_latin'] = studentFirstNameLatin;
    data['student_last_name_latin'] = studentLastNameLatin;
    data['national_id'] = nationalId;
    data['nationality_id'] = nationalityId;
    data['chronic_disease'] = chronicDisease;
    data['address'] = address;
    data['birth_date'] = birthDate;
    data['last_noor_sync'] = lastNoorSync;
    data['is_graduated'] = isGraduated;
    data['need_care'] = needCare;
    data['gender_type_id'] = genderTypeId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_old_system'] = isOldSystem;
    data['user_id'] = userId;
    return data;
  }
}

class Driver {
 var id;
 var nationalId;
  var licenseNo;
  var licenseType;
  var licenseExpiryDate;
 var companyId;
 var userId;
  var address;
 var active;
 var createdBy;
 var updatedBy;
  var createdAt;
  var updatedAt;
  var deletedAt;

  Driver(
      {this.id,
        this.nationalId,
        this.licenseNo,
        this.licenseType,
        this.licenseExpiryDate,
        this.companyId,
        this.userId,
        this.address,
        this.active,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nationalId = json['national_id'];
    licenseNo = json['license_no'];
    licenseType = json['license_type'];
    licenseExpiryDate = json['license_expiry_date'];
    companyId = json['company_id'];
    userId = json['user_id'];
    address = json['address'];
    active = json['active'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['national_id'] = nationalId;
    data['license_no'] = licenseNo;
    data['license_type'] = licenseType;
    data['license_expiry_date'] = licenseExpiryDate;
    data['company_id'] = companyId;
    data['user_id'] = userId;
    data['address'] = address;
    data['active'] = active;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Roles {
 var id;
  var title;
  var name;
 var level;
  var createdAt;
  var updatedAt;
  Pivot? pivot;

  Roles(
      {this.id,
        this.title,
        this.name,
        this.level,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    level = json['level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['name'] = name;
    data['level'] = level;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
 var userId;
 var roleId;

  Pivot({this.userId, this.roleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['role_id'] = roleId;
    return data;
  }
}
