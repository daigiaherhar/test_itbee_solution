import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:test_itbee_solution/page/home/view/home_view.dart';
import 'package:test_itbee_solution/routes/app_pages.dart';
import 'package:test_itbee_solution/services/database_service.dart';
import 'package:test_itbee_solution/theme/app_themes.dart';
import 'package:test_itbee_solution/theme/theme_controller.dart';
import 'package:test_itbee_solution/utils/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void initServices() async {
  print('starting services ...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.

  print('All services started...');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  var databaseFactory = databaseFactoryFfi;

  if (kIsWeb) {
    // Change default factory on the web
    databaseFactory = databaseFactoryFfiWeb;
    // path = 'my_web_web.db';
  }
  final ThemeController themeController = Get.put(ThemeController());
  Get.put(DatabaseService.instance);
  try {

    // final DatabaseService _sad = DatabaseService.instance;

  } catch (e) {
    print("eeeeeeeeeeeee"); // Catches all types of `Exception` and `Error`.
    print(e); // Catches all types of `Exception` and `Error`.
    // _setToken("");
  }
  runApp(
    DismissKeyboard(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme:
            themeController.isDarkMode.value ? AppThemes.dark : AppThemes.light,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        defaultTransition: Transition.rightToLeft,
        debugShowCheckedModeBanner: false,
        locale: Locale("vi"),
        supportedLocales: [Locale("vi")],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const HomeView(),
      ),
    ),
  );
}
