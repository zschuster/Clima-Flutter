import 'dart:convert';
import 'package:http/http.dart' as http;

class Networker {
  Networker({this.url});

  final String url;

  Future<dynamic> get() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
