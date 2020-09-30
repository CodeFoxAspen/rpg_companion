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
}

class Question {
  final String title;
  final String target;
  final List<Answer> choices;
  bool answered;

  Question({this.title, this.target, this.answered, this.choices});

  factory Question.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['choices'] as List;
    var questionType = parsedJson['target'] as String;
    List<Answer> choiceList = list.map((i) => Answer.fromJson(i, questionType)).toList();
    return new Question(
        title: parsedJson['title'],
         target: parsedJson['target'],
			answered: false,
        choices: choiceList);
  }
}
