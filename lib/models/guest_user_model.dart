// To parse this JSON data, do
//
//     final guestUserModel = guestUserModelFromJson(jsonString);

import 'dart:convert';

List<GuestUserModel> guestUserModelFromJson(String str) => List<GuestUserModel>.from(json.decode(str).map((x) => GuestUserModel.fromJson(x)));

String guestUserModelToJson(List<GuestUserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GuestUserModel {
  int id;
  dynamic userId;
  int barberId;
  DateTime date;
  String time;
  String startTime;
  String endTime;
  String paymentStatus;
  String totalAmount;
  String status;
  dynamic reason;
  DateTime createdAt;
  DateTime updatedAt;
  String totalTime;
  String type;
  int guestId;
  String ticket;
  dynamic cancelBy;
  int guestUserId;
  List<Service> services;
  dynamic getUser;
  Barber barber;
  GuestUser guestUser;

  GuestUserModel({
    required this.id,
    required this.userId,
    required this.barberId,
    required this.date,
    required this.time,
    required this.startTime,
    required this.endTime,
    required this.paymentStatus,
    required this.totalAmount,
    required this.status,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
    required this.totalTime,
    required this.type,
    required this.guestId,
    required this.ticket,
    required this.cancelBy,
    required this.guestUserId,
    required this.services,
    required this.getUser,
    required this.barber,
    required this.guestUser,
  });

  factory GuestUserModel.fromJson(Map<String, dynamic> json) => GuestUserModel(
    id: json["id"],
    userId: json["user_id"],
    barberId: json["barber_id"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    paymentStatus: json["payment_status"],
    totalAmount: json["total_amount"],
    status: json["status"],
    reason: json["reason"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    totalTime: json["total_time"],
    type: json["type"],
    guestId: json["guest_id"],
    ticket: json["ticket"],
    cancelBy: json["cancel_by"],
    guestUserId: json["guest_user_id"],
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    getUser: json["get_user"],
    barber: Barber.fromJson(json["barber"]),
    guestUser: GuestUser.fromJson(json["guest_user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "barber_id": barberId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "start_time": startTime,
    "end_time": endTime,
    "payment_status": paymentStatus,
    "total_amount": totalAmount,
    "status": status,
    "reason": reason,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "total_time": totalTime,
    "type": type,
    "guest_id": guestId,
    "ticket": ticket,
    "cancel_by": cancelBy,
    "guest_user_id": guestUserId,
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
    "get_user": getUser,
    "barber": barber.toJson(),
    "guest_user": guestUser.toJson(),
  };
}

class Barber {
  int id;
  String name;
  String type;
  String email;
  String image;
  dynamic about;
  String? location;
  String? lat;
  String? long;
  dynamic status;
  dynamic otp;
  String profileStatus;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic phone;
  dynamic deletedAt;
  dynamic countryCode;
  double? averageRating;
  Barber({
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
    required this.averageRating
  });

  factory Barber.fromJson(Map<String, dynamic> json) => Barber(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    email: json["email"],
    image: json["image"],
    about: json["about"],
    location: json["location"],
    lat: json["lat"],
    long: json["long"],
    status: json["status"],
    otp: json["otp"],
    profileStatus: json["profile_status"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    phone: json["phone"],
    deletedAt: json["deleted_at"],
    countryCode: json["country_code"],
      averageRating: json["average_rating"].toDouble()
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
    "averageRating":averageRating
  };
}

class GuestUser {
  int id;
  String username;
  String email;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic description;

  GuestUser({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
  });

  factory GuestUser.fromJson(Map<String, dynamic> json) => GuestUser(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "phone": phone,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "description": description,
  };
}

class Service {
  int id;
  int bookingId;
  dynamic serviceChargeId;
  DateTime createdAt;
  DateTime updatedAt;
  int serviceId;
  dynamic serviceCharge;
  List<UserService> userServices;

  Service({
    required this.id,
    required this.bookingId,
    required this.serviceChargeId,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceId,
    required this.serviceCharge,
    required this.userServices,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    bookingId: json["booking_id"],
    serviceChargeId: json["service_charge_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    serviceId: json["service_id"],
    serviceCharge: json["service_charge"],
    userServices: List<UserService>.from(json["user_services"].map((x) => UserService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "service_charge_id": serviceChargeId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "service_id": serviceId,
    "service_charge": serviceCharge,
    "user_services": List<dynamic>.from(userServices.map((x) => x.toJson())),
  };
}

class UserService {
  int id;
  String name;
  String portugueseName;
  String frenchName;
  String image;
  String time;
  int price;
  DateTime createdAt;
  DateTime updatedAt;

  UserService({
    required this.id,
    required this.name,
    required this.image,
    required this.time,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.frenchName,
    required this.portugueseName
  });

  factory UserService.fromJson(Map<String, dynamic> json) => UserService(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    time: json["time"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    frenchName: json["french_name"],
    portugueseName: json["portuguese_name"],

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
