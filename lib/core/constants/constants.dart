import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String BASE_URL = String.fromEnvironment(
  "BASE_URL",
  defaultValue: "http://localhost:8080",
);

const String API_URL = String.fromEnvironment(
  "API_URL",
  defaultValue: "$BASE_URL/api",
);

const ACCESS_TOKEN_STORAGE_KEY = "access_token";
const REFRESH_TOKEN_STORAGE_KEY = "refresh_token";

Color brightColorFromString(String input) {
  final hash = input.codeUnits.fold(0, (prev, elem) => prev + elem * 31);
  final r = 100 + (hash * 123) % 156;
  final g = 100 + (hash * 321) % 156;
  final b = 100 + (hash * 213) % 156;

  return Color.fromARGB(255, r, g, b);
}

Widget highlightText(String text, {TextStyle? style}) {
  final defaultStyle = style ?? const TextStyle(fontSize: 14);
  final highlightStyle = defaultStyle.copyWith(
    backgroundColor: Colors.yellowAccent,
    fontWeight: FontWeight.bold,
  );

  final spans = <TextSpan>[];

  int index = 0;
  while (true) {
    final start = text.indexOf("<mark>", index);
    if (start < 0) {
      spans.add(TextSpan(text: text.substring(index), style: defaultStyle));
      break;
    }
    if (start > index) {
      spans.add(
        TextSpan(text: text.substring(index, start), style: defaultStyle),
      );
    }
    final end = text.indexOf("</mark>", start);
    if (end < 0) break;

    final highlighted = text.substring(start + 6, end);

    spans.add(TextSpan(text: highlighted, style: highlightStyle));

    index = end + 7;
  }

  return RichText(text: TextSpan(children: spans));
}

enum DirectoryViewMode {
  navigation, // go_router
  move, // обновление через bloc
}

final dateFormatter = DateFormat('yMMMMd');
