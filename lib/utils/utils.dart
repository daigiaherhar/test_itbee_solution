import 'package:intl/intl.dart';

class Utils {
  static String convertTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    // Format to dd-MM-yyyy hh:mm
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
    return formattedDate;
  }
}
