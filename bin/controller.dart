import 'consle_ui.dart';
import 'web_client.dart';


class Controller {
  void start() {
    var ui = ConsleUI();
    ui.printMessage('Welcome to omok game');
    var server = ui.promptServer();
    ui.printMessage('Connecting to server');
    var net = WebClient(server);
    ui.printMessage('making new game');
    //will return sign and strategy
    var info = net.getInfo();
  }
}