import 'package:intl/intl.dart';

String readTimestamp(int timestamp, String formatDatime) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String dateTime = DateFormat(formatDatime).format(date);
  return dateTime;
}
