import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/models/question_model.dart';
import 'package:rpgcompanion/helpers/character_builder.dart';

import 'application_pages/character_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(initialRoute: '/', routes: {
      '/': (ctx)=> CompanionHome(),
      '/newCharacterScreen': (ctx)=> CharacterQuestionsSlider(),
      '/loadCharacterScreen': (ctx)=> CompanionHome(),
      '/resultScreen': (ctx)=> CharacterPage(),
      '/characterScreen': (ctx)=> null,
    });
  }
}

class CompanionAppItem extends StatelessWidget {
  final String title;
  final String route;

  CompanionAppItem(this.title, this.route);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text(title),
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
        )
      ],
    );
  }
}

class CompanionHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RPG Companion App'),
        ),
        body: ListView(
          children: <Widget>[
//            CompanionAppItem('Home', '/'),
            CompanionAppItem('Criar novo personagem', '/newCharacterScreen'),
            CompanionAppItem('Carregar Personagem', '/loadCharacterScreen'),
          ],
        ));
  }
}

class CharacterQuestionsSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CharacterQuestionsSlider();
  }
}

class _CharacterQuestionsSlider extends State<CharacterQuestionsSlider> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Questions'),
          centerTitle: true,
        ),
//        body: SingleChildScrollView(
        body: SingleChildScrollView(
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context).loadString('assets/questions_list.json'),
          builder: (context, snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              QuestionsList listOfQuestions = new QuestionsList.fromJson(json.decode(snapshot.data));
              children = <Widget>[
                Column(
                  children: <Widget>[
                    CarouselSlider(
                      items: listOfQuestions.questions
                           .map((question)=>
                           Container(
                                child: QuestionWidget(
                                  questionsList: listOfQuestions.questions,
                                  question: question,
                                  controller: _controller,
                                )))
                           .toList(),
                      options: CarouselOptions(
                        enlargeCenterPage: false,
                        height: height,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                      ),
                      carouselController: _controller,
                    ),
                  ],
                )
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text('Awaiting result...'),
                )
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            );
          },
        )));
  }
}

class QuestionWidget extends StatefulWidget {
  final List<Question> questionsList;
  final Question question;
  final CarouselController controller;

  QuestionWidget({@required this.questionsList, @required this.question, @required this.controller});

  @override
  _QuestionWidgetState createState()=> _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final CharacterBuilder characterBuilder = new CharacterBuilder();

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.question.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.question.choices
                 .map((choice)=>
                 Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        child: RaisedButton(
                          onPressed: (){
                            if(widget.question.answered == false) {
                              choice.selected = true;
                              widget.question.answered = true;
                              characterBuilder.saveSelectedAnswer(choice);

                              if(characterBuilder.allQuestionsAreAnswered(widget.questionsList)) {
                                characterBuilder.calculateCharacterScores();
                                Navigator.pushNamed(context, '/resultScreen');
                              } else {
                                widget.controller.nextPage();
                              }
                            }
                          },
                          child: Text(choice.text),
                        ),
                      )))
                 .toList(),
          ),
        )
      ],
    );
  }
}