import 'package:flutter/material.dart';
import '../model/todo.dart';

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TaskState();
  }
}

class TaskState extends State<Task> {
  TodoProvider todo = TodoProvider();
  List<Todo> allTodoNotDones = new List();

  @override
  void initState() {
    super.initState();
    todo.openDB().then((open) {
      getNotDones();
    });
  }

  void getNotDones() {
    todo.getAllTodoNotDones().then((myList) {
      setState(() {
        allTodoNotDones = myList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (allTodoNotDones.length == 0) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Todo"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, '/new_Subject');
                },
              )
            ],
          ),
          body: Center(
            child: new Text(
              "No data found..",
              textAlign: TextAlign.center,
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Todo"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/new_Subject');
              },
            )
          ],
        ),
        body: new ListView(
          children: allTodoNotDones.map((todoNotDonesItem) {
            return new CheckboxListTile(
              title: new Text(todoNotDonesItem.title),
              value: todoNotDonesItem.done,
              onChanged: (bool value) {
                setState(() {
                  todoNotDonesItem.done = value;
                  todo.update(todoNotDonesItem);
                  getNotDones();
                });
              },
            );
          }).toList(),
        ),
      );
    }
  }
}
