class Answer {
  int counter = 0;

  final String text;
  final Object options;
  bool selected;

  Answer({this.text, this.options, this.selected});

  factory Answer.fromJson(Map<String, dynamic> parsedJson) {
    var optionsFromJson = {};

    parsedJson.entries.forEach((entry) {
      if (entry.key.toLowerCase() != 'text') {
        optionsFromJson.addAll({entry.key: parsedJson[entry.key]});
      }
    });

    return Answer(
			text: parsedJson['text'].toString(), options: optionsFromJson, selected: false);
  }
}
