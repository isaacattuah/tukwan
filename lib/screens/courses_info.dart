
import 'package:flutter/material.dart';
import 'package:tukwan/screens/quiz.dart';



class CourseInfoPage extends StatelessWidget {
  static String subject = '';
  static const String routeName = "/courseinfopage";
  const CourseInfoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final receivedCourseName =
    ModalRoute.of(context)!.settings.arguments as String;
    subject = receivedCourseName;
    return Scaffold(
        appBar: AppBar(
          title: Text("$receivedCourseName Quiz"),
        ),
        body: Quiz()

    );
  }
}