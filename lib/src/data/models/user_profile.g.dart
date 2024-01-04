// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['id'] as String?,
      userName: json['user_name'] as String?,
      middleName: json['middleName'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      contactNumber: json['contactNumber'] as String?,
      location: json['location'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      type: json['userType'] as String?,
      birthDate: json['birthDate'] as String?,
      avatar: json['profileAvatar'] as String?,
      jobTitle: json['jobTitle'] as String?,
      about: json['userDescription'] as String?,
      coverPhoto: json['coverPhoto'] as String?,
      dailyStatus: json['daily_status'] as String?,
      createdAt: json['createdAt'] as String?,
      nameUpdatedAt: json['nameUpdatedAt'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_name', instance.userName);
  writeNotNull('middleName', instance.middleName);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('contactNumber', instance.contactNumber);
  writeNotNull('location', instance.location);
  writeNotNull('gender', instance.gender);
  writeNotNull('email', instance.email);
  writeNotNull('userType', instance.type);
  writeNotNull('birthDate', instance.birthDate);
  writeNotNull('profileAvatar', instance.avatar);
  writeNotNull('jobTitle', instance.jobTitle);
  writeNotNull('userDescription', instance.about);
  writeNotNull('coverPhoto', instance.coverPhoto);
  writeNotNull('daily_status', instance.dailyStatus);
  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('nameUpdatedAt', instance.nameUpdatedAt);
  writeNotNull('password', instance.password);
  return val;
}
