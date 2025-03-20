class TaskModel {
  int id;
  String title;
  String description;
  int status; // 0 incomplete, 1 complete
  int due_date;
  int? create_at;
  int? update_at;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.due_date,
    this.create_at,
    this.update_at,
  });
}
