import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/masterlocation.dart';

Future<Datalocationservice> getMasterlocation() async {
  var url = "http://absen.devmee.tech/getmasterlocation";
  // var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var post = await http.get(
    Uri.parse(url),
  );
  if (post.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(post.body) as Map<String, dynamic>;
    var itemCount = jsonResponse;
    // print(itemCount);
    return Datalocationservice.fromjson(jsonDecode(post.body));
  } else {
    return Datalocationservice.fromjson(jsonDecode(post.body));
  }
}
