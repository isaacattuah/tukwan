class Question {

  String questionText;
  String? subject;
  String? type;
  String? explanation;
  bool questionAnswer;
  String? latex;

  // Basic Question Format
  Question(this.questionText, this.questionAnswer);

  // Detailed Question Format
  Question.detailed(this.questionText, this.subject, this.type,
      this.explanation, this.questionAnswer, this.latex);

  // Read JSON Data for detailed questions
  factory Question.fromJsonSimple(Map<String, dynamic> json) {
    return Question(
        json["Question"], json["True/False"]);
  }

  // Read JSON Data for detailed questions
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question.detailed(
        json["Question"], json["Subject"], json["Type"], json["Explanation"],
        json["True/False"], json["Latex"]);
  }

  // Extract Simple Questions
  static List<Question> questionsFromSnapshotSimple(List snapshot) {
    return snapshot.map((data) {
      return Question.fromJsonSimple(data);
    }).toList();
  }

  // Extract Detailed Questions
  static List<Question> questionsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Question.fromJson(data);
    }).toList();
  }

}
