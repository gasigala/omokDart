class Board {
  final int size;
  var _board;
  Board(this.size, this._board);
  static Board boardGenerator(size) {
    var board = List.generate(
        size, (i) => List.filled(size, ".", growable: false),
        growable: false);
    return Board(size, board);
  }

  get board => _board;
}
