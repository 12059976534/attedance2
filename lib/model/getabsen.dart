class Getdataabsen {
  String? message;
  List<Datalist>? data;
  Getdataabsen({required this.data, required this.message});

  factory Getdataabsen.fromjson(Map<String, dynamic> json) {
    return Getdataabsen(
        data:
            List<Datalist>.from(json["data"].map((x) => Datalist.fromjson(x))),
        message: json["message"]);
  }
}

class Datalist {
  int? id;
  int? UserId;
  String? createdAt;

  Datalist({required this.id, required this.UserId, required this.createdAt});
  factory Datalist.fromjson(Map<String, dynamic> json) {
    return Datalist(
        id: json["id"], UserId: json["UserId"], createdAt: json["createdAt"]);
  }
}
