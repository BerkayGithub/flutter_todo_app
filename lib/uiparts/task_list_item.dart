import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:intl/intl.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  late LocalStorage _localStorage;

  void setup(){
    _localStorage = locator<LocalStorage>();
  }

  @override
  void initState() {
    super.initState();
    _taskDescriptionController.text = widget.task.description;
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(127), blurRadius: 10),
        ],
      ),
      child: ListTile(
        title: widget.task.isCompleted
            ? Text(
                widget.task.description,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              )
            : TextField(
                controller: _taskDescriptionController,
                decoration: InputDecoration(border: InputBorder.none),
                minLines: 1,
                maxLines: null,
                textInputAction: TextInputAction.done,
                onSubmitted: (yeniDeger) {
                  if (yeniDeger.length > 3) {
                    setState(() {
                      widget.task.description = yeniDeger;
                      _localStorage.updateTask(task: widget.task);
                    });
                  }
                },
              ),
        trailing: Text(
          DateFormat('hh:mm a').format(widget.task.dateTimeOfTask),
          style: TextStyle(color: Colors.blue.shade300, fontSize: 14),
        ),
        leading: GestureDetector(
          onTap: () {
            setState(() {
              widget.task.isCompleted = !widget.task.isCompleted;
              _localStorage.updateTask(task: widget.task);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.task.isCompleted ? Colors.green : Colors.white,
              border: Border.all(color: Colors.grey, width: 0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
