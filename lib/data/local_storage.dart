import 'package:hive/hive.dart';

import '../models/task.dart';

abstract class LocalStorage{
  Future<void> addTask({required Task task});
  Future<Task?> getTask({required String id});
  Future<List<Task>> getAllTasks();
  Future<bool> deleteTask({required Task task});
  Future<Task> updateTask({required Task task});
}

class HiveLocalStorage implements LocalStorage{

  late Box<Task> _taskBox;

  HiveLocalStorage() {
    _taskBox = Hive.box<Task>('tasks');
  }

  @override
  Future<void> addTask({required Task task}) async {
    await _taskBox.put(task.id, task);
  }

  @override
  Future<bool> deleteTask({required Task task}) async{
    await task.delete();//delete() function is provided to Task class by making it a HiveType
    return true;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    List<Task> tasklist = <Task>[];
    tasklist = _taskBox.values.toList();
    if(tasklist.isNotEmpty){
      tasklist.sort((a, b) => b.dateTimeOfTask.compareTo(a.dateTimeOfTask));
    }
    return tasklist;
  }

  @override
  Future<Task?> getTask({required String id}) async {
    if(_taskBox.containsKey(id)){
      return _taskBox.get(id);
    }else{
      return null;
    }
  }

  @override
  Future<Task> updateTask({required Task task}) async {
    task.save();//save() function is provided to Task class by making it a HiveType
    return task;
  }

}