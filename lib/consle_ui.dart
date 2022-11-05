import 'dart:io';
import 'web_client.dart';
import 'board.dart';
import 'response.dart';

/// This could be seen as the view part of the MVC model. This will call any methods that either require input or
/// produce an output in the terminal that the user needs to play the game.
class ConsleUI {
  void printMessage(String msg) {
    stdout.writeln(msg);
  }

  ///Takes in a default [serverUrl] and lets the user specify one if they would like.
  promptServer([serverUrl = WebClient.defaultServer]) {
    stdout.write("Enter server URL default is $serverUrl\n");
    var line = stdin.readLineSync();
    if (line == null || line.isEmpty == true) {
      return serverUrl;
    }
    return line;
  }

  ///Takes in a [List] of strategies then interates through them and asked the user to select one.
  promptStrategy(List<dynamic> strategies) {
    stdout.write("Select one of the following straregies\n");

    ///go through the strategy list we pass
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
        stdout.writeln('invalid value');
      }
    }
    return strategies[strategy - 1];
  }

  /// Takes in a instance of [board] and displays it. Then asks the user for input. It will check the length of the input
  /// then try to convert it into an int and make sure the move is valid and the space is not already being used.
  /// If these conditions are not meet it will promt the user to enter a move again.
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

  ///Takes in the List [positions] and will then generate the indexes and display them.
  void showBoard(var positions) {
    //make the x axis numbers
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

  /// Takes in a [Board] instanse as well as a String [pid]
  ///This will prompt the user to make a move and if valid, will check for a winner
  ///and also update the board accordingly.
  ///The main logic comes from getting the json reponse ack_move and move into their own map that we can acess
  ///if there is a winner
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
      var move = response['move'] ?? {'isWin': false, 'isDraw': false};
      //if the game is over well update board to show winning row
      if (Response.checkIfGameOver(
          ackMove['isDraw'], move['isDraw'], ackMove['isWin'], move['isWin'])) {
        //update the board
        board.updateBoard(ackMove['y'], ackMove['x'], 'X');
        if (move.length == 5) {
          board.updateBoard(move['y'], move['x'], '#');
        }
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
        board.updateBoard(move['y'], move['x'], '#');
      }
    }
  }
}
