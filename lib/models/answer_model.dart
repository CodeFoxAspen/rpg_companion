import 'package:rpgcompanion/models/choice_model.dart';

class Answer {
  final String text;
  final String target;
  final List<Choice> options;
  bool selected;

  Answer({this.text, this.target, this.options, this.selected});

  factory Answer.fromJson(Map<String, dynamic> parsedJson, String questionType) {
    List<Choice> optionsFromJson = [];

    parsedJson.entries.forEach((entry) {
      if (entry.key.toLowerCase() != 'text') {
        optionsFromJson.add(new Choice(entry.key, parsedJson[entry.key]));
      }
    });

    return Answer(
         text: parsedJson['text'].toString(),
         target: questionType,
         options: optionsFromJson,
         selected: false);
  }
}
