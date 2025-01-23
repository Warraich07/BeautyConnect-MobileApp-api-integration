class ServicesModel {
  final int? id;
  final String? name;
  final String? image;
  final String? time;
  final int? price;

  ServicesModel({
    this.id,
    this.name,
    this.image,
    this.time,
    this.price,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    time: json["time"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "time": time,
    "price": price,
  };
}
