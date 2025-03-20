class Utils {
  static String convertTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    // Format to dd-MM-yyyy hh:mm
    String formattedDate = "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
    return formattedDate;
  }
}
