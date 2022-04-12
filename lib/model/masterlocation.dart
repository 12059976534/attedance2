class Datalocationservice {
  String message;
  Data data;
  Datalocationservice({required this.data, required this.message});

  factory Datalocationservice.fromjson(Map<String, dynamic> json) {
    return Datalocationservice(
        data: Data.fromjson(json["data"]), message: json["message"]);
  }
}

class Data {
  final String location;
  Data({
    required this.location,
  });
  factory Data.fromjson(Map<String, dynamic> json) {
    return Data(location: json["location"]);
  }
}
