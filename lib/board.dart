import 'dart:io';

/// Can be thought of as the model part of our MVC model, this holds our board representation witch is just a 
/// list of list of strings. 
class Board {
  final int size;
  var _positions;

  ///Takes in the [x] and [y] cordinates that the user has inputed and makes sure they are in our 1 indexed range.
  ///Then make sure there is not already a piece on the board but in a 0 indexed manner. 
  bool isMoveValid(var x, var y) {
    if ((x < 1 || x > size) || (y < 1 || y > size)) {
      return false;
    }
    //this is wonky but we have to do -1 here since its indexed
    if (positions[x - 1][y - 1] != ".") {
      stdout.writeln("in here");
      return false;
    }
    return true;
  }

  /// Takes in positions [x] and [y] and sets our positions list to [symbol].
  void updateBoard(var x, var y, String symbol) {
    positions[x][y] = symbol;
  }

  //we will have the winning row be represented by a *
  void updateWinningRow(List<dynamic> row) {
    for (int i = 0; i < row.length; i += 2) {
      updateBoard(row[i+ 1], row[i], '*');
    }
  }

  List<dynamic> getWinningRow(var ackMove, var move) {
    if (ackMove.length == 10) {
      return ackMove;
    } else if (move.length == 10) {
      return move;
    }
    return [];
  }

  //initializes board with the parameters that we pass in
  Board(this.size, this._positions);

  //this is how well actually get the board
  static Board boardGenerator(size) {
    var board = List.generate(
        size, (i) => List.filled(size, ".", growable: false),
        growable: false);
    return Board(size, board);
  }

  get positions => _positions;
}
