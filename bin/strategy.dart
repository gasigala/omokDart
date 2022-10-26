
import 'controller.dart';

// Future<void> main() async {
//   stdout.write('Welcome to Omok Game!\n');
//   // Default URL
//   var defaultUrl = "https://www.cs.utep.edu/cheon/cs3360/project/omok/info/";
//   stdout.write('Enter the server URL [default: $defaultUrl]\n');
//   var url = defaultUrl;

//   // Convert default string url to Uri object
//   var response = await http.get(Uri.parse(url));
//   var info = json.decode(response.body); // used to be json.decode
//   var strategies = info['strategies'];

//   // Taking user provided URL
//   var line = stdin.readLineSync();

//   try {
//     url = line!;
//     response = await http.get(Uri.parse(url)); // Convert user url
//     info = json.decode(response.body); // Retrieve JSON reponse
//     strategies = info['strategies']; // Store strategies
//   } catch (e) {
//     print("Invalid input! Using default URL");
//     url =
//         "https://www.cs.utep.edu/cheon/cs3360/project/omok/info/"; // Reset to Default Value
//     response = await http.get(Uri.parse(url));
//     info = json.decode(response.body);
//     //strategies = info['strategies'];
//   }

//   //User url valid
//   stdout.write('Using [$url]\nObtaining server information .......\n');
//   stdout.write(info);
//   stdout.write("\n");

//   strategies = info['strategies'];

//   // Display available strategy choices
//   for (int i = 0; i < strategies.length; i++) {
//     var currentStrategy = strategies[i];
//     int currentIndex = i + 1;
//     stdout.write("$currentIndex. $currentStrategy ");
//   }
//   int numChosen = 1;
//   stdout.write("[default: $numChosen] ");

//   //Inquire Choice
//   line = stdin.readLineSync();
//   while (line!.isNotEmpty) {
//     try {
//       numChosen = int.parse(line);
//     } catch (e) {
//       print("Invalid selection: Enter an integer number.");
//       numChosen = 1; // Reset back to default Value
//       line = stdin.readLineSync();
//       continue;
//     }
//     if ((numChosen > strategies.length) || (numChosen <= 0)) {
//       int len = strategies.length;
//       print("Invalid selection: {$numChosen} Out of bounds. Please enter a number between 1 and $len inclusive ");
//       numChosen = 1; // Reset back to default value
//       line = stdin.readLineSync();
//       continue;
//     }
//     break;
//   }
//   var chosenStrategy = strategies[numChosen - 1];
//   stdout.write("Creating a new game... with strategy {$chosenStrategy}");
// }

void main(List<String> args) {
  Controller().start();
}

