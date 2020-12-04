import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpgcompanion/models/question_model.dart';
import 'package:rpgcompanion/helpers/character_builder.dart';

import 'application_pages/character_page.dart';
import 'application_pages/flavor_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, initialRoute: '/', routes: {
      '/': (ctx) => CompanionHome(),
      '/newCharacterScreen': (ctx) => CharacterQuestionsSlider(),
      '/loadCharacterScreen': (ctx) => CompanionHome(),
      '/resultScreen': (ctx) => CharacterPage(),
      '/flavorScreen': (ctx) => FlavorPage(),
      '/characterScreen': (ctx) => null,
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
      body: Padding(
          padding: EdgeInsets.all(25),
          child: ListView(
            children: <Widget>[
              Padding(
                child: Image(fit: BoxFit.fitHeight, image: AssetImage('rpg_companion_logo.png')),
                padding: EdgeInsets.all(50)
              ),
//            CompanionAppItem('Home', '/'),
              CompanionAppItem('Criar novo personagem', '/flavorScreen'),
//            CompanionAppItem('Carregar Personagem', '/loadCharacterScreen'),
            ],
          )),
    );
  }
}

class FlavorPage extends StatefulWidget {
  @override
  _FlavorPageState createState() => _FlavorPageState();
}

class _FlavorPageState extends State<FlavorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RPG'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: '',
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),
                    children: <TextSpan>[
                      TextSpan(text: '    Interpretar um personagem\n\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      TextSpan(
                          text:
                              '    Quando jogar RPG lembre-se de que você age pelo seu personagem. Interpreta-lo é permitir-se entrar no mundo ficticio criado pelo Mestre da mesa e atuar ativamente dentro dele.\n\n'),
                      TextSpan(
                          text:
                              '    Explore situações fora do seu cotidiano, aprenda a lidar com os desafios! Aja com liberdade, imagine e faça. Você e seu grupo serão os responsáveis pela própria glória.\n\n'),
                      TextSpan(
                          text:
                              '    Se estiver confortável, lembre-se de falar pelo seu personagem. É possível dizer ao grupo o que irá fazer, mas você pode realmente interpretar e ser a voz e o sotaque do seu próprio personagem!'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CompanionAppItem('Continuar', '/newCharacterScreen'),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ), //        body: SingleChildScrollView(
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
                          .map((question) => Container(
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
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final CharacterBuilder characterBuilder = new CharacterBuilder();

  @override
  Widget build(BuildContext context) {
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
                .map((choice) => Container(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (widget.question.answered == false) {
                            choice.selected = true;
                            widget.question.answered = true;
                            characterBuilder.saveSelectedAnswer(choice);

                            if (characterBuilder.allQuestionsAreAnswered(widget.questionsList)) {
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
