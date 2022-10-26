import 'dart:convert';


class StrategyParser{
  static parseInfo(String data) {
    return jsonDecode(data);
  }
}