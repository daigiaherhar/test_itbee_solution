import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_themes.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs; // Trạng thái Dark Mode

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? AppThemes.dark : AppThemes.light);
    update();
    print("isDarkMode");
    print(isDarkMode);
  }
}