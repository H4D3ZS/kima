import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kima/src/data/models/classifieds/section.dart';

part 'job_posting.g.dart';

@JsonSerializable(includeIfNull: false)
class JobPosting extends Equatable {
  final String employmentType;
  final double? salary;
  final List<Section> sections;

  const JobPosting({
    required this.employmentType,
    required this.salary,
    required this.sections,
  });

  @override
  List<Object?> get props => [employmentType, salary, sections];

  JobPosting copyWith({
    String? employmentType,
    double? salary,
    List<Section>? sections,
  }) =>
      JobPosting(
        employmentType: employmentType ?? this.employmentType,
        salary: salary ?? this.salary,
        sections: sections ?? this.sections,
      );

  Map<String, dynamic> toJson() => _$JobPostingToJson(this);

  factory JobPosting.fromJson(Map<String, dynamic> json) => _$JobPostingFromJson(json);

  @override
  String toString() {
    return 'JobPosting{employmentType: $employmentType, salary: $salary, sections: $sections}';
  }
}
