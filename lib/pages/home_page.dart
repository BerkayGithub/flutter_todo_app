import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/helper/translation_helper.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/uiparts/custom_search_delegate.dart';
import 'package:flutter_todo_app/uiparts/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> taskList;
  late LocalStorage _localStorage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskList = <Task>[];
    _localStorage = locator<LocalStorage>();
    _getAllTaskFromDb();
  }

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
            "title",
            style: TextStyle(color: Colors.black),
          ).tr(),
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {
            _showSearchPage();
          }, icon: Icon(Icons.search)),
          IconButton(
            onPressed: () {
              _showAddTaskBottomSheet(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: taskList.isNotEmpty ? ListView.builder(
        itemBuilder: (context, index) {
          var oankiEleman = taskList[index];
          return Dismissible(
            background: Row(
              children: [
                Icon(Icons.delete),
                Text("remove_task").tr()
              ],
            ),
            key: Key(oankiEleman.id),
            onDismissed: (direction){
              taskList.removeAt(index);
              _localStorage.deleteTask(task: oankiEleman);
              setState(() {
              });
            },
            child: TaskListItem(task: oankiEleman)
          );
        },
        itemCount: taskList.length,
      ): Center(
        child: Text("empty_task_list").tr(),
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
              autofocus: true,
              decoration: InputDecoration(
                hintText: "add_task".tr(),
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                Navigator.of(context).pop();
                if (value.length > 3) {
                  DatePicker.showTimePicker(
                    context,
                    locale: TranslationHelper.getDeviceLanguage(context),
                    showSecondsColumn: false,
                    onConfirm: (time) async{
                      final newTask = Task.create(value, time);
                      taskList.insert(0, newTask);
                      await _localStorage.addTask(task: newTask);
                      setState(() {});
                    },
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _getAllTaskFromDb() async{
    taskList = await _localStorage.getAllTasks();
    setState(() {
    });
  }

  void _showSearchPage() async{
    await showSearch(context: context, delegate: CustomSearchDelegate(allTasks: taskList));
    _getAllTaskFromDb();
  }
}
