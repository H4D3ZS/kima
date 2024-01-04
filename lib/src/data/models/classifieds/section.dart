import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section.g.dart';

@JsonSerializable(includeIfNull: false)
class Section extends Equatable {
  final String title;
  final double details;

  const Section({
    required this.title,
    required this.details,
  });

  @override
  List<Object?> get props => [title, details];

  Section copyWith({
    String? title,
    double? details,
  }) =>
      Section(
        title: title ?? this.title,
        details: details ?? this.details,
      );

  Map<String, dynamic> toJson() => _$SectionToJson(this);

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);

  @override
  String toString() {
    return 'Section{title: $title, details: $details}';
  }
}
