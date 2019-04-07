import 'package:flutter/material.dart';
import '../model/todo.dart';

class NewSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewSubjectState();
  }
}

class NewSubjectState extends State<NewSubject> {
  TodoProvider todo = TodoProvider();
  TextEditingController subject = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            TextFormField(
              controller: subject,
              decoration: InputDecoration(
                  labelText: "Subject", hintText: "please input your subject"),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter some text";
                }
              },
            ),
            RaisedButton(
              child: Text("Save"),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  Todo data = Todo(title: subject.text, done: false);
                  todo.insert(data).then((result) {
                    print("insert");
                    Navigator.pushReplacementNamed(context, "/");
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
