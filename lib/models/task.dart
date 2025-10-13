import 'dart:core';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(0)
  final String id;

  @HiveField(1)
  String description;

  @HiveField(2)
  final DateTime dateTimeOfTask;

  @HiveField(3)
  bool isCompleted;

  Task({required this.id, required this.description, required this.dateTimeOfTask, required this.isCompleted});

  factory Task.create(String description, DateTime dateTime){
    return Task(id: Uuid().v1(), description: description, dateTimeOfTask: dateTime, isCompleted: false);
  }
}