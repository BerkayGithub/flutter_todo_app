import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/local_storage.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/uiparts/task_list_item.dart';

class CustomSearchDelegate extends SearchDelegate{

  final List<Task> allTasks;

  CustomSearchDelegate({required this.allTasks});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query.isEmpty ? null : query = '';
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: (){
        close(context, null);
      },
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.red,
        size: 24
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Task> filteredList = allTasks.where((gorev) => gorev.description.toLowerCase().contains(query.toLowerCase())).toList();
    return filteredList.length > 0 ? ListView.builder(
      itemBuilder: (context, index) {
        var oankiEleman = filteredList[index];
        return Dismissible(
            background: Row(
              children: [
                Icon(Icons.delete),
                Text("remove_task").tr()
              ],
            ),
            key: Key(oankiEleman.id),
            onDismissed: (direction) async{
              filteredList.removeAt(index);
              await locator<LocalStorage>().deleteTask(task: oankiEleman);// hızlı bir işlem için locator'a bu şekilde ulaşabiliriz
            },
            child: TaskListItem(task: oankiEleman)
        );
      },
      itemCount: filteredList.length,
    ) : Center(child: Text("search_not_found").tr());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }

}