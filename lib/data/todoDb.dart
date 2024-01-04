import 'dart:collection';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDB {
  Map<String, bool> todoList = {};
  Map<String, bool> defaultToDoList = {};

  ToDoDB() {
    defaultToDoList['Learn ML'] = false;
  }

  // Reference hive box
  final _myBox = Hive.box("myBox");

  // Run this if first time ever open the app
  void createInitialData() {
    defaultToDoList.addAll(todoList);
    todoList = Map<String, bool>.from(defaultToDoList);
  }

  // Update the initial Db
  void updateDefaultData(Map<String, bool> newTodoList) {
    defaultToDoList = newTodoList;
  }

  // Load data from local storage ==> anytime the app is not opened for the first time ever
  // It means we have some data in our local storage, so load it
  void loadData() {
    // Hive is a key-value pair DB
    todoList = list2map(_myBox.get("TODOLIST"));
    defaultToDoList = list2map(_myBox.get("DEFAULTTODOLIST"));
  }

  // Update the database
  void updateData() {
    _myBox.put("TODOLIST", map2list(todoList));
    _myBox.put("DEFAULTTODOLIST", map2list(defaultToDoList));
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
  
  Map<String, bool> list2map(List temp){
    Map<String, bool> ans = {};
    for(int i = 0; i < temp.length; i++){
      ans[temp[i][0]] = temp[i][1];
    }
    return ans;
  }
}
