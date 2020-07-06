import 'answer_model.dart';

class QuestionsList {
  final List<Question> questions;

  QuestionsList({this.questions});

  factory QuestionsList.fromJson(List<dynamic> parsedJson) {
    List<Question> questions = new List<Question>();
    questions = parsedJson.map((i) => Question.fromJson(i)).toList();
    return new QuestionsList(
      questions: questions,
    );
  }

  Object toObject() {
    print(this);
    return new Object();
  }
}

class Question {
  final String title;
  final String type;
  final List<Answer> choices;

  Question({this.title, this.type, this.choices});

  factory Question.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['choices'] as List;
    List<Answer> choiceList = list.map((i) => Answer.fromJson(i)).toList();
    return new Question(
        title: parsedJson['title'],
        type: parsedJson['type'],
        choices: choiceList);
  }
}
