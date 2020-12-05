import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rpgcompanion/helpers/character_builder.dart';
import 'package:rpgcompanion/models/character_model.dart';

class CharacterPage extends StatefulWidget {
  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  @override
  Widget build(BuildContext context) {
    CharacterBuilder characterBuilder = CharacterBuilder();
//    String tendencyEthics = characterData.tendencyEthics;
//    String tendencyMorality = characterData.tendencyMorality;
    return Scaffold(
      appBar: AppBar(
        title: Text('Character Sheet'),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () { Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString('assets/character_database.json'),
            builder: (context, snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                CharacterList listOfCharacters = new CharacterList.fromJson(json.decode(snapshot.data));
                var character = characterBuilder.selectCharacter(listOfCharacters);
                if (character.characterData == null) {
                  children = <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: No Data'),
                    )
                  ];
                } else {
                  children = [CharacterAttributesWidget(characterDataList: character.characterData,)];
                  characterBuilder.clearBuilder();
					 }
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
            }),
      ),
    );
  }
}

class CharacterAttributesWidget extends StatefulWidget {
  final List<CharacterData> characterDataList;

  CharacterAttributesWidget({@required this.characterDataList});

  @override
  _CharacterAttributesWidgetState createState() => _CharacterAttributesWidgetState();
}

class _CharacterAttributesWidgetState extends State<CharacterAttributesWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.characterDataList.map((data) =>
             ListTile(
               title: Text(data.keyTitle),
               subtitle: Text(data.keyValue),
             )
        ).toList()
      )
    );
  }
}
