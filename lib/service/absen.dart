import 'dart:convert';

import 'package:attendance2/model/getabsen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/createabsen.dart';

class Absenservice {
  Future<Createdataabsen> createabsen(id) async {
    var url = "http://absen.devmee.tech/absen/${id}";
    // var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var post = await http.post(Uri.parse(url));
    if (post.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(post.body) as Map<String, dynamic>;
      var itemCount = jsonResponse;
      // print(itemCount);
      return Createdataabsen.fromjson(jsonDecode(post.body));
    } else {
      return Createdataabsen.fromjson(jsonDecode(post.body));
    }
  }

  Future<List<Datalist>> getabsen() async {
    List<Datalist> datalist = [];
    var url = "http://absen.devmee.tech/getdataabsen";
    // var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var get = await http.get(Uri.parse(url));
    if (get.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(get.body) as Map<String, dynamic>;
      var itemCount = jsonResponse;
      // print(itemCount);
      final json = jsonDecode(get.body);
      Getdataabsen response = Getdataabsen.fromjson(json);
      response.data!.forEach((element) {
        datalist.add(element);
      });
      print(datalist);
      return datalist;
      // return listVideo.where((i) => i.categoryId == id).toList();
      // return Getdataabsen.fromjson(jsonDecode(get.body));
    } else {
      print("nooooo");
      return [];
      // return Getdataabsen.fromjson(jsonDecode(get.body));
    }
  }
}
