import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rpgcompanion/application_pages/character_page.dart';
import 'package:rpgcompanion/helpers/character_builder.dart';
import 'package:rpgcompanion/models/question_model.dart';

import 'application_pages/select_class_page.dart';
import 'application_pages/select_race_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (ctx) => CompanionHome(),
      '/characterScreen': (ctx) => CharacterQuestionsSlider(),
      '/newCharacterQuestionsScreen': (ctx) => CompanionHome(),
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
            CompanionAppItem('Create New Character', '/characterScreen'),
//            CompanionAppItem('Questions', '/newCharacterQuestionsScreen'),
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
          future: DefaultAssetBundle.of(context)
              .loadString('assets/questions_list.json'),
          builder: (context, snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              var questionsListFromJson = json.decode(snapshot.data);
              QuestionsList listOfQuestions =
                  new QuestionsList.fromJson(questionsListFromJson);
              children = <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: RaisedButton(
                            onPressed: () => _controller.previousPage(),
                            child: Text('Anterior'),
                          ),
                        ),
                        Flexible(
                          child: RaisedButton(
                            onPressed: () => _controller.nextPage(),
                            child: Text('Proxima'),
                          ),
                        ),
                      ],
                    ),
                    CarouselSlider(
                      items: listOfQuestions.questions
                          .map((question) => Container(
                                  child: QuestionWidget(
                                question: question,
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

class QuestionWidget extends StatelessWidget {
  final Question question;

  QuestionWidget({@required this.question});

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
                  question.title,
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: question.choices
                .map((choice) => Container(
                        child: RaisedButton(
                      onPressed: () => {},
                      child: Text(choice.text),
                    )))
                .toList(),
          ),
        )
      ],
    );
  }
}

/*void main() => runApp(App());
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    CharacterBuilder characterBuilder = new CharacterBuilder();
    return MaterialApp(
      title: 'Flutter Navigation',
      home: MainPage(),
      routes: <String, WidgetBuilder> {
        '/select_class': (BuildContext context) => SelectClass(),
        '/select_race': (BuildContext context) => SelectRace(),
        '/character_page': (BuildContext context) => CharacterPage(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
                Navigator.pushNamed(context, '/select_class');
            },
            child: Text(
              'Adicionar Personagem',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0
              ),
            ),
            color: Colors.black87,
          ),
          RaisedButton(
            onPressed: () {},
            child: Text(
              'Carregar Personagem',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0
              ),
            ),
            color: Colors.black87,
          )
        ],
      ),
    );
  }
}*/

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Main Page'),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text('Click button to move to SubPage'),
//            RaisedButton(
//              textColor: Colors.white,
//              color: Colors.blue,
//              child: Text('Go to SubPage'),
//              onPressed: () {
//                navigateToSubPage(context);
//              },
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class SubPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Sub Page'),
//        backgroundColor: Colors.redAccent,
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text('Click button to back to Main Page'),
//            RaisedButton(
//              textColor: Colors.white,
//              color: Colors.redAccent,
//              child: Text('Back to Main Page'),
//              onPressed: () {
//                Navigator.pop(context);
//              },
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}

//class Home extends StatefulWidget {
//  @override
//  _HomeState createState() => _HomeState();
//}
//
//class _HomeState extends State<Home> {
//
//  PageManager _pageManager = PageManager();
//
//  final int initialPage = 0;
//  int currentPageIndex = 0;
//  List<Widget> applicationPages=[HomePage(), SelectClass(), SelectRace()];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          'Tormenta Companion'
//        ),
//        backgroundColor: Colors.black87,
//        centerTitle: true,
//      ),
//      body: PageView.builder(
//        controller: PageController(
//          initialPage: _pageManager.getInitialPageIndex,
//        ),
//        itemBuilder: (context, index) => applicationPages[index],
//        itemCount: applicationPages.length,
//      ),
////      floatingActionButton: FloatingActionButton(
////        onPressed: () {}, // TODO - ADD NEW CHARACTER
////        child: Icon(Icons.add),
////        backgroundColor: Colors.black87,//
////      ),
//    );
//  }
//}
