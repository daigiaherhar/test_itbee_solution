import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_itbee_solution/models/task_model.dart';
import 'package:test_itbee_solution/theme/theme_controller.dart';

import '../../../dialogs/create_task_dialog.dart';
import '../../../dialogs/dialog_core.dart';
import '../../../repositorys/task_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/database_service.dart';
import '../models/home_model.dart';

class HomeController extends GetxController {
  final themeController = Get.find<ThemeController>();
  final taskRepository = Get.find<TaskRepository>();
  HomeModel homeModel = HomeModel(
    listTask: <TaskModel>[].obs,
    // listTaskOriginal: <TaskModel>[].obs,
  );
  Timer _debounce = Timer(Duration(seconds: 0), () {});

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      DialogCore.showLoadingIndicator();
      homeModel.listTask.value = await taskRepository.read();
      // homeModel.listTask.value = homeModel.listTaskOriginal.value;
      homeModel.searchController.clear();
      FocusManager.instance.primaryFocus!.unfocus();
      if (Get.isDialogOpen!) Navigator.pop(Get.context!);
    });
  }

  _updateTask(TaskModel data) async {
    DialogCore.showLoadingIndicator();
    TaskModel newTask = data;
    await taskRepository.update(data);

    int index = homeModel.listTask.indexWhere((item) => item.id == data.id);

    if (index != -1) {
      homeModel.listTask[index] = newTask;

      if (Get.isDialogOpen!) Navigator.pop(Get.context!);

      DialogCore.showSnack("Cập nhật thành công");
    }
  }

  handleCheck(TaskModel data) async {
    TaskModel newTask = data;
    await taskRepository.updateStatus(data);

    int index = homeModel.listTask.indexWhere((item) => item.id == data.id);
    if (index != -1) {
      homeModel.listTask[index] = newTask;
    }
  }

  _createTask(TaskModel data) async {
    DialogCore.showLoadingIndicator();
    TaskModel newTask = data;
    int idNewTask = await taskRepository.insert(data);
    newTask.id = idNewTask;
    homeModel.listTask.insert(0, newTask);
    if (Get.isDialogOpen!) Navigator.pop(Get.context!);
    DialogCore.showSnack("Tạo mới thành công");
  }

  _deleteTask(TaskModel data) async {
    DialogCore.showLoadingIndicator();
    TaskModel newTask = data;
    if (newTask.id != null) {
      int idNewTask = await taskRepository.delete(newTask.id!);
      homeModel.listTask.removeWhere((element) => element.id == newTask.id);
      if (Get.isDialogOpen!) Navigator.pop(Get.context!);
      DialogCore.showSnack("Xóa thành công");
    }
  }

  // _updateTask(TaskModel data) async {
  //   TaskModel newTask = data;
  //   int idNewTask = await taskRepository.update(data);
  //   int index = homeModel.listTask.indexWhere((item) => item.id == data.id);
  //   // homeModel.listTaskOriginal.add(newTask);
  //   homeModel.listTask.insert(0, newTask);
  // }

  filterTask({int type = 0}) async {
    //type 0 all. 1 !=0
    if (type == 0) {
      readTask();

    } else if (type == 1) {
      // homeModel.listTask.value = await taskRepository.readStatus();
      homeModel.listTask.assignAll(
        homeModel.listTask.where((task) => task.status == 0).toList(),
      );
      // homeModel.listTask.refresh();
    }
  }

  navigator({TaskModel? arguments}) {
    Get.toNamed(Routes.TASK_DETAIL, arguments: arguments)?.then((value) {
      if (value != null) {
        final ActionTask actionTask = value['action'];
        switch (actionTask) {
          case ActionTask.create:
            //create
            TaskModel taskModel = value['task'];
            _createTask(taskModel);
            break;
          case ActionTask.update:
            //update
            TaskModel taskModel = value['task'];
            _updateTask(taskModel);
            break;
          case ActionTask.delete:
            //delete
            TaskModel taskModel = value['task'];
            _deleteTask(taskModel);
            break;
        }
      }
    });
  }

  searchByName(String query) async {
    if (_debounce.isActive) {
      _debounce.cancel();
    }
    _debounce = Timer(const Duration(seconds: 1), () async {
      final list = await taskRepository.searchName(query);
      homeModel.listTask.value =
          list
              .where(
                (item) =>
                    item.title.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  void dispose() {
    _debounce.cancel();
    homeModel.searchController.dispose();
    super.dispose();
  }
}
