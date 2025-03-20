import 'package:get/get.dart';
import 'package:test_itbee_solution/models/task_model.dart';
import 'package:test_itbee_solution/theme/theme_controller.dart';

import '../../../dialogs/create_task_dialog.dart';
import '../../../repositorys/task_repository.dart';
import '../../../services/database_service.dart';
import '../models/home_model.dart';

class HomeController extends GetxController {
  final themeController = Get.find<ThemeController>();
  final taskRepository = Get.find<TaskRepository>();
  HomeModel homeModel = HomeModel(
    listTask: <TaskModel>[].obs,
    // listTaskOriginal: <TaskModel>[].obs,
  );

  @override
  void onInit() {
    // TODO: implement onInit
    print("HomeControllerHomeController");

    _initData();
    super.onInit();
  }

  _initData() async {
    print("await taskRepository.read()");
    readTask();
  }

  readTask() async {
    homeModel.listTask.value = await taskRepository.read();
    // homeModel.listTask.value = homeModel.listTaskOriginal.value;
  }

  handleCreateTask() async {
    await createTaskDialog().then((value) {
      if (value != null) {
        TaskModel taskModel = value;
        createTask(taskModel);
        // print();
      }
    });
  }

  handleCheck(TaskModel data) async {
    TaskModel newTask = data;
    await taskRepository.update(data);

    int index = homeModel.listTask.indexWhere((item) => item.id == data.id);
    if (index != -1) {
      homeModel.listTask[index] = newTask;
      // update();
    }
    // int indexOriginal = homeModel.listTask.indexWhere((item) => item.id == idTask);
  }

  createTask(TaskModel data) async {
    TaskModel newTask = data;
    int idNewTask = await taskRepository.insert(data);
    newTask.id = idNewTask;
    // homeModel.listTaskOriginal.add(newTask);
    homeModel.listTask.insert(0, newTask);
  }

  filterTask({int type = 0}) async {
    //type 0 all. 1 !=0
    if (type == 0) {
      readTask();
    } else if (type == 1) {
      homeModel.listTask.value = await taskRepository.readStatus();
      // homeModel.listTask.assignAll(
      //   homeModel.listTaskOriginal.where((task) => task.status == 0).toList(),
      // );
      // homeModel.listTask.refresh();
    }
  }
}
