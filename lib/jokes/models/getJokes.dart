import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  var baseURL = Uri.parse("https://v2.jokeapi.dev");
  var categories = ["Programming", "Misc", "Pun", "Spooky", "Christmas"];
  var params = ["blacklistFlags=nsfw,religious,racist", "idRange=0-100"];

  var response = await http.get(
      Uri.parse("$baseURL/joke/${categories.join(",")}?${params.join("&")}"));

  if (response.statusCode < 300) {
    var randomJoke = json.decode(response.body);

    if (randomJoke['type'] == "single") {
      // If type == "single", the joke only has the "joke" property
      print(randomJoke['joke']);
    } else {
      // If type == "single", the joke only has the "joke" property
      print(randomJoke['setup']);
      print(randomJoke['delivery']);
    }
  } else {
    print(
        "Error while requesting joke.\n\nStatus code: ${response.statusCode}\nServer response: ${response.body}");
  }
}
