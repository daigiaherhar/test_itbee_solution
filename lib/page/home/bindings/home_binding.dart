import 'package:get/get.dart';

import '../../../repositorys/task_repository.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<HomeController>(() => HomeController()),
      Bind.lazyPut<TaskRepository>(() => TaskRepository()),
    ];
  }

  // @override
  // void dependencies() {
  //   Get.lazyPut<HomeController>(() => HomeController());
  //
  // }
}
