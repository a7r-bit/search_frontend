import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const API_URL = "http://10.235.131.82:3000";

const ACCESS_TOKEN_STORAGE_KEY = "access_token";
const REFRESH_TOKEN_STORAGE_KEY = "refresh_token";

Color brightColorFromString(String input) {
  final hash = input.codeUnits.fold(0, (prev, elem) => prev + elem * 31);
  final r = 100 + (hash * 123) % 156; 
  final g = 100 + (hash * 321) % 156;
  final b = 100 + (hash * 213) % 156;

  return Color.fromARGB(255, r, g, b);
}

final dateFormatter = DateFormat('dd.MM.yyyy HH:mm');
