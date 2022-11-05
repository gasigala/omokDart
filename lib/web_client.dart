import 'package:http/http.dart' as http;
import 'strategy_parser.dart';

/// Uses the http dart library to parse URL's and the [StrategyParser] class do decode the messages into a usable format
class WebClient {
  static const defaultServer =
      'https://www.cs.utep.edu/cheon/cs3360/project/omok/info/';
  var server;
  WebClient(this.server);

  ///Will try to parse the server that is saved in the object
  ///returns a json response with size of the board and availible strategies
  getInfo() async {
    try {
      var serverURL = Uri.parse(server);
      var response = await http.get(serverURL);
      var jsonResponce = StrategyParser.parseInfo(response.body);
      return jsonResponce;
    } catch (_) {
      return null;
    }
  }

  /// Takes in [pickedStrategy] that the user had selected then attemps to parse the URI to get a JSON response
  /// returns the parsed JSON response with a unique PID
  getPID(String pickedStrategy) async {
    var url = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/new/';
    var strategy = pickedStrategy;
    try {
      var uri = Uri.parse('$url?strategy=$strategy');
      var response = await http.get(uri);
      var jsonResponce = StrategyParser.parseInfo(response.body);
      return jsonResponce;
    } catch (_) {
      return null;
    }
  }

  ///Takes in a [pidIn] and a [xyIn] that will be appended to our url
  ///returns a decoded JSON responce with several fields that allow the user to play the game
  getAckMove(String pidIn, var xyIn) async {
    var url = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/play/';
    var pid = pidIn;
    var xy = xyIn;
    try {
      var uri = Uri.parse('$url?pid=$pid&move=$xy');
      var response = await http.get(uri);
      var jsonResponce = StrategyParser.parseInfo(response.body);
      return jsonResponce;
    } catch (_) {
      return null;
    }
  }
}
