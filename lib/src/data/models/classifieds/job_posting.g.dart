// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_posting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPosting _$JobPostingFromJson(Map<String, dynamic> json) => JobPosting(
      employmentType: json['employmentType'] as String,
      salary: (json['salary'] as num?)?.toDouble(),
      sections: (json['sections'] as List<dynamic>)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobPostingToJson(JobPosting instance) {
  final val = <String, dynamic>{
    'employmentType': instance.employmentType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('salary', instance.salary);
  val['sections'] = instance.sections;
  return val;
}
