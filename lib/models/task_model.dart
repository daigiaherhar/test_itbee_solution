class TaskModel {
  int? id;
  String title;
  String description;
  int status; // 0 incomplete, 1 complete
  int dueDate;
  int? createAt;
  int? updateAt;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.status = 0,
    required this.dueDate,
    this.createAt,
    this.updateAt,
  });

  bool isCheck() {
    if (status == 0) {
      return false;
    } else if (status == 1) {
      return true;
    }
    return false;
  }

  int intCheck(bool isCheck) {
    if (isCheck == false) {
      return 0;
    } else if (isCheck == true) {
      return 1;
    }
    return 0;
  }

  TaskModel.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      title = json["title"] ?? "",
      description = json["description"] ?? "",
      status = json["status"] ?? "",
      dueDate = json["due_date"],
      updateAt = json["update_at"],
      createAt = json["create_at"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'due_date': dueDate,
      'create_at': createAt ?? DateTime.now().microsecondsSinceEpoch,
      'update_at': updateAt ?? 0,
    };
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, title: $title, description: $description, status: $status, dueDate: $dueDate, createAt: $createAt, updateAt: $updateAt}';
  }
}
