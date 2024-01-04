import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kima/src/data/models/classifieds/ticket.dart';

part 'events.g.dart';

@JsonSerializable(includeIfNull: false)
class Events extends Equatable {
  final String? eventType;
  final String? date;
  final String? time;
  final List<Ticket>? tickets;

  const Events({
    this.eventType,
    this.date,
    this.time,
    this.tickets,
  });

  @override
  List<Object?> get props => [eventType, date, time, tickets];

  Events copyWith({
    String? eventType,
    String? date,
    String? time,
    List<Ticket>? tickets,
  }) =>
      Events(
        eventType: eventType ?? this.eventType,
        date: date ?? this.date,
        time: time ?? this.time,
        tickets: tickets ?? this.tickets,
      );

  Map<String, dynamic> toJson() => _$EventsToJson(this);

  factory Events.fromJson(Map<String, dynamic> json) => _$EventsFromJson(json);

  @override
  String toString() {
    return 'Events{eventType: $eventType, date: $date, time: $time, tickets: $tickets}';
  }
}
