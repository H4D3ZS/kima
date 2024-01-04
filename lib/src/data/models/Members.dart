import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

List<Members> memberFromJson(String str) => List<Members>.from(json.decode(str).map((x) => Members.fromJson(x)));

String memberToJson(List<Members> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Members {
  Members({
    this.coverPhoto,
    this.profileAvatar,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.userType,
    this.contactNumber,
    this.location,
    this.userDescription,
    this.jobTitle,
    this.createdAt,
    this.updatedAt,
  });

  @JsonKey(name: 'coverPhoto')
  String? coverPhoto;
  @JsonKey(name: 'profileAvatar')
  String? profileAvatar;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'firstName')
  String? firstName;
  @JsonKey(name: 'lastName')
  String? lastName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'userType')
  String? userType;
  @JsonKey(name: 'contactNumber')
  String? contactNumber;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'userDescription')
  String? userDescription;
  @JsonKey(name: 'jobTitle')
  String? jobTitle;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  // from API
  factory Members.fromJson(Map<String, dynamic> json) => Members(
    coverPhoto: json['coverPhoto'],
    profileAvatar: json['profileAvatar'],
    id: json['id'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    userType: json['userType'],
    contactNumber: json['contactNumber'],
    location: json['location'],
    userDescription: json['userDescription'],
    jobTitle: json['jobTitle'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt']
  );

  // pass to API
  Map<String, dynamic> toJson() {
    return {
      'coverPhoto': coverPhoto,
      'profileAvatar': profileAvatar,
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'userType': userType,
      'contactNumber': contactNumber,
      'location': location,
      'userDescription': userDescription,
      'jobTitle': jobTitle
    };
  }
}