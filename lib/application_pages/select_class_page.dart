import 'package:flutter/material.dart';
import 'package:rpgcompanion/helpers/character_builder.dart';

class SelectClass extends StatefulWidget {
  @override
  _SelectClassState createState() => _SelectClassState();
}

class _SelectClassState extends State<SelectClass> {
  @override
  Widget build(BuildContext context) {
    CharacterBuilder characterBuilder = CharacterBuilder();

    return new Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              characterBuilder.setClassPoints(0);
              Navigator.pushNamed(context, '/select_race');
            },
            child: Text(
              'Guerreiro',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
            color: Colors.black87,
          ),
          RaisedButton(
            onPressed: () {
              characterBuilder.setClassPoints(1);
              Navigator.pushNamed(context, '/select_race');
            },
            child: Text(
              'Ranger',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
            color: Colors.black87,
          ),
          RaisedButton(
            onPressed: () {
              characterBuilder.setClassPoints(2);
              Navigator.pushNamed(context, '/select_race');
            },
            child: Text(
              'Mago',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
            color: Colors.black87,
          )
        ],
      ),
    );
  }
}
