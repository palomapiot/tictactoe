import 'package:flutter/material.dart';
import 'package:tictactoe/common/samain_facts.dart';

import 'home/view/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final SamainFacts facts = SamainFacts();

  @override
  Widget build(BuildContext context) {
    facts.readFacts();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(facts: facts),
    );
  }
}

