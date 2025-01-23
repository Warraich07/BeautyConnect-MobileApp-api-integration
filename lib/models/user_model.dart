
class UserModel {
  int id;
  String name;
  String type;
  String email;
  dynamic image;
  dynamic about;
  dynamic location;
  dynamic lat;
  dynamic long;
  String status;
  dynamic otp;
  String profileStatus;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String phone;
  dynamic deletedAt;
  String countryCode;

  UserModel({
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
    required this.createdAt,
    required this.updatedAt,
    required this.phone,
    required this.deletedAt,
    required this.countryCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    email: json["email"],
    image: json["image"],
    about: json["about"],
    location: json["location"],
    lat: json["lat"],
    long: json["long"],
    status: json["status"]==null?'':json["status"],
    otp: json["otp"],
    profileStatus: json["profile_status"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    phone: json["phone"]==null?'':json["phone"],
    deletedAt: json["deleted_at"],
    countryCode: json["country_code"]==null?'':json["country_code"],
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "phone": phone,
    "deleted_at": deletedAt,
    "country_code": countryCode,
  };
}
