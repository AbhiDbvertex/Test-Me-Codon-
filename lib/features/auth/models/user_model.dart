import 'package:codon/features/subscription/Models/subscrption_model.dart';

// class UserModel {
//   final String id;
//   final String name;
//   final String email;
//   final String? profileImage;
//   final String mobile;
//   final String address;
//   final String countryId;
//   final String stateId;
//   final String cityId;
//   final String collegeId;
//   final String classId;
//   final String? passingYear;
//   final String admissionYear;
//   final String status;
//   final String role;
//   final String signUpBy;
//   final bool isEmailVerified;
//   final String subscriptionStatus;
//   final String createdAt;
//   final String updatedAt;
//   final Subscription subscription;

//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.profileImage,
//     required this.mobile,
//     required this.address,
//     required this.countryId,
//     required this.stateId,
//     required this.cityId,
//     required this.collegeId,
//     required this.classId,
//     this.passingYear,
//     required this.admissionYear,
//     required this.status,
//     required this.role,
//     required this.signUpBy,
//     required this.isEmailVerified,
//     required this.subscriptionStatus,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.subscription,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['_id'],
//       name: json['name'],
//       email: json['email'],
//       profileImage: json['profileImage'],
//       mobile: json['mobile'],
//       address: json['address'],
//       countryId: json['countryId'] ?? "",
//       stateId: json['stateId'] ?? "",
//       cityId: json['cityId'] ?? "",
//       collegeId: json['collegeId'] ?? "",
//       classId: json['classId'] ?? "",
//       passingYear: json['passingYear'] ?? "",
//       admissionYear: json['admissionYear'] ?? "",
//       status: json['status'] ?? "",
//       role: json['role'] ?? "",
//       signUpBy: json['signUpBy'] ?? "",
//       isEmailVerified: json['isEmailVerified'] ?? false,
//       subscriptionStatus: json['subscriptionStatus'] ?? "",
//       createdAt: json['createdAt'] ?? "",
//       updatedAt: json['updatedAt'] ?? "",
//       subscription: Subscription.fromJson(json['subscription']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'email': email,
//       'profileImage': profileImage,
//       'mobile': mobile,
//       'address': address,
//       'countryId': countryId,
//       'stateId': stateId,
//       'cityId': cityId,
//       'collegeId': collegeId,
//       'classId': classId,
//       'passingYear': passingYear,
//       'admissionYear': admissionYear,
//       'status': status,
//       'role': role,
//       'signUpBy': signUpBy,
//       'isEmailVerified': isEmailVerified,
//       'subscriptionStatus': subscriptionStatus,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'subscription': subscription.toJson(),
//     };
//   }
// }
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String mobile;
  final String address;
  final String? countryId;
  final CommonRefModel? state;
  final CommonRefModel? city;
  final CommonRefModel? college;
  final String? classId;
  final String? passingYear;
  final String? admissionYear;
  final String status;
  final String role;
  final String signUpBy;
  final bool isEmailVerified;
  final bool isMobileVerified;
  final String subscriptionStatus;
  final bool activeSubscription;
  final Subscription subscription;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    required this.mobile,
    required this.address,
    this.countryId,
    this.state,
    this.city,
    this.college,
    this.classId,
    this.passingYear,
    this.admissionYear,
    required this.status,
    required this.role,
    required this.signUpBy,
    required this.isEmailVerified,
    required this.isMobileVerified,
    required this.subscriptionStatus,
    required this.activeSubscription,
    required this.subscription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'],
      mobile: json['mobile'] ?? '',
      address: json['address'] ?? '',
      countryId: json['countryId'],
      state: json['stateId'] != null
          ? (json['stateId'] is String
                ? CommonRefModel(id: json['stateId'], name: '')
                : CommonRefModel.fromJson(json['stateId']))
          : null,
      city: json['cityId'] != null
          ? (json['cityId'] is String
                ? CommonRefModel(id: json['cityId'], name: '')
                : CommonRefModel.fromJson(json['cityId']))
          : null,

      college: json['collegeId'] != null
          ? (json['collegeId'] is String
                ? CommonRefModel(id: json['collegeId'], name: '')
                : CommonRefModel.fromJson(json['collegeId']))
          : null,
      classId: json['classId'],
      passingYear: json['passingYear']?.toString(),
      admissionYear: json['admissionYear'],
      status: json['status'] ?? '',
      role: json['role'] ?? '',
      signUpBy: json['signUpBy'] ?? '',
      isEmailVerified: json['isEmailVerified'] ?? false,
      isMobileVerified: json['isMobileVerified'] ?? false,
      subscriptionStatus: json['subscriptionStatus'] ?? '',
      activeSubscription:
          (json['activesubscription'] == true ||
          json['activeSubscription'] == true ||
          json['activesubscription'] == 'true' ||
          json['activeSubscription'] == 'true'),
      subscription: Subscription.fromJson(json['subscription']),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'mobile': mobile,
      'address': address,
      'countryId': countryId,
      'stateId': state?.id,
      'cityId': city?.id,
      'collegeId': college?.id,
      'classId': classId,
      'passingYear': passingYear,
      'admissionYear': admissionYear,
      'status': status,
      'role': role,
      'signUpBy': signUpBy,
      'isEmailVerified': isEmailVerified,
      'isMobileVerified': isMobileVerified,
      'subscriptionStatus': subscriptionStatus,
      'activesubscription': activeSubscription,
      'subscription': subscription.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class CommonRefModel {
  final String id;
  final String name;

  CommonRefModel({required this.id, required this.name});

  factory CommonRefModel.fromJson(Map<String, dynamic> json) {
    return CommonRefModel(id: json['_id'] ?? '', name: json['name'] ?? '');
  }
}
