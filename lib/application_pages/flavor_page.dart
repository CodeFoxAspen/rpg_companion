import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rpgcompanion/helpers/character_builder.dart';
import 'package:rpgcompanion/models/character_model.dart';

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
        child: Center(
          child: Text('Interpretar um Personagem'),
        )
      ),
    );
  }
}
