import 'dart:io';
import 'web_client.dart';

class ConsleUI {
  void printMessage(String msg) {
    stdout.write(msg);
  }

  promptServer([serverUrl = WebClient.defaultServer]) {
    stdout.write("Enter server URL default is $serverUrl\n");
    var line = stdin.readLineSync();
    if (line == null || line.isEmpty == true) {
      return serverUrl;
    }
    return line;
  }

  promptStrategy(List<dynamic> strategies) {
    stdout.write("Select one of the following straregies\n");
    for (int i = 0; i < strategies.length; i++) {
      stdout.write('${i + 1} ${strategies[i]}  ');
    }

    int strategy = 0;
    while (strategy < 1 || strategy > strategies.length) {
      try {
        var line = stdin.readLineSync();
        strategy = int.parse(line ?? '0');
        if (strategy < 1 || strategy > strategies.length) {
          stdout.writeln(
              'invalid value please enter a number betwen 1 - ${strategies.length}');
        }
      } catch (_, e) {
        stdout.write('invalid value');
      }
    }
    return strategies[strategy - 1];
  }
}
