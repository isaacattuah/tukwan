//CourseInfo.dart
import 'package:flutter/material.dart';
class CourseInfoPage extends StatelessWidget {
  static const String routeName = "/courseinfopage";
  const CourseInfoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final receivedCourseName =
    ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          title: Text("Course Info Page"),
        ),
        body: SafeArea(
          child: Container(
            child: Text("Course Info Page $receivedCourseName"),
          ),
        ));
  }
}