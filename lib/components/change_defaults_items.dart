import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChangeDefaultsItems extends StatelessWidget {
  final String defaultTask;
  void Function(BuildContext)? deleteDefaultTask;

  ChangeDefaultsItems({
    super.key,
    required this.defaultTask,
    required this.deleteDefaultTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5, top: 10),
      child: ClipRect(
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteDefaultTask,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
          child: Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  defaultTask,
                  style: TextStyle(
                      color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
