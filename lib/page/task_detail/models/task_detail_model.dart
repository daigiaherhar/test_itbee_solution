import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_itbee_solution/models/task_model.dart';

class TaskDetailModel{
  Rx<TaskModel> taskModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dueController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TaskDetailModel({required this.taskModel});

  close(){
    nameController.dispose();
    descriptionController.dispose();
    dueController.dispose();
  }
}