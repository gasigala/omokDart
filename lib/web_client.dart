import 'package:http/http.dart' as http;
import 'strategy_parser.dart';

class WebClient {
  static const defaultServer =
      'https://www.cs.utep.edu/cheon/cs3360/project/omok/info/';
  var server;
  WebClient(this.server);

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
