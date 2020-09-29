import 'package:rpgcompanion/models/choice_model.dart';

class Answer {
  final String text;
  final String type;
  final List<Choice> options;
  bool selected;

  Answer({this.text, this.type, this.options, this.selected});

  factory Answer.fromJson(Map<String, dynamic> parsedJson, String questionType) {
    List<Choice> optionsFromJson = [];

    parsedJson.entries.forEach((entry) {
      if (entry.key.toLowerCase() != 'text') {
        optionsFromJson.add(new Choice(entry.key, parsedJson[entry.key]));
      }
    });

    return Answer(
         text: parsedJson['text'].toString(),
         type: questionType,
         options: optionsFromJson,
         selected: false);
  }
}
