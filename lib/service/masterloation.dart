import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

ServiceMaster(dynamic datalocation) async {
  var url = "http://absen.devmee.tech/createmasterlocation";
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var post = await http.post(Uri.parse(url),
      body: {"location": datalocation.toString()}, headers: headers);
  if (post.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(post.body) as Map<String, dynamic>;
    var itemCount = jsonResponse;
    print(itemCount);
    return itemCount;
  }
}
