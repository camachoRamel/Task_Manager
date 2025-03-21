abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  final String description;
  final dueDate;

  AddTask(this.title, this.description, this.dueDate);
}

class UpdateTask extends TaskEvent {
  final String id;
  final String title;
  final String description;
  final String dueDate;

  UpdateTask(this.id, this.title, this.description, this.dueDate);
}

class DeleteTask extends TaskEvent {
  final String id;

  DeleteTask(this.id);
}
