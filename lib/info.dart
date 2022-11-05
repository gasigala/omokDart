///An object that will contain the strategies availible to play the game as well as the board size
///values assinged from JSON responce
class Info {
  final List<dynamic> strategies;
  final int _size;

  Info(this._size, this.strategies);

  get size => _size;
}
