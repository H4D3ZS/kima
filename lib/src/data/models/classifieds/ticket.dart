import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable(includeIfNull: false)
class Ticket extends Equatable {
  final String? title;
  final double? price;

  const Ticket({
    this.title,
    this.price,
  });

  @override
  List<Object?> get props => [title, price];

  Ticket copyWith({
    String? title,
    double? price,
  }) =>
      Ticket(
        title: title ?? this.title,
        price: price ?? this.price,
      );

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  @override
  String toString() {
    return 'Ticket{title: $title, price: $price}';
  }
}
