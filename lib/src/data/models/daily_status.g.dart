// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyStatus _$DailyStatusFromJson(Map<String, dynamic> json) => DailyStatus(
      id: json['id'] as int?,
      statusContent: json['statusContent'] as String?,
      oldStatusContent: json['oldStatusContent'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$DailyStatusToJson(DailyStatus instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('statusContent', instance.statusContent);
  writeNotNull('oldStatusContent', instance.oldStatusContent);
  writeNotNull('updatedAt', instance.updatedAt);
  writeNotNull('createdAt', instance.createdAt);
  return val;
}
