import 'dart:io';
import 'web_client.dart';
import 'board.dart';
import 'response.dart';

class ConsleUI {
  void printMessage(String msg) {
    stdout.writeln(msg);
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
    //go through the strategy list we pass
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
      } catch (_) {
        stdout.write('invalid value');
      }
    }
    return strategies[strategy - 1];
  }

  promptMove(Board board) {
    showBoard(board.positions);
    int x;
    int y;

    while (true) {
      stdout.write('Enter x & y (1-15, e.g., 9 12)\n');
      var line = stdin.readLineSync() ?? "";
      List<String>? parsed = line.split(' ');

      if (parsed.length != 2) {
        //will print if we give too many arguments
        stdout.write('Invalid input try again\n');
      } else {
        try {
          x = int.parse(parsed[0]);
          y = int.parse(parsed[1]);
          //will be y, x since our array is [rows][cols]
          if (board.isMoveValid(y, x)) {
            break;
          } else {
            //will print if we out of range
            stdout.write('Invalid input try again\n');
          }
        } catch (_) {
          //will print if it cant be parsed to int
          stdout.write('Invalid input try again\n');
        }
      }
    }
    //convert it back to a string so i can pass it to the web client
    return [x, y];
  }

  void showBoard(var positions) {
    var indexes =
        List<int>.generate(positions.length, (i) => (i + 1) % 10).join(' ');
    stdout.writeln("x $indexes");

    var lines = List<String>.filled(positions.length + 1, '--').join('');
    stdout.writeln(lines);

    for (int i = 0; i < positions.length; i++) {
      stdout.write('${(i + 1) % 10}|');
      stdout.writeln(positions[i].join(" "));
    }
  }

  void playGame(Board board, String pid) async {
    while (true) {
      var cordinates = promptMove(board);
      var server = WebClient(WebClient.defaultServer);
      //make it into a string we can directly pass to the web client
      //also making it zero indexed
      var combinedCords = "${cordinates[0] - 1},${cordinates[1] - 1}";

      //get the response from the server
      var response = await server.getAckMove(pid, combinedCords);
      var ackMove = response['ack_move'];
      var move = response['move'];
      //if the game is over well update board to show winning row
      if (Response.checkIfGameOver(
          ackMove['isDraw'], move['isDraw'], ackMove['isWin'], move['isWin'])) {
        //board.updateWinningRow(ackMove['row'], )
        //update the board
        board.updateBoard(ackMove['y'], ackMove['x'], 'X');
        board.updateBoard(move['y'], move['x'], 'O');
        //get the winning row
        var row = board.getWinningRow(ackMove['row'], move['row']);
        //update winning row
        board.updateWinningRow(row);
        showBoard(board.positions);

        stdout.writeln("the game has ended");
        break;
      } else {
        //ack move is the move that we just made
        //will be y,x since thats our row & col
        board.updateBoard(ackMove['y'], ackMove['x'], 'X');
        board.updateBoard(move['y'], move['x'], 'O');
      }
      stdout.writeln("end of while loop");
    }
  }
}
