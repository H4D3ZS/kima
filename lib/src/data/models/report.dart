import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report.g.dart';

@JsonSerializable(includeIfNull: false)
class Report extends Equatable {
  final dynamic id;
  final String? reason;
  final String? details;

  const Report({
    this.id,
    this.reason,
    this.details,
  });

  @override
  List<Object?> get props => [id, reason, details];

  Report copyWith({
    dynamic id,
    String? reason,
    String? details,
  }) =>
      Report(
        id: id ?? this.id,
        reason: reason ?? this.reason,
        details: details ?? this.details,
      );

  Map<String, dynamic> toJson() => _$ReportToJson(this);

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  @override
  String toString() {
    return 'Report{id: $id, reason: $reason, details: $details}';
  }
}
