import 'package:flutter/material.dart';
import '../models/quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quiz());


class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}





class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  bool _isLoading = true;


  @override
  void initState(){
    super.initState();
    getQuestionFinal();
  }

  Future<void> getQuestionFinal() async {
    quizBrain.questionBank = await quizBrain.getQuestions();
    setState(() {
      _isLoading = false;
    });
  }

// Restart Quiz
  void restart(){
    // runApp(Quiz());
    //TODO : Implement method to restart application
  }

// Enables reviews to be redone
  void rewind(){
    quizBrain.reviewReset();
    _pushReview();
  }

// Checks reviews left in array
  void reviewCheck(){
    setState(() {
      if (quizBrain.isFinishedReview() == true){
        AlertDialog alert = AlertDialog(
          title: Text('Completed!'),
          content: Text('You are done reviewing'),
          actions: [
            TextButton(onPressed: restart , child: Text('Retry')),
            TextButton(onPressed: null , child: Text('Main Menu')),
            TextButton(onPressed: rewind , child: Text('Review Again')),
          ],
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
      else{
        quizBrain.nextReviewQuestion();
        _pushReview();
      }
    });
  }

// Checks user answer against a given JSON answer
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {

      String score_str = score.toString();
      String total = scoreKeeper.length.toString();

      if (quizBrain.isFinished() == true) {



        AlertDialog alert = AlertDialog(
          title: Text('Completed!'),
          content: Text('You are done with this quiz. You scored ${score_str}/${total}'),
          actions: [
            TextButton(onPressed: restart , child: Text('Retry')),
            TextButton(onPressed: null , child: Text('Main Menu')),
            TextButton(onPressed: _pushReview , child: Text('Review')),
          ],
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );


        quizBrain.reset();


        scoreKeeper = [];
      }


      else {
        if (userPickedAnswer == correctAnswer) {
          score++;
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          quizBrain.addReview();
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }



// Review Screen
 void _pushReview() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        Expanded(
        flex: 5,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Text(
              quizBrain.getReviewQuestionText(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: Text(
                  quizBrain.getReviewQuestionExplanation()!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  //Next Question
                  reviewCheck();
                },
              ),
            ),
          ),
      ],
      ),
    );
  })
  );
}



  @override
  Widget build(BuildContext context) {
    return _isLoading
          ? const Center(child: CircularProgressIndicator()) : Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  //The user picked true.
                  checkAnswer(true);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red ),
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  //The user picked false.
                  checkAnswer(false);
                },
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ],
      );

  }
}


