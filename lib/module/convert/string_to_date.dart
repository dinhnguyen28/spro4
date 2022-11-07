import 'package:intl/intl.dart';

String stringToTimeStamp(String stringDate) {
  DateFormat format = DateFormat("dd/MM/yyyy");

  if (stringDate == "") {
    return "";
  } else {
    DateTime formatDate = format.parse(stringDate);
    return formatDate.millisecondsSinceEpoch.toString();
  }
}
