import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_itbee_solution/consttants/const_colors.dart';

class DialogCore {
  static showLoadingIndicator() {
    return Get.dialog(
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: ConstColors.orange),
            SizedBox(height: 10),
            Text(
              "Đang tải",
              style: TextStyle(
                fontSize: 14,
                color: ConstColors.orange,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

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
    // dateTime = date;
    TimeOfDay time =
        await showTimePicker(
          context: Get.context!,

          builder: (context, child) {
            return child!;
          },
          initialTime: TimeOfDay.now(),
        ) ??
        TimeOfDay.now();

    // dateTime = dateTime.add(Duration(hours: time.hour, minutes: time.minute));
    dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    return dateTime;
  }

  static Future<dynamic> showQuestion() async {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bạn muốn xóa công việc này?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            actionsPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Hủy",
                      // style: TextStyle(color: AppColors.dark),
                    ),
                    style: TextButton.styleFrom(
                      // foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xff333333)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Xóa"),
                    style: TextButton.styleFrom(
                      foregroundColor: ConstColors.white,
                      backgroundColor: ConstColors.orange,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: ConstColors.orange),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }

  static Future<dynamic> showSnack(String message) async {
    return Get.showSnackbar(
      GetSnackBar(message: message, duration: Duration(milliseconds: 1000)),
    );
  }
}
