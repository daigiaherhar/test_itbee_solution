
import 'package:get/get.dart';
import 'package:test_itbee_solution/page/task_detail/bindings/task_detail_binding.dart';
import 'package:test_itbee_solution/page/task_detail/view/task_detail_view.dart';

import '../page/home/bindings/home_binding.dart';
import '../page/home/view/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),   GetPage(
      name: _Paths.TASK_DETAIL,
      page: () => TaskDetailView(),
      binding: TaskDetailBinding(),
    ),
  ];
}