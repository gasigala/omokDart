class Response {
  Response();

  static bool checkIfGameOver(
      bool ackMoveDraw, bool moveDraw, bool ackMoveWin, bool moveWin) {
    if (ackMoveDraw == true || moveDraw == true) {
      return true;
    } else if (ackMoveWin == true || moveWin == true) {
      return true;
    }
    return false;
  }
}
