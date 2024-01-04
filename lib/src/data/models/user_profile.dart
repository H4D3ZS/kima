import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable(includeIfNull: false)
class UserProfile extends Equatable {
  final String? id;
  @JsonKey(name: 'user_name')
  final String? userName;
  final String? middleName;
  final String? firstName;
  final String? lastName;
  final String? contactNumber;
  final String? location;
  final String? gender;
  final String? email;
  @JsonKey(name: 'userType')
  final String? type;
  final String? birthDate;
  @JsonKey(name: 'profileAvatar')
  final String? avatar;
  final String? jobTitle;
  @JsonKey(name: 'userDescription')
  final String? about;
  final String? coverPhoto;
  @JsonKey(name: 'daily_status')
  final String? dailyStatus;
  final String? createdAt;
  final String? nameUpdatedAt;
  final String? password;

  const UserProfile({
    this.id,
    this.userName,
    this.middleName,
    this.firstName,
    this.lastName,
    this.contactNumber,
    this.location,
    this.gender,
    this.email,
    this.type,
    this.birthDate,
    this.avatar,
    this.jobTitle,
    this.about,
    this.coverPhoto,
    this.dailyStatus,
    this.createdAt,
    this.nameUpdatedAt,
    this.password,
  });

  UserProfile copyWith({
    String? id,
    String? userName,
    String? middleName,
    String? firstName,
    String? lastName,
    String? contactNumber,
    String? location,
    String? gender,
    String? email,
    String? type,
    String? birthDate,
    String? avatar,
    String? jobTitle,
    String? about,
    String? coverPhoto,
    String? dailyStatus,
    String? createdAt,
    String? nameUpdatedAt,
    String? password,
  }) {
    return UserProfile(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      contactNumber: contactNumber ?? this.contactNumber,
      location: location ?? this.location,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      type: type ?? this.type,
      birthDate: birthDate ?? this.birthDate,
      avatar: avatar ?? this.avatar,
      jobTitle: jobTitle ?? this.jobTitle,
      about: about ?? this.about,
      coverPhoto: coverPhoto ?? this.coverPhoto,
      dailyStatus: dailyStatus ?? this.dailyStatus,
      createdAt: createdAt ?? this.createdAt,
      nameUpdatedAt: nameUpdatedAt ?? this.nameUpdatedAt,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  @override
  String toString() {
    return 'UserProfile{id: $id,  userName: $userName, firstName: $firstName, middleName: $middleName, lastName: $lastName, contactNumber: $contactNumber,  location: $location, gender: $gender, email: $email, type: $type, birthDate: $birthDate,  avatar: $avatar, jobTitle: $jobTitle, about: $about, coverPhoto: $coverPhoto, dailyStatus: $dailyStatus, createdAt: $createdAt, nameUpdateAt: $nameUpdatedAt, password: $password }';
  }

  @override
  List<Object?> get props => [
        id,
        userName,
        firstName,
        middleName,
        lastName,
        contactNumber,
        location,
        gender,
        email,
        type,
        birthDate,
        avatar,
        jobTitle,
        about,
        coverPhoto,
        dailyStatus,
        createdAt,
        nameUpdatedAt,
        password,
      ];
}
