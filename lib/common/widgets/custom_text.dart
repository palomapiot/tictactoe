import 'package:flutter/material.dart';

TextStyle kCustomText(
        {double fontSize = 16,
        required Color color,
        FontWeight fontWeight = FontWeight.normal}) =>
    TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
