import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kima/src/data/models/classifieds/attachment.dart';
import 'package:kima/src/data/models/classifieds/events.dart';
import 'package:kima/src/data/models/classifieds/for_sale.dart';
import 'package:kima/src/data/models/classifieds/job_posting.dart';

part 'classifieds.g.dart';

@JsonSerializable(includeIfNull: false)
class Classifieds extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? location;
  final String? category;
  final String? userId;
  final List<Attachment>? gallery;
  final String? createdAt;
  final String? updatedAt;
  final Events? eventDetails;
  final JobPosting? jobPostingDetails;
  final ForSale? forSaleDetails;
  // TODO: Add realEstatesDetails once finalized

  const Classifieds({
    this.id,
    this.title,
    this.description,
    this.location,
    this.category,
    this.userId,
    this.gallery,
    this.createdAt,
    this.updatedAt,
    this.eventDetails,
    this.jobPostingDetails,
    this.forSaleDetails,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        location,
        category,
        userId,
        gallery,
        createdAt,
        updatedAt,
        eventDetails,
        jobPostingDetails,
        forSaleDetails
      ];

  Classifieds copyWith({
    int? id,
    String? title,
    String? description,
    String? location,
    String? category,
    String? userId,
    List<Attachment>? gallery,
    String? createdAt,
    String? updatedAt,
    Events? eventDetails,
    JobPosting? jobPostingDetails,
    ForSale? forSaleDetails,
  }) =>
      Classifieds(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        location: location ?? this.location,
        category: category ?? this.category,
        userId: userId ?? this.userId,
        gallery: gallery ?? this.gallery,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        eventDetails: eventDetails ?? this.eventDetails,
        jobPostingDetails: jobPostingDetails ?? this.jobPostingDetails,
        forSaleDetails: forSaleDetails ?? this.forSaleDetails,
      );

  Map<String, dynamic> toJson() => _$ClassifiedsToJson(this);

  factory Classifieds.fromJson(Map<String, dynamic> json) => _$ClassifiedsFromJson(json);

  @override
  String toString() {
    return 'Classifieds{id: $id, title: $title, description: $description, '
        'location: $location, category: $category, userId: $userId, '
        'gallery: $gallery, createdAt: $createdAt, updatedAt: $updatedAt, '
        'eventDetails: $eventDetails, jobPostingDetails: $jobPostingDetails, forSaleDetails: $forSaleDetails}';
  }
}
