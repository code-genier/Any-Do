import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/components/dialog_box.dart';
import 'package:to_do_app/components/todo_tile.dart';
import 'package:to_do_app/data/todoDb.dart';
import 'package:to_do_app/pages/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference hive box
  final _myBox = Hive.box("myBox");

  // create instance of todo list db class
  ToDoDB db = ToDoDB();

  @override
  void initState() { // when app first runs it calls automatically
    // if first time ever open the app
    // create a default data
    if(_myBox.get("TODOLIST") == null && _myBox.get("DEFAULTTODOLIST") == null){
      db.createInitialData();
    }
    else{
      db.loadData();
      db.createInitialData();
    }

    // TODO: implement initState
    super.initState();
  }
  final _controller = TextEditingController();

  // reload the todolist on change in default list of todos
  void refreshList(){
    print("fsf");
    print(_myBox.get("DEFAULTTODOLIST"));
    print(_myBox.get("TODOLIST"));
    setState(() {
      if(_myBox.get("TODOLIST") == null && _myBox.get("DEFAULTTODOLIST") == null){
        db.createInitialData();
      }
      else{
        db.loadData();
        db.createInitialData();
      }
    });
  }

  // save new todos
  void saveTask(){
    setState(() {
      if(_controller.text != ""){
        db.todoList[_controller.text] = false;
      }
      else{
        final snackBar = SnackBar(
          content: Text('Please enter a non-empty value.'),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      _controller.clear();
    });
    db.updateData(); // update the Hive DB.
    Navigator.of(context).pop(); // close the dialog box
  }
  // cancel new task --> simply close the dialoge box
  void cancelTask(){
    Navigator.of(context).pop();
  }

  /*
    call back function ==> 1. Used to send data from child to parent.
                          2. It can be called from the child component only.
   */
  void checkBoxChanged(int index, String key) {  // callBack function
    setState(() {
      db.todoList[key] = !db.todoList[key]!;
    });
    db.updateData(); // update tht Hive DB
  }
  /*
  Here we want to change the value of task to false or true from the
  checkbox, which is present in child,
  Using the setState to re-render the child component, after changing true <-> false.
   */

  void createNewTask(){
    showDialog(
        context: context,
        builder: (context){
          return DialogBox(
            controller: _controller,
            onCancel: cancelTask,
            onSave: saveTask,
          );
    },);
  }

  void deleteTask(int index, String key){
    setState(() {
      db.defaultToDoList.remove(key);
      db.todoList.remove(key);
    });
    db.updateData();
  }

  void handelSettingButton() {
    // redirect to setting window
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Settings(
        refreshList: refreshList,
      )),
    );
  }

  List map2list(Map<String, bool> m){
    List ans = [];
    for(var e in m.entries){
      List temp = [];
      temp.add(e.key);
      temp.add(e.value);
      ans.add(temp);
    }
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
        title: Text(
                "TO DO's",
              style: TextStyle(
                color: Colors.white
              ),
            ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
                Icons.settings,
            ),
            onPressed: handelSettingButton,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.red,
        child: Icon(
            Icons.add,
            color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          List todoList = map2list(db.todoList);
          return ToDoTile(
            taskName: todoList[index][0],
            isTaskComplete: todoList[index][1],
            onChanged: (p0) => checkBoxChanged(index, todoList[index][0]), // add key for fxn
            deleteFunction: (context) => deleteTask(index, todoList[index][0]),
          );
        },
      )
    );
  }
}
