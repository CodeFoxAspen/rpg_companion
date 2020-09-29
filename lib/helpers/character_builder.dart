import 'package:rpgcompanion/models/answer_model.dart';
import 'package:rpgcompanion/models/character_model.dart';
import 'package:rpgcompanion/models/choice_model.dart';
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
          resultingScores.add(new ResultingScores(option.text, answer.type, option.value));
        }
      });
    });
  }

  List<String> getHighestScoringValues(){
    double highScore = 0;
    String keyName = '';
    List<String> typesList = [];
    List<String> resultsList = [];

    resultingScores.forEach((rs) {
      if(typesList.indexOf(rs.type) == -1) {typesList.add(rs.type);}
    });

    typesList.forEach((type) {
      resultingScores.forEach((rs) {
        if(rs.type.toLowerCase() == type.toLowerCase() && rs.value > highScore) {
          highScore = rs.value;
          keyName = rs.text;
        }
      });
      resultsList.add(keyName);
      keyName = '';
      highScore = 0;
    });
    return resultsList;
  }

  bool allQuestionsAreAnswered(List<Question> questions){
    return questions.every((question)=> question.answered == true);
  }

  selectCharacter(CharacterList listOfCharacters){
    List<String> highScoreKeysToFind = getHighestScoringValues();
    List<Character> resultingCharacters;

    highScoreKeysToFind[0]; //string


    listOfCharacters.characters.forEach((character) {
        character.characterData.forEach((charData) {
          if (charData.keyValue.toString().toLowerCase() == highScoreKeysToFind[0]) {
            resultingCharacters.add(character);
          }
        });
      });
    }
}
