class CharacterList {
  final List<Character> characters;

  CharacterList({this.characters});

  factory CharacterList.fromJson(List<dynamic> parsedJson) {
    List<Character> characters = new List<Character>();
    characters = parsedJson.map((i) => Character.fromJson(i)).toList();
    return new CharacterList(
      characters: characters,
    );
  }
}

class Character {
  final List<CharacterData> choices;

  Character({this.choices});

  factory Character.fromJson(Map<String, dynamic> parsedJson) {
    List<CharacterData> dataFromJson = [];

    parsedJson.entries.forEach((entry) {
      dataFromJson.add(new CharacterData(entry.key, entry.value));
    });

    return new Character(choices: dataFromJson);
  }
}

class CharacterData {
  String keyTitle;
  String keyValue;

  CharacterData(String _text, String _value) {
    this.keyTitle = _text;
    this.keyValue = _value;
  }
}

