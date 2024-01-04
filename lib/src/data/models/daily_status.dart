import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_status.g.dart';

@JsonSerializable(includeIfNull: false)
class DailyStatus extends Equatable {
  final int? id;
  final String? statusContent;
  final String? oldStatusContent;
  final String? updatedAt;
  final String? createdAt;

  const DailyStatus({
    this.id,
    this.statusContent,
    this.oldStatusContent,
    this.updatedAt,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, statusContent, oldStatusContent, updatedAt, createdAt];

  DailyStatus copyWith({
    int? id,
    String? statusContent,
    String? oldStatusContent,
    String? updatedAt,
    String? createdAt,
  }) =>
      DailyStatus(
        id: id ?? this.id,
        statusContent: statusContent ?? this.statusContent,
        oldStatusContent: oldStatusContent ?? this.oldStatusContent,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() => _$DailyStatusToJson(this);

  factory DailyStatus.fromJson(Map<String, dynamic> json) => _$DailyStatusFromJson(json);

  @override
  String toString() {
    return 'DailyStatus{id: $id, statusContent: $statusContent, oldStatusContent: $oldStatusContent, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
