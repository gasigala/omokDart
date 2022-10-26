import 'consle_ui.dart';
import 'web_client.dart';
import 'info.dart';
import 'board.dart';
import 'consle_ui.dart';

class Controller {
  Future<void> start() async {
    var ui = ConsleUI();
    ui.printMessage('Welcome to omok game');
    var server = ui.promptServer();
    ui.printMessage('Connecting to server\n');
    var net = WebClient(server);
    //ui.printMessage('making new game\n');
    //will return sign and strategy
    var info = await net.getInfo();

    if (info == null) {
      ui.printMessage('unable to connect, exiting');
      return;
    }

    Info gameInfo = Info(info['size'], info['strategies']);
    var board = Board.boardGenerator(gameInfo.size);
    ui.printMessage("creating game\n");
    ui.promptStrategy(info['strategies']);
    ui.printMessage("game created\n");

  }
}
