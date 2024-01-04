import 'package:intl/intl.dart';

String getFormattedDate({
    required String date,
    String? format = 'MMM dd, yyyy'
  }) {
    if (date != '') {
      final parsed = DateTime.parse(date);
      final DateFormat formatter = DateFormat(format);
      final String formatted = formatter.format(parsed);
      return formatted;
    } else {
      return '';
    }
  }

  String getFormattedTime(String time) {
    if (time != '') {
      DateTime dateTime = DateFormat("HH:mm").parse(time);
      String formattedTime = DateFormat("hh:mm a").format(dateTime);
      return formattedTime;
    } else {
      return '';
    }
  }