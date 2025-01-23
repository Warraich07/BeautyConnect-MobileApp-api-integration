class BarbersModel {
  int id;
  String name;
  String type;
  String email;
  String? image;
  dynamic about;
  String? location;
  String? lat;
  String? long;
  dynamic status;
  String? otp;
  String profileStatus;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic phone;
  dynamic deletedAt;
  String? averageRating;
  dynamic countryCode;
  String? saloonName;
  List<ServiceCharge> serviceCharges;

  BarbersModel({
    required this.id,
    required this.name,
    required this.type,
    required this.email,
    required this.image,
    required this.about,
    required this.location,
    required this.lat,
    required this.long,
    required this.status,
    required this.otp,
    required this.profileStatus,
    required this.emailVerifiedAt,
     this.createdAt,
     this.updatedAt,
    required this.phone,
    required this.deletedAt,
     this.averageRating,
    required this.countryCode,
    required this.saloonName,
    required this.serviceCharges,
  });

  factory BarbersModel.fromJson(Map<String, dynamic> json) => BarbersModel(
    id: json["id"]??0,
    name: json["name"]??'',
    type: json["type"]??'',
    email: json["email"]??'',
    image: json["image"]??'',
    about: json["about"]??'',
    location: json["location"]??'',
    lat: json["lat"]??'',
    long: json["long"]??'',
    status: json["status"]??'',
    otp: json["otp"]??'',
    profileStatus: json["profile_status"]??'',
    emailVerifiedAt: json["email_verified_at"]??'',
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"]==null ? null : DateTime.parse(json["updated_at"]),
    phone: json["phone"]??'',
    deletedAt: json["deleted_at"]??'',
    averageRating: json["average_rating"].toString()==null ? null :json["average_rating"].toString(),
    countryCode: json["country_code"]??'',
      saloonName:json["saloon_name"],
    serviceCharges: List<ServiceCharge>.from(json["service_charges"].map((x) => ServiceCharge.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "email": email,
    "image": image,
    "about": about,
    "location": location,
    "lat": lat,
    "long": long,
    "status": status,
    "otp": otp,
    "profile_status": profileStatus,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "phone": phone,
    "deleted_at": deletedAt,
    "average_rating": averageRating,
    "country_code": countryCode,
    "service_charges": List<dynamic>.from(serviceCharges.map((x) => x.toJson())),

  };
}
class ServiceCharge {
  int id;
  int barberId;
  int serviceId;
  int? price;
  DateTime createdAt;
  DateTime updatedAt;
  List<Service> services;

  ServiceCharge({
    required this.id,
    required this.barberId,
    required this.serviceId,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.services,
  });

  factory ServiceCharge.fromJson(Map<String, dynamic> json) => ServiceCharge(
    id: json["id"],
    barberId: json["barber_id"],
    serviceId: json["service_id"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "barber_id": barberId,
    "service_id": serviceId,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
  };
}

class Service {
  int id;
  String? name;
  String? portugueseName;
  String? frenchName;
  String image;
  String time;
  int price;
  DateTime createdAt;
  DateTime updatedAt;

  Service({
    required this.id,
    required this.name,
    required this.portugueseName,
    required this.frenchName,
    required this.image,
    required this.time,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    portugueseName: json["portuguese_name"],
    frenchName: json["french_name"],
    image: json["image"],
    time: json["time"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "portuguese_name": portugueseName,
    "french_name": frenchName,
    "image": image,
    "time": time,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum Name {
  APARAR_BARBA_CONTORNO_TRATAMENTO,
  COLORAO_BARBA,
  COLORAO_CABELO,
  CONTORNO_BARBA,
  CORTE_CRIANA,
  CORTE_HOMEM,
  HAIR_STYLING,
  TRATAMENTO_ROSTO
}

final nameValues = EnumValues({
  "Aparar barba + contorno + tratamento": Name.APARAR_BARBA_CONTORNO_TRATAMENTO,
  "Coloração barba": Name.COLORAO_BARBA,
  "Coloração cabelo": Name.COLORAO_CABELO,
  "Contorno barba": Name.CONTORNO_BARBA,
  "Corte criança": Name.CORTE_CRIANA,
  "Corte homem": Name.CORTE_HOMEM,
  "hair styling": Name.HAIR_STYLING,
  "Tratamento rosto": Name.TRATAMENTO_ROSTO
});

enum Type {
  BARBER
}

final typeValues = EnumValues({
  "barber": Type.BARBER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
