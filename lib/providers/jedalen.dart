import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JedalenProvider with ChangeNotifier {
  final String _jedalenURL =
      'https://www.jedalen.sk/Pages/EatMenu?Ident=rNT9rWnuqD';
  late final Map<String, List<String>> jedalenData;

  Future<void> fetchJedalenData() async {
    final response = await http.get(Uri.parse(_jedalenURL));
    print(response.body);
  }
}
