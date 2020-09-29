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
		  ),
		  body: SingleChildScrollView(
			  child: FutureBuilder(
				  future: DefaultAssetBundle.of(context).loadString('assets/character_database.json'),
				  builder: (context, snapshot) {
				  	List<Widget> children;
				  	if (snapshot.hasData) {
						CharacterList listOfCharacters = new CharacterList.fromJson(json.decode(snapshot.data));
						var characterData = characterBuilder.selectCharacter(listOfCharacters);


						children = <Widget>[
							Icon(
								Icons.error_outline,
								color: Colors.red,
								size: 60,
							),
							Padding(
								padding: const EdgeInsets.only(top: 16),
								child: Text('Error: AWESOME'),
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
				  }
			  ),
		  ),
	  );

//    return new Container(
//      color: Colors.white,
//      padding: EdgeInsets.all(10.0),
//		 child: Column(
//        children: <Widget>[
//			  Text(characterData.characterClass)
//		  ],
//		 ),
//	 );

//    return new Container(
//      color: Colors.white,
//      padding: EdgeInsets.all(10.0),
//      child: ListView(
//        padding: const EdgeInsets.all(8),
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              Text(
//                'Nome do Jogador: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.playerName,
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Nome do Personagem: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.characterName,
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Raça: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.race,
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Classe: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.characterClass,
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Nivel: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.level.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Tendência: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                '$tendencyEthics $tendencyMorality',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Sexo: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.sex,
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Idade: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.age.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Divindade: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.divinity,
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Tamanho: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.size,
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Desclocamento: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.displacement.toString() + 'm',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Habilidades: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Força: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.str.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Modificador de Força: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.strMod.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Destreza: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.dex.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Modificador de Destreza: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.dexMod.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Constituição: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.con.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Modificador de Constituição: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.conMod.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Inteligência: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.intel.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Modificador de Inteligência: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.intMod.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Sabedoria: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.wis.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Modificador de Sabedoria: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.wisMod.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Carisma: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.cha.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//          Row(
//            children: <Widget>[
//              Text(
//                'Modificador de Carisma: ',
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              ),
//              Text(
//                characterData.chaMod.toString(),
//                style: TextStyle(fontSize: 15.0, color: Colors.black87),
//              )
//            ],
//          ),
//        ],
//      ),
////      child: Column(
////        mainAxisAlignment: MainAxisAlignment.center,
////        crossAxisAlignment: CrossAxisAlignment.start,
////        children: <Widget>[
////          RaisedButton(
////            onPressed: () {
////              Navigator.pushNamed(context, '/');
////            },
////            child: Text(
////              'Humano',
////              style: TextStyle(
////                  color: Colors.white,
////                  fontSize: 22.0
////              ),
////            ),
////            color: Colors.black87,
////          ),
////          RaisedButton(
////            onPressed: () {
////              Navigator.pushNamed(context, '/');
////            },
////            child: Text(
////              'Elfo',
////              style: TextStyle(
////                  color: Colors.white,
////                  fontSize: 22.0
////              ),
////            ),
////            color: Colors.black87,
////          ),
////          RaisedButton(
////            onPressed: () {
////              Navigator.pushNamed(context, '/');
////            },
////            child: Text(
////              'Anão',
////              style: TextStyle(
////                  color: Colors.white,
////                  fontSize: 22.0
////              ),
////            ),
////            color: Colors.black87,
////          )
////        ],
////      ),
//    );
  }
}
