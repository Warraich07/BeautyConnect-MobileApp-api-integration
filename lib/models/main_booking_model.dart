class MainBookigModel {
  int? id;
  int? userId;
  int? barberId;
  DateTime? date;
  String? time;
  String? startTime;
  String? endTime;
  String? paymentStatus;
  String? totalAmount;
  String? status;
  dynamic reason;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? totalTime;
  String? type;
  dynamic guestId;
  dynamic ticket;
  List<Service>? services;
  Barber? barber;
  String? averageRating;

  MainBookigModel({
    this.id,
    this.userId,
    this.barberId,
    this.date,
    this.time,
    this.startTime,
    this.endTime,
    this.paymentStatus,
    this.totalAmount,
    this.status,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.totalTime,
    this.type,
    this.guestId,
    this.ticket,
    this.services,
    this.barber,
    this.averageRating
  });

  factory MainBookigModel.fromJson(Map<String, dynamic> json) => MainBookigModel(
    id: json["id"],
    userId: json["user_id"],
    barberId: json["barber_id"],
    date: json["date"] == null ? null : DateTime.now(),
    time: json["time"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    paymentStatus: json["payment_status"],
    totalAmount: json["total_amount"],
    status: json["status"],
    reason: json["reason"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    totalTime: json["total_time"],
    type: json["type"],
    guestId: json["guest_id"],
    ticket: json["ticket"],
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    barber: json["barber"] == null ? null : Barber.fromJson(json["barber"]),
    averageRating: json["average_rating"].toString()
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "barber_id": barberId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "start_time": startTime,
    "end_time": endTime,
    "payment_status": paymentStatus,
    "total_amount": totalAmount,
    "status": status,
    "reason": reason,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "total_time": totalTime,
    "type": type,
    "guest_id": guestId,
    "ticket": ticket,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "barber": barber?.toJson(),
    "average_rating":averageRating
  };
}

class Barber {
  int? id;
  String? name;
  String? type;
  String? email;
  String? image;
  dynamic about;
  String? location;
  String? lat;
  String? long;
  dynamic status;
  String? otp;
  String? profileStatus;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic phone;
  dynamic deletedAt;

  Barber({
    this.id,
    this.name,
    this.type,
    this.email,
    this.image,
    this.about,
    this.location,
    this.lat,
    this.long,
    this.status,
    this.otp,
    this.profileStatus,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.phone,
    this.deletedAt,
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    phone: json["phone"],
    deletedAt: json["deleted_at"],
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
  };
}

class Service {
  int? id;
  int? bookingId;
  int? serviceChargeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? serviceId;
  ServiceCharge? serviceCharge;
  List<UserService>? userServices;

  Service({
    this.id,
    this.bookingId,
    this.serviceChargeId,
    this.createdAt,
    this.updatedAt,
    this.serviceId,
    this.serviceCharge,
    this.userServices,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    bookingId: json["booking_id"],
    serviceChargeId: json["service_charge_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    serviceId: json["service_id"],
    serviceCharge: json["service_charge"] == null ? null : ServiceCharge.fromJson(json["service_charge"]),
    userServices: json["user_services"] == null ? [] : List<UserService>.from(json["user_services"]!.map((x) => UserService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "service_charge_id": serviceChargeId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "service_id": serviceId,
    "service_charge": serviceCharge?.toJson(),
    "user_services": userServices == null ? [] : List<dynamic>.from(userServices!.map((x) => x.toJson())),
  };
}

class ServiceCharge {
  int? id;
  int? barberId;
  int? serviceId;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  ServiceCharge({
    this.id,
    this.barberId,
    this.serviceId,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceCharge.fromJson(Map<String, dynamic> json) => ServiceCharge(
    id: json["id"],
    barberId: json["barber_id"],
    serviceId: json["service_id"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "barber_id": barberId,
    "service_id": serviceId,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class UserService {
  int? id;
  String? name;
  String? portugueseName;
  String? frenchName;
  String? image;
  String? time;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserService({
    this.id,
    this.name,
    this.image,
    this.time,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.portugueseName,
    this.frenchName
  });

  factory UserService.fromJson(Map<String, dynamic> json) => UserService(
    id: json["id"],
    name: json["name"]??'',
    image: json["image"],
    time: json["time"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    portugueseName: json["portuguese_name"]??'',
    frenchName: json["french_name"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "time": time,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}


