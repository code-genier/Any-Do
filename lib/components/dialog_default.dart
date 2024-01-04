import "dart:collection";

import "package:flutter/material.dart";
import "package:to_do_app/components/change_defaults_items.dart";
import "package:to_do_app/components/my_button.dart";

import "../data/todoDb.dart";

class DefaultTaskDialogBox extends StatefulWidget {
  final Map<String, bool> currentDefaultToDoList;
  void Function() onCancel;
  void Function(Map<String, bool>) updateCurrentDefaultList;
  void Function() refreshList;

  DefaultTaskDialogBox({
    super.key,
    required this.currentDefaultToDoList,
    required this.onCancel,
    required this.updateCurrentDefaultList,
    required this.refreshList
  });

  @override
  State<DefaultTaskDialogBox> createState() => _DefaultTaskDialogBoxState();
}

class _DefaultTaskDialogBoxState extends State<DefaultTaskDialogBox> {
  ToDoDB db = ToDoDB();
  Map<String, bool> currentDefaultToDoList = {};
  late void Function(Map<String, bool>) updateCurrentDefaultList;

  @override
  void initState() {
    currentDefaultToDoList = widget.currentDefaultToDoList;
    updateCurrentDefaultList = widget.updateCurrentDefaultList;
    // TODO: implement initState
    super.initState();
  }

  void deleteCurrentDefaultTask(int index, String key){
    setState(() {
      currentDefaultToDoList.remove(key);
    });
    updateCurrentDefaultList(currentDefaultToDoList);
  }

  // controller
  final _controller = TextEditingController();

  // save default task
  void onSave(){
    setState(() {
      if(_controller.text != ""){
        currentDefaultToDoList[_controller.text] = false;
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
    updateCurrentDefaultList(currentDefaultToDoList);
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
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Set the corner radius
        side: BorderSide(color: Colors.white), // Set the outline color
      ),
      backgroundColor: Colors.black,
      content: Container(
        height: 310,
        width: 900,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: currentDefaultToDoList.length,
                  itemBuilder: (context, index){
                    List currentDefaultToDoList1 = map2list(currentDefaultToDoList);
                    return ChangeDefaultsItems(
                        defaultTask: currentDefaultToDoList1[index][0],
                        deleteDefaultTask: (context) => deleteCurrentDefaultTask(
                            index,
                            currentDefaultToDoList1[index][0],
                        ),
                    );
                  }
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.red,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "NEW DEFAULT TASK...",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white38), // Set the border color
                ),
                hintStyle: TextStyle(
                  color: Colors.white38,
                ),
              ),
              controller: _controller,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(text: "Cancel", onPressed: widget.onCancel),
                MyButton(text: "Add", onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
