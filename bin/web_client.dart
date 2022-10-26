import 'package:http/http.dart' as http;
import './strategy_parser.dart';


class WebClient {
  static const defaultServer =
      'https://www.cs.utep.edu/cheon/cs3360/project/omok/info/';
  var server;
  WebClient(this.server);
  
  getInfo() async {
    try {
      var ServerURL = Uri.parse(server);
      var response = await http.get(ServerURL);
      var jsonResponce = StrategyParser.parseInfo(response.body);
      return jsonResponce;
    } catch (_, e) {
      return null;
    }
  }
}
