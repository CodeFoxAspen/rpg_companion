import 'package:flutter/material.dart';
import 'package:rpgcompanion/helpers/character_builder.dart';

class SelectRace extends StatefulWidget {
  @override
  _SelectRaceState createState() => _SelectRaceState();
}

class _SelectRaceState extends State<SelectRace> {
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
              characterBuilder.setRacePoints(0);
              Navigator.pushNamed(context, '/character_page');
            },
            child: Text(
              'Humano',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
            color: Colors.black87,
          ),
          RaisedButton(
            onPressed: () {
              characterBuilder.setRacePoints(1);
              Navigator.pushNamed(context, '/character_page');
            },
            child: Text(
              'Anão',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
            color: Colors.black87,
          ),
          RaisedButton(
            onPressed: () {
              characterBuilder.setRacePoints(2);
              Navigator.pushNamed(context, '/character_page');
            },
            child: Text(
              'Elfo',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
            color: Colors.black87,
          )
        ],
      ),
    );
  }
}
