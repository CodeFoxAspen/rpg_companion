class Answer {
  int counter = 0;

  final String text;
  final String brawl;
  final String magic;
  final String range;
  final String utility;
  final Object options;

  Answer(
      {this.text,
      this.brawl,
      this.magic,
      this.range,
      this.utility,
      this.options});

  factory Answer.fromJson(Map<String, dynamic> parsedJson) {
    var optionsFromJson = {};

    parsedJson.entries.forEach((entry) {
      if (entry.key.toLowerCase() != 'text') {
        optionsFromJson.addAll({entry.key: parsedJson[entry.key]});
      }
    });

    return Answer(
        text: parsedJson['text'].toString(), options: optionsFromJson);
  }
}
