import 'package:flutter/material.dart';
import '../model/todo.dart';

class Completed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CompletedState();
  }
}

class CompletedState extends State<Completed> {
  TodoProvider todo = TodoProvider();
  List<Todo> allTodoDones = new List();

  @override
  void initState() {
    super.initState();
    todo.openDB().then((r) {
      getAllTodoDones();
    });
  }

  void getAllTodoDones() {
    todo.getAllTodoDones().then((myList) {
      setState(() {
        allTodoDones = myList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (allTodoDones.length == 0) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Todo"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  todo.deleteDones();
                  getAllTodoDones();
                },
              ),
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
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                todo.deleteDones();
                getAllTodoDones();
              },
            ),
          ],
        ),
        body: new ListView(
          children: allTodoDones.map((todoDonesItem) {
            return new CheckboxListTile(
              title: new Text(todoDonesItem.title),
              value: todoDonesItem.done,
              onChanged: (bool value) {
                setState(() {
                  todoDonesItem.done = value;
                  todo.update(todoDonesItem);
                  getAllTodoDones();
                });
              },
            );
          }).toList(),
        ),
      );
    }
  }
}
