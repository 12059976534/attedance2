class Loginmodel {
  String message;
  Data data;
  Loginmodel({required this.data, required this.message});

  factory Loginmodel.fromjson(Map<String, dynamic> json) {
    return Loginmodel(
        data: Data.fromjson(json["data"]), message: json["message"]);
  }
}

class Data {
  final int id;
  final String username;
  final String password;

  Data({required this.id, required this.password, required this.username});
  factory Data.fromjson(Map<String, dynamic> json) {
    return Data(
        id: json["id"], password: json["password"], username: json["username"]);
  }
}
