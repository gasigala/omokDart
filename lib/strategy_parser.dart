import 'dart:convert';

/// Parses the JSON data retrieved by the WebClient class and return the JSON as a map
class StrategyParser{
  static parseInfo(String data) {
    return jsonDecode(data);
  }
}