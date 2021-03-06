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
  final List<CharacterData> characterData;

  Character({this.characterData});

  bool hasValueInKey(String value, String key) {
    return this.characterData.any((charData) {
      return (
           charData.keyValue.toString().toLowerCase() == value.toString().toLowerCase()
                && charData.keyTitle.toString().toLowerCase() == key.toString().toLowerCase());
    });
  }

  bool isEmpty() {
    return this.characterData.length > 0;
  }

  factory Character.fromJson(Map<String, dynamic> parsedJson) {
    List<CharacterData> dataFromJson = [];

    parsedJson['charData'].entries.forEach((entry) {
      dataFromJson.add(new CharacterData(entry.key, entry.value.toString()));
    });

    return new Character(characterData: dataFromJson);
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

