import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class SamainFacts {
  List<String> _samainFacts = [];

  Future readFacts({String? fileName = 'res/samain.txt'}) async {
    final fileText = await rootBundle.loadString(fileName!);
    _samainFacts = fileText.split('\n');
  }

  String getFact() {
    return _samainFacts[Random().nextInt(_samainFacts.length)];
  }
}
