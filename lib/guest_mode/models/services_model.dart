class ServicesModel {
  int id;
  String name;
  String portuguesName;
  String frenchName;
  String image;
  String time;
  int price;
  DateTime createdAt;
  DateTime updatedAt;

  ServicesModel({
    required this.id,
    required this.name,
    required this.image,
    required this.time,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.portuguesName,
    required this.frenchName
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    time: json["time"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    portuguesName: json["portuguese_name"],
    frenchName: json["french_name"]

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "time": time,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
