import 'package:flutter/material.dart';
import 'courses_info.dart';

final List<String> courses = const [
  "Mathematics",
  "Science",
  "Social Studies",
  "Random"
];


class CourseListPage extends StatelessWidget {
  CourseListPage({Key? key, required this.buildContext})
      : super(key: key);
  static const String routeName = "/courselistpage";
  final BuildContext buildContext;



  final List<Icon> courseIcons = const [
    Icon(
        Icons.functions_outlined,
        color: Colors.white,
        size: 40.0
    ),
    Icon(
        Icons.science_outlined,
        color: Colors.white,
        size: 40.0
    ),
    Icon(
        Icons.volunteer_activism_outlined,
        color: Colors.white,
        size: 40.0
    ),
    Icon(
        Icons.shuffle_outlined,
        color: Colors.white,
        size: 40.0
    ),

  ];



  List<Widget> getCardsList({List<String>? courseList}) {
    int i = 0;
    List<Widget> cardsList = [];
    if (courseList == null)
      cardsList.add(getCourseCard());
    else
      for (String crsName in courseList) {
        cardsList.add(
            getCourseCard(courseName: crsName, courseIcon: courseIcons[i]));
        i++;
      }
    return cardsList;
  }
  /* The method returns a course card */
  Widget getCourseCard({String? courseName, Icon? courseIcon}) {
    //The parameter course name could also be null
    return Container(
      margin: EdgeInsets.all(10.0),
      child: OutlinedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(10.0)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () {
          print("Hello $courseName");
          //Navigate to Course Info Page
          Navigator.pushNamed(this.buildContext, CourseInfoPage.routeName,
              arguments: courseName);
        },
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: courseIcon),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              ),
              Text(
                courseName ??=
                "No courses", // ??= means it will assign the Rhs value if Left side variable is null
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tukwan'),
        ),
        body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              Text('What do you want to learn today?', style: TextStyle(fontSize: 24)),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(10.0),
                  children: getCardsList(courseList: courses),
                ),
              )
            ]
        ));
  }
}