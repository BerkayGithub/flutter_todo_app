import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_todo_app/models/task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _showAddTaskBottomSheet(context);
          },
          child: Text(
            "Bugün neler yapacaksın ?",
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
            onPressed: () {
              _showAddTaskBottomSheet(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              decoration: InputDecoration(
                hintText: "Görev nedir ?",
                border: InputBorder.none,
              ),
              onSubmitted: (value){
                Navigator.of(context).pop();
                if(value.length > 3){
                  DatePicker.showTimePicker(context, showSecondsColumn: false, onConfirm: (time){
                    final newTask = Task.create(value, time);
                  });
                }
              },
            ),
          ),
        );
      },
    );
  }
}
