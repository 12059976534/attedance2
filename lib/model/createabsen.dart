class Createdataabsen {
  String message;
  Data data;
  Createdataabsen({required this.data, required this.message});

  factory Createdataabsen.fromjson(Map<String, dynamic> json) {
    return Createdataabsen(
        data: Data.fromjson(json["data"]), message: json["message"]);
  }
}

class Data {
  final int id;
  final String UserId;
  final String createdAt;

  Data({required this.id, required this.UserId, required this.createdAt});
  factory Data.fromjson(Map<String, dynamic> json) {
    return Data(
        id: json["id"], UserId: json["UserId"], createdAt: json["createdAt"]);
  }
}
