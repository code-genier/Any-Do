import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/components/dialog_default.dart';
import 'package:to_do_app/components/setting_tile.dart';
import 'package:to_do_app/data/todoDb.dart';

class Settings extends StatefulWidget {
  void Function() refreshList;

  Settings({
    super.key,
    required this.refreshList,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _myBox = Hive.box("myBox");
  ToDoDB db = ToDoDB();

  Map<String, bool> currentDefaultToDoList = {};

  @override
  void initState() { // runs on the app starts
    if(_myBox.get("DEFAULTTODOLIST") == null){

    }
    else{
      db.loadData();
    }
    currentDefaultToDoList = db.defaultToDoList;
    // TODO: implement initState
    super.initState();
  }

  List settingsList = [
    "Default List"
  ];


  // cancel --> so nothing
  void cancelDefaultTask(){
    Navigator.of(context).pop();
  }

  // delete current task
  void updateCurrentDefaultTask(Map<String, bool> newCurrentDefaultTask){
    setState(() {
      currentDefaultToDoList = newCurrentDefaultTask;
      db.updateDefaultData(newCurrentDefaultTask);
      db.createInitialData();
      db.updateData();
    });
    widget.refreshList();
  }

  @override
  void handelPressed(int index){
    if(index == 0){
      showDialog(
        context: context,
        builder: (context){
          return DefaultTaskDialogBox(
            currentDefaultToDoList: currentDefaultToDoList,
            onCancel: cancelDefaultTask,
            updateCurrentDefaultList: updateCurrentDefaultTask,
            refreshList: widget.refreshList,
          );
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        title: Text(
            "Settings",
            style: TextStyle(
              color: Colors.white
            ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView.builder(
            itemCount: settingsList.length,
            itemBuilder: (context, index){
              return SettingsTile(setting_item: settingsList[index], onPressed: () => handelPressed(index),);
            }
          )
      );
  }
}
