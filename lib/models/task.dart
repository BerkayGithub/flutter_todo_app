import 'dart:core';

import 'package:uuid/uuid.dart';

class Task{
  final String id;
  final String description;
  final DateTime dateTimeOfTask;
  final bool isCompleted;

  Task({required this.id, required this.description, required this.dateTimeOfTask, required this.isCompleted});

  factory Task.create(String description, DateTime dateTime){
    return Task(id: Uuid().v1(), description: description, dateTimeOfTask: dateTime, isCompleted: false);
  }
}