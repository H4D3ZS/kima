// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classifieds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Classifieds _$ClassifiedsFromJson(Map<String, dynamic> json) => Classifieds(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      category: json['category'] as String?,
      userId: json['userId'] as String?,
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      eventDetails: json['eventDetails'] == null
          ? null
          : Events.fromJson(json['eventDetails'] as Map<String, dynamic>),
      jobPostingDetails: json['jobPostingDetails'] == null
          ? null
          : JobPosting.fromJson(
              json['jobPostingDetails'] as Map<String, dynamic>),
      forSaleDetails: json['forSaleDetails'] == null
          ? null
          : ForSale.fromJson(json['forSaleDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClassifiedsToJson(Classifieds instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('location', instance.location);
  writeNotNull('category', instance.category);
  writeNotNull('userId', instance.userId);
  writeNotNull('gallery', instance.gallery);
  writeNotNull('createdAt', instance.createdAt);
  writeNotNull('updatedAt', instance.updatedAt);
  writeNotNull('eventDetails', instance.eventDetails);
  writeNotNull('jobPostingDetails', instance.jobPostingDetails);
  writeNotNull('forSaleDetails', instance.forSaleDetails);
  return val;
}
