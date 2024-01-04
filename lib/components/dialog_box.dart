import 'package:flutter/material.dart';
import 'package:to_do_app/components/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({super.key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Set the corner radius
        side: BorderSide(color: Colors.white), // Set the outline color
      ),
      backgroundColor: Colors.black,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0)
        ),
        height: 160,
        width: 900,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // get user input
              TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "WHAT's THE PLAN?",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white38), // Set the border color
                  ),
                  hintStyle: TextStyle(color: Colors.white38),
                ),
                controller: controller,
              ),
              // button save or cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    text: "Cancel",
                    onPressed: onCancel
                  ),
                  MyButton(
                    text: "Save",
                    onPressed: onSave
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
