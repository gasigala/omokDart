import 'consle_ui.dart';
import 'web_client.dart';
import 'info.dart';
import 'board.dart';

class Controller {
  Future<void> start() async {
    var ui = ConsleUI();
    ui.printMessage('Welcome to omok game');
    var server = ui.promptServer();
    ui.printMessage('Connecting to server\n');
    var net = WebClient(server);

    //will return sign and strategy
    var info = await net.getInfo();

    if (info == null) {
      ui.printMessage('unable to connect, exiting');
      return;
    }

    Info gameInfo = Info(info['size'], info['strategies']);
    //making the text representation of the board
    var board = Board.boardGenerator(gameInfo.size);
    ui.printMessage("Please Select a strategy");
    var strategySelected = ui.promptStrategy(gameInfo.strategies);
    ui.printMessage("Strategy selected");
    //will call the web client to get the pid
    ui.printMessage(strategySelected);
    var pid = await net.getPID(strategySelected);
    ui.printMessage(pid['pid']);

    //this is where most of the logic happens 
    ui.playGame(board, pid['pid']);
  }
}
