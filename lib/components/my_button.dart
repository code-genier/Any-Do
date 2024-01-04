import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        color: Colors.white38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set the border radius
        ),
        child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
        ),
    );
  }
}
