import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/pages/home_page.dart';
import 'package:to_do_app/pages/settings.dart';

void main() async {
  // hive intitialization --> store in local storage
  await Hive.initFlutter();

  // open a box
  // in main file we open the box using Hive.openBox(..)
  // later to use/reference this box in any of component we use Hive.box(..)
  var box = await Hive.openBox("myBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
