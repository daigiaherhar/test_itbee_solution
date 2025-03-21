import 'package:get/get.dart';

import '../../../repositorys/task_repository.dart';
import '../controller/task_detail_controller.dart';

class TaskDetailBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<TaskDetailController>(() => TaskDetailController()),
      Bind.lazyPut<TaskRepository>(() => TaskRepository()),
    ];
  }
}
