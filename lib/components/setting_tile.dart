import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsTile extends StatelessWidget {
  final setting_item;
  void Function()? onPressed;
  SettingsTile({super.key, required this.setting_item, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Container(
        padding: EdgeInsets.all(20),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 40)),
          child: Row(
            children: [
              Icon(
                Icons.change_circle,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  setting_item,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
          ],
        ),
      ),
      ),
    );
  }
}
