import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/data/models/report.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';

class ReportListCubit extends Cubit<List<Report>> {
  ReportListCubit() : super(reports);

  static final reports = ReportEnum.values.map((report) => Report(reason: report.name)).toList();

  void select(Report report) => emit(
        Listing.reports
            .groupByType(report.reason!)
            .map((report) => Report(reason: report.reason, details: report.details))
            .toList(),
      );

  void reset() => emit(reports);
}
