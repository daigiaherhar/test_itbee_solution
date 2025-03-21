import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../dialogs/dialog_core.dart';
import '../../../models/task_model.dart';
import '../../../repositorys/task_repository.dart';
import '../../../utils/utils.dart';
import '../models/task_detail_model.dart';

class TaskDetailController extends GetxController {
  TaskDetailModel taskDetailModel = TaskDetailModel(
    taskModel: TaskModel(title: '', description: '', dueDate: 0).obs,
  );
  RxBool isEdit = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    _init();

    super.onInit();
  }

  _init() {
    if (Get.arguments != null) {
      isEdit.value = true;
      TaskModel data = Get.arguments;
      taskDetailModel.taskModel.value = data;
      taskDetailModel.nameController.text = data.title;
      taskDetailModel.descriptionController.text = data.description;
      taskDetailModel.dueController.text = Utils.convertTimestamp(data.dueDate);
    }
  }

  submit({required ActionTask action}) async {
    if (taskDetailModel.formKey.currentState!.validate()) {
      switch (action) {
        case ActionTask.create:
          // TODO: Handle this case.
          print("taskDetailModel.dueController.text22");
          print(taskDetailModel.dueController.text);
          DateTime dateTime = DateTime.parse(
            "${taskDetailModel.dueController.text.split(' ')[0].split('-').reversed.join('-')}T${taskDetailModel.dueController.text.split(' ')[1]}:00",
          );

          return Get.back(
            result: {
              "action": action,
              "task": TaskModel(
                title: taskDetailModel.nameController.text,
                description: taskDetailModel.descriptionController.text,
                dueDate: dateTime.microsecondsSinceEpoch,
                createAt: DateTime.now().microsecondsSinceEpoch,
              ),
            },
          );
        case ActionTask.update:
          DateTime dateTime = DateTime.parse(
            "${taskDetailModel.dueController.text.split(' ')[0].split('-').reversed.join('-')}T${taskDetailModel.dueController.text.split(' ')[1]}:00",
          );
          return Get.back(
            result: {
              "action": action,
              "task": TaskModel(
                id: taskDetailModel.taskModel.value.id,
                title: taskDetailModel.nameController.text,
                description: taskDetailModel.descriptionController.text,
                dueDate: dateTime.microsecondsSinceEpoch,
                createAt: taskDetailModel.taskModel.value.createAt,
                status: taskDetailModel.taskModel.value.status,
                updateAt: DateTime.now().microsecondsSinceEpoch,
              ),
            },
          );
        case ActionTask.delete:
          // TODO: Handle this case.
          return DialogCore.showQuestion().then((value) {
            if (value != null) {
              if (value == true) {
                return Get.back(
                  result: {
                    "action": action,
                    "task": TaskModel(
                      id: taskDetailModel.taskModel.value.id,
                      title: taskDetailModel.nameController.text,
                      description: taskDetailModel.descriptionController.text,
                      dueDate: 0,
                    ),
                  },
                );
              }
            }
          });
      }
    }
  }

  @override
  void dispose() {
    taskDetailModel.close();
    super.dispose();
  }
}
