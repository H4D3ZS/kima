// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      id: json['id'],
      reason: json['reason'] as String?,
      details: json['details'] as String?,
    );

Map<String, dynamic> _$ReportToJson(Report instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('reason', instance.reason);
  writeNotNull('details', instance.details);
  return val;
}
