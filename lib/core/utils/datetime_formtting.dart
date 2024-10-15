import 'package:intl/intl.dart';

String formatTime(DateTime? dateTime) {
  if (dateTime == null) {
    return '';
  }
  String formattedTime = DateFormat('hh a').format(dateTime);

  return formattedTime;
}

String formatDate(DateTime? dateTime) {
  if (dateTime == null) {
    return '';
  }
  String formattedDate = DateFormat('dd/MM').format(dateTime);
  return formattedDate;
}
