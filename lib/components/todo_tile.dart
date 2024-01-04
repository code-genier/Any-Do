import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool isTaskComplete;
  void Function(bool?)? onChanged; // call back function
  void Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.isTaskComplete,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
              borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              // checkbox
              Checkbox(
                value: isTaskComplete,
                onChanged: onChanged,
                activeColor: Colors.black,
                checkColor: Colors.white,
              ),
              // todos
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 18,
                    color: Colors.white,
                    decoration: isTaskComplete ? TextDecoration.lineThrough : TextDecoration.none,
                    decorationColor: Colors.red,
                    decorationThickness: 3.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
