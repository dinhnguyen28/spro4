import 'package:intl/intl.dart';

String readTimestamp(int timestamp, String formatDatime) {
  if (timestamp == 0) {
    return "";
  }
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String dateTime = DateFormat(formatDatime).format(date);
  return dateTime;
}
