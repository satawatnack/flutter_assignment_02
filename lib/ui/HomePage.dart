import 'package:flutter/material.dart';
import '../model/todo.dart';
import './Task.dart';
import './Completed.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  TodoProvider todo = TodoProvider();
  final _myPage = [Task(), Completed()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _myPage[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.menu), title: Text("Task")),
          new BottomNavigationBarItem(
              icon: Icon(Icons.done_all), title: Text("Completed"))
        ],
      ),
    );
  }
}
