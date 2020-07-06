import 'package:flutter/material.dart';

class CharacterBuilder {
  static final CharacterBuilder _instance = CharacterBuilder.internal();

  factory CharacterBuilder() => _instance;

  CharacterBuilder.internal();

  ChoiceData choiceData = new ChoiceData();

  void setClassPoints(int points) {
    choiceData.classPoints = points;
  }

  void setRacePoints(int points) {
    choiceData.racePoints = points;
  }

  CharacterData createCharacter(String playerName, String characterName) {
    print('Creating Character');
    int id = DateTime.now().millisecondsSinceEpoch;

    CharacterData characterData = new CharacterData();

    characterData.setBaseInfo(id, playerName, characterName);

    characterData.level = 1;
    characterData.actPoints = 0;
    characterData.divinity = 'Thyr';
    characterData.sex = 'Masc';
    characterData.age = 29;

    if (choiceData.classPoints == 0) {
      // Warrior
      characterData.characterClass = 'Guerreiro';
      characterData.tendencyMorality = 'Neutro';
      characterData.tendencyEthics = 'Neutro';
      characterData.setAbilities(17, 12, 15, 10, 10, 12);
    } else if (choiceData.classPoints == 1) {
      // Ranger
      characterData.characterClass = 'Ranger';
      characterData.tendencyMorality = 'Bom';
      characterData.tendencyEthics = 'Neutro';
      characterData.setAbilities(12, 18, 15, 10, 10, 14);
    } else if (choiceData.classPoints == 2) {
      // Wizard
      characterData.characterClass = 'Mago';
      characterData.tendencyMorality = 'Mal';
      characterData.tendencyEthics = 'Caótico';
      characterData.setAbilities(10, 12, 12, 18, 16, 15);
    }

    if (choiceData.racePoints == 0) {
      // Human
      characterData.race = 'Humano';
      characterData.str += 2;
      characterData.strMod = (((characterData.str - 10) / 2) - 0.1).round();
      characterData.con += 2;
      characterData.conMod = (((characterData.con - 10) / 2) - 0.1).round();
      characterData.size = 'Normal';
      characterData.age *= 1;

      characterData.displacement = 9;
    } else if (choiceData.racePoints == 1) {
      // Dwarven
      characterData.race = 'Anão';
      characterData.con += 4;
      characterData.conMod = (((characterData.con - 10) / 2) - 0.1).round();
      characterData.wis += 2;
      characterData.wisMod = (((characterData.wis - 10) / 2) - 0.1).round();
      characterData.dex -= 2;
      characterData.dexMod = (((characterData.dex - 10) / 2) - 0.1).round();
      characterData.size = 'Normal';
      characterData.age *= 4;

      characterData.displacement = 6;
    } else if (choiceData.racePoints == 2) {
      // Elf
      characterData.race = 'Elfo';
      characterData.dex += 4;
      characterData.dexMod = (((characterData.dex - 10) / 2) - 0.1).round();
      characterData.intel += 2;
      characterData.intMod = (((characterData.intel - 10) / 2) - 0.1).round();
      characterData.con -= 2;
      characterData.conMod = (((characterData.con - 10) / 2) - 0.1).round();
      characterData.size = 'Normal';
      characterData.age *= 5;

      characterData.displacement = 9;
    }

    characterData.setHealthPoints();

    return characterData;
  }
}

class ChoiceData {
  int classPoints;
  int racePoints;
}

class CharacterData {
  int id;
  String characterName;
  String playerName;
  String race;
  String characterClass;
  int level;
  String tendencyEthics;
  String tendencyMorality;
  String sex;
  int age;
  String divinity;
  String size;
  int sizeModifier;
  int displacement;
  int str;
  int strMod;
  int dex;
  int dexMod;
  int con;
  int conMod;
  int intel;
  int intMod;
  int wis;
  int wisMod;
  int cha;
  int chaMod;
  int maxHp;
  int curHp;
  int actPoints;
  int armorClass;
  int armorBonus;
  int shieldBonus;
  int armorOthers;
  int damageReduction;
  int fortitude;
  int fortitudeOthers;
  int reflexes;
  int reflexesOthers;
  int will;
  int willOthers;
  int meleeAttackHit;
  int rangedAttackHit;
  int baseAttackBonus;
  List<Equipment> equipment;

  CharacterData();

  setBaseInfo(int _id, String _playerName, String _characterName) {
    id = _id;
    playerName = _playerName;
    characterName = _characterName;
  }

  setAbilities(int _str, int _dex, int _con, int _intel, int _wis, int _cha) {
    str = _str;
    strMod = (((_str - 10) / 2) - 0.1).round();
    dex = _dex;
    dexMod = (((_dex - 10) / 2) - 0.1).round();
    con = _con;
    conMod = (((_con - 10) / 2) - 0.1).round();
    intel = _intel;
    intMod = (((_intel - 10) / 2) - 0.1).round();
    wis = _wis;
    wisMod = (((_wis - 10) / 2) - 0.1).round();
    cha = _cha;
    chaMod = (((_cha - 10) / 2) - 0.1).round();
  }

  setHealthPoints() {
    if (characterClass == 'Warrior') {
      maxHp = 20 + conMod;
      curHp = maxHp;
    } else if (characterClass == 'Ranger') {
      maxHp = 16 + conMod;
      curHp = maxHp;
    } else if (characterClass == 'Wizard') {
      maxHp = 8 + conMod;
      curHp = maxHp;
    }
  }

  setResistances() {
    fortitudeOthers = 0;
    reflexesOthers = 0;
    willOthers = 0;
    fortitude = ((level / 2) - 0.1).round() + conMod + fortitudeOthers;
    reflexes = ((level / 2) - 0.1).round() + dexMod + reflexesOthers;
    will = ((level / 2) - 0.1).round() + wisMod + willOthers;
  }
}

class Equipment {
  String name;
  String type;
}

class Weapon extends Equipment {
  String damageType;
  int damage;
  List<int> criticalRange;
}

class Armor extends Equipment {
  int armorBonus;
  int dexMaxBonus;
  int armorPenalty;
}
