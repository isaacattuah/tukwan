import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'question.dart';
import 'dart:async' show Future;

int score = 0;



class QuizBrain {
  int _questionNumber = 0;
  int _reviewNumber = 0;
  List<Question> questionBank = [];
  List<Question> reviewBank = [];

  // late List<Question> questionBank;

  // List<Question> questionBank = [
  //   Question('Some cats are actually allergic to humans', true),
  //   Question('You can lead a cow down stairs but not up stairs.', false),
  //   Question('Approximately one quarter of human bones are in the feet.', true),
  //   Question('A slug\'s blood is green.', true),
  //   Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
  //   Question('It is illegal to pee in the Ocean in Portugal.', true),
  //   Question(
  //       'No piece of square dry paper can be folded in half more than 7 times.',
  //       false),
  //   Question(
  //       'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
  //       true),
  //   Question(
  //       'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
  //       false),
  //   Question(
  //       'The total surface area of two human lungs is approximately 70 square metres.',
  //       true),
  //   Question('Google was originally called \"Backrub\".', true),
  //   Question(
  //       'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
  //       true),
  //   Question(
  //       'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
  //       true),
  //   Question.detailed("The slope of a vertical line is undefined", "Math", "Algebra", "Yes", false, "n"),
  // ];



  void nextQuestion() {
    if (_questionNumber < questionBank.length - 1) {
      _questionNumber++;
    }
  }

  void nextReviewQuestion() {
    if (_reviewNumber < reviewBank.length - 1) {
      _reviewNumber++;
    }
    print(_reviewNumber);
  }

  String getQuestionText() {
    return questionBank[_questionNumber].questionText;
  }


  String getReviewQuestionText() {

    return reviewBank[_reviewNumber].questionText;
  }

  String? getReviewQuestionExplanation() {
    return reviewBank[_reviewNumber].explanation;
  }

  bool getCorrectAnswer() {
    return questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= questionBank.length - 1) {


      print('Now returning true');
      return true;

    } else {
      return false;
    }
  }

  bool isFinishedReview() {
    if (_reviewNumber >= reviewBank.length - 1) {

      print('Now reviewing true');
      return true;

    } else {
      return false;
    }
  }


  void reset() {
    _questionNumber = 0;
    score = 0;
  }

  void reviewReset() {
    _reviewNumber = 0;
  }

  void addReview(){
    reviewBank.add(questionBank[_questionNumber]);
  }





  Future<List<Question>> getQuestions() async {
      var response = await rootBundle.loadString('assets/nsmq.json');
      final data = await jsonDecode(response);

     List _questionList = [];

     for (var i in data) {
      _questionList.add(i);

     }


     return Question.questionsFromSnapshot(_questionList);
  }

  Future<void> getQuestionFinal() async {
    questionBank = await getQuestions();
  }




}