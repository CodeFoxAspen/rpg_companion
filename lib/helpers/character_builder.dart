import 'package:rpgcompanion/models/answer_model.dart';
import 'package:rpgcompanion/models/character_model.dart';
import 'package:rpgcompanion/models/choice_model.dart';
import 'package:rpgcompanion/models/high_score_model.dart';
import 'package:rpgcompanion/models/question_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:rpgcompanion/models/resulting_score_model.dart';

class CharacterBuilder {
  static final CharacterBuilder _instance = CharacterBuilder.internal();

  factory CharacterBuilder() => _instance;

  CharacterBuilder.internal();

  List<Answer> selectedAnswers = [];

  List<ResultingScores> resultingScores = [];

  void saveSelectedAnswer(Answer answer){
    selectedAnswers.add(answer);
  }

  void calculateCharacterScores(){
    selectedAnswers.forEach((answer){
      answer.options.forEach((option){
        if(resultingScores.any((rs)=> rs.text == option.text)) {
          resultingScores
               .firstWhere((rs)=> rs.text == option.text)
               .value += option.value;
        } else {
          resultingScores.add(new ResultingScores(option.text, answer.target, option.value));
        }
      });
    });
  }

  List<HighScoreKeyTarget> getHighestScoringValues(){
    double highScore = 0;
    String keyName = '';
    List<String> typesList = [];
    List<HighScoreKeyTarget> keyTargetList = [];

    resultingScores.forEach((rs) {
      if(typesList.indexOf(rs.target) == -1) {typesList.add(rs.target);}
    });

    typesList.forEach((target) {
      resultingScores.forEach((rs) {
        if(rs.target.toLowerCase() == target.toLowerCase() && rs.value > highScore) {
          highScore = rs.value;
          keyName = rs.text;
        }
      });
      keyTargetList.add(new HighScoreKeyTarget(keyName, target));
      keyName = '';
      highScore = 0;
    });
    return keyTargetList;
  }

  bool allQuestionsAreAnswered(List<Question> questions){
    return questions.every((question)=> question.answered == true);
  }

  Character selectCharacter(CharacterList listOfCharacters){
    List<HighScoreKeyTarget> highScoreKeysToFind = getHighestScoringValues();
    List<Character> resultingCharacters = [];

    highScoreKeysToFind.forEach((targetKey) {
      listOfCharacters.characters.forEach((character) {
        if (character.hasValueInKey(highScoreKeysToFind[0].key, highScoreKeysToFind[0].target)) {
          resultingCharacters.add(character);
        }
      });
    });

    if (resultingCharacters.length == 0) {
      resultingCharacters.add(new Character());
    }

    return resultingCharacters[0];
  }
}
