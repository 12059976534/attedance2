import 'dart:convert';

import 'package:attendance2/model/registrasi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../auth/login.dart';
import '../model/login.dart';

class Auth {
  Future<Regiseasi> Register(user, password) async {
    var url = "http://absen.devmee.tech/registrasi";
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var post = await http.post(Uri.parse(url),
        body: {"username": user.toString(), "password": password.toString()},
        headers: headers);
    if (post.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(post.body) as Map<String, dynamic>;
      var itemCount = jsonResponse;
      print(itemCount);
      return Regiseasi.fromjson(jsonDecode(post.body));
    } else {
      var jsonResponse = convert.jsonDecode(post.body) as Map<String, dynamic>;
      var itemCount = jsonResponse;
      print(itemCount);
      // return itemCount;
      return Regiseasi.fromjson(jsonDecode(post.body));
    }
  }

  Future<Loginmodel> Loginservice(user, password) async {
    var url = "http://absen.devmee.tech/login";
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var post = await http.post(Uri.parse(url),
        body: {"username": user.toString(), "password": password.toString()},
        headers: headers);
    if (post.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(post.body) as Map<String, dynamic>;
      var itemCount = jsonResponse;
      print(itemCount);
      return Loginmodel.fromjson(jsonDecode(post.body));
    } else {
      var jsonResponse = convert.jsonDecode(post.body) as Map<String, dynamic>;
      var itemCount = jsonResponse;
      print(itemCount);
      // return itemCount;
      return Loginmodel.fromjson(jsonDecode(post.body));
    }
  }
}
