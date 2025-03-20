import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogCore {
  static Future<DateTime?> showDateTime() async {
    DateTime? dateTime;
    DateTime? date = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 90)),
      currentDate: DateTime.now(),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return child!;
      },
    );
    if (date == null) {
      return dateTime;
    }
    dateTime = date;
    TimeOfDay time =
        await showTimePicker(
          context: Get.context!,

          builder: (context, child) {
            return child!;
          },
          initialTime: TimeOfDay.now(),
        ) ??
        TimeOfDay.now();
    dateTime = dateTime.add(Duration(hours: time.hour, minutes: time.minute));

    return dateTime;
  }
}
