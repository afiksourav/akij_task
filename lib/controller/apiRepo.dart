import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as https;
import 'package:http/http.dart';

class Repositores {
  Future<Map> googleMap(double lat, double long) async {
    final url = Uri.parse("https://www.akijpipes.com/api/lat-long");
    final headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
    Map body = {
      "user_id": "1997",
      "lat": lat,
      "long": long,
    };

    print("googleMap $body");
    try {
      final Response response = await https.post(url, headers: headers, body: jsonEncode(body));
      print("googleMap response ${response.body}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("googleMap status code :- ${response.statusCode}");

        return jsonDecode(response.body);
      } else {
        print(' googleMap: ${response.reasonPhrase}');
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<Map> userData() async {
    final url = Uri.parse("https://www.akijpipes.com/api/lat-long/1997");
    final headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};

    try {
      final Response response = await https.get(
        url,
        headers: headers,
      );
      print("userData response ${response.body}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("userData status code :- ${response.statusCode}");

        return jsonDecode(response.body);
      } else {
        print(' userData: ${response.reasonPhrase}');
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return {};
  }
}
