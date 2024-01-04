// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Events _$EventsFromJson(Map<String, dynamic> json) => Events(
      eventType: json['eventType'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => Ticket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventsToJson(Events instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('eventType', instance.eventType);
  writeNotNull('date', instance.date);
  writeNotNull('time', instance.time);
  writeNotNull('tickets', instance.tickets);
  return val;
}
