import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_itbee_solution/models/task_model.dart';

class HomeModel {
  // RxList<TaskModel> listTaskOriginal;
  RxList<TaskModel> listTask;
  TextEditingController searchController = TextEditingController();
  HomeModel({required this.listTask});
}
