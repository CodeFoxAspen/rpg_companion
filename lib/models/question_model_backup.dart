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

class Answer {
  final String text;
  final String brawl;
  final String magic;
  final String range;
  final String utility;

  Answer({this.text, this.brawl, this.magic, this.range, this.utility});

  factory Answer.fromJson(Map<String, dynamic> parsedJson) {
    return Answer(
        text: parsedJson['text'].toString(),
        brawl: parsedJson['brawl'].toString(),
        magic: parsedJson['magic'].toString(),
        range: parsedJson['range'].toString(),
        utility: parsedJson['utility'].toString());
  }
}
