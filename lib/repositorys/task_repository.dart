import 'package:get/get.dart';

import '../models/task_model.dart';
import '../services/database_service.dart';

enum ActionTask { create, update, delete }

class TaskRepository {
  final _dbService = Get.find<DatabaseService>();

  Future<int> insert(TaskModel task) async {
    final db = await _dbService.database;
    return await db.insert('task', task.toMap());
  }

  Future<List<TaskModel>> read() async {
    final db = await _dbService.database;
    List<Map<String, dynamic>> maps = await db.query(
      'task',
      orderBy: 'id DESC',
    );
    return maps.map((map) => TaskModel.fromJson(map)).toList();
  }

  Future<List<TaskModel>> readStatus() async {
    final db = await _dbService.database;
    List<Map<String, dynamic>> maps = await db.query(
      'task',
      where: 'status = ?',
      whereArgs: [0],
      orderBy: 'id DESC',
    );
    return maps.map((map) => TaskModel.fromJson(map)).toList();
  }

  Future<int> update(TaskModel task) async {
    final db = await _dbService.database;
    return await db.update(
      'task',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> updateStatus(TaskModel task) async {
    final db = await _dbService.database;
    return await db.update(
      'task',
      {'status': task.status},
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _dbService.database;
    return await db.delete('task', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TaskModel>> searchName(String query) async {
    final db = await _dbService.database;
    List<TaskModel> list = [];
    List<Map<String, dynamic>> listData = await db.query(
      'task',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'id DESC',
    );
    list = listData.map((map) => TaskModel.fromJson(map)).toList();
    return list;
  }
}
