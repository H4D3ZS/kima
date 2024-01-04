import 'package:flutter_svg/flutter_svg.dart';
import 'package:json_annotation/json_annotation.dart';

class FieldEntity {
  String title;
  String key;
  SvgPicture? iconData;
  SvgPicture? iconDataActive;
  String? textHints;
  String? value;
  String? defaultValue;

  FieldEntity({
    required this.title,
    required this.key,
    this.iconData,
    this.iconDataActive,
    this.textHints,
    this.value,
    this.defaultValue
  });
}

class Classified {
  int? id;
  @JsonKey(name: 'user_id')
  int? userID;
  String? category;
  String? title;
  String? location;
  String? description;
  dynamic gallery;
  String? price;
  @JsonKey(name: 'event_date')
  String? eventDate;
  @JsonKey(name: 'event_time')
  @JsonKey(name: 'item_condition')
  String? itemCondition;
  String? eventTime;
  dynamic tickets;
  dynamic sections;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;




  Classified({

    this.id,
    this.userID,
    this.category,
    this.title,
    this.location,
    this.description,
    this.gallery,
    this.price,
    this.eventDate,
    this.eventTime,
    this.itemCondition,
    this.tickets,
    this.sections,
    this.createdAt,
    this.updatedAt,
    this.deletedAt
  });

  Map<String, dynamic> toMap(Classified classified) {
    return {
      'id': classified.id.toString(),
      // 'userID': classified.userID,
      'category': classified.category,
      'title': classified.title,
      'location': classified.location,
      'description': classified.description,
      'gallery': classified.gallery,
      'price': classified.price,
      'event_date': classified.eventDate,
      'event_time': classified.eventTime,
      'tickets': classified.tickets,
      'itemCondition': classified.itemCondition,
      'sections': classified.sections,
      'createdAt': classified.createdAt,
      'updatedAt': classified.updatedAt,
      'deletedAt': classified.deletedAt,
    };
  }

  factory Classified.fromJson(Map<String, dynamic> data) {
    return Classified(
        id: data['id'],
        userID: data['user_id'],
        category: data['category'],
        title: data['title'],
        location: data['location'],
        description: data['description'],
        gallery: data['gallery'],
        price: data['price'],
        eventDate: data['event_date'],
        eventTime: data['event_time'],
        tickets: data['tickets'],
        itemCondition: data['item_condition'],
        sections: data['sections'],
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
        deletedAt: data['deleted_at']
    );
  }

}