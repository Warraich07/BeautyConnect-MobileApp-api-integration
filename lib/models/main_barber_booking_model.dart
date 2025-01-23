class MainBarberBookingModel {
  int? id;
  int? userId;
  int? barberId;
  DateTime? date;
  String? time;
  String? startTime;
  String? endTime;
  PaymentStatus? paymentStatus;
  String? totalAmount;
  String? status;
  String? reason;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? totalTime;
  Type? type;
  int? guestId;
  String? ticket;
  CancelBy? cancelBy;
  int? guestUserId;
  List<Service>? services;
  Barber? getUser;
  Barber? barber;
  GuestUser? guestUser;

  MainBarberBookingModel({
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
    this.cancelBy,
    this.guestUserId,
    this.services,
    this.getUser,
    this.barber,
    this.guestUser,
  });

  factory MainBarberBookingModel.fromJson(Map<String, dynamic> json) => MainBarberBookingModel(
    id: json["id"],
    userId: json["user_id"],
    barberId: json["barber_id"],
    date: json["date"] == null ? null : DateTime.now(),
    time: json["time"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    paymentStatus: paymentStatusValues.map[json["payment_status"]]!,
    totalAmount: json["total_amount"],
    status: json["status"],
    reason: json["reason"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    totalTime: json["total_time"],
    type: typeValues.map[json["type"]]!,
    guestId: json["guest_id"],
    ticket: json["ticket"],
    cancelBy: cancelByValues.map[json["cancel_by"]],
    guestUserId: json["guest_user_id"],
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    getUser: json["get_user"] == null ? null : Barber.fromJson(json["get_user"]),
    barber: json["barber"] == null ? null : Barber.fromJson(json["barber"]),
    guestUser: json["guest_user"] == null ? null : GuestUser.fromJson(json["guest_user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "barber_id": barberId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "start_time": startTime,
    "end_time": endTime,
    "payment_status": paymentStatusValues.reverse[paymentStatus],
    "total_amount": totalAmount,
    "status": status,
    "reason": reason,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "total_time": totalTime,
    "type": typeValues.reverse[type],
    "guest_id": guestId,
    "ticket": ticket,
    "cancel_by": cancelByValues.reverse[cancelBy],
    "guest_user_id": guestUserId,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "get_user": getUser?.toJson(),
    "barber": barber?.toJson(),
    "guest_user": guestUser?.toJson(),
  };
}

class Barber {
  int? id;
  String? name;
  CancelBy? type;
  Email? email;
  String? image;
  dynamic about;
  Location? location;
  String? lat;
  String? long;
  String? status;
  dynamic otp;
  String? profileStatus;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? phone;
  dynamic deletedAt;
  String? countryCode;

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
    this.countryCode,
  });

  factory Barber.fromJson(Map<String, dynamic> json) => Barber(
    id: json["id"],
    name: json["name"],
    type: cancelByValues.map[json["type"]],
    email: emailValues.map[json["email"]],
    image: json["image"],
    about: json["about"],
    location: locationValues.map[json["location"]],
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
    countryCode: json["country_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": cancelByValues.reverse[type],
    "email": emailValues.reverse[email],
    "image": image,
    "about": about,
    "location": locationValues.reverse[location],
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
    "country_code": countryCode,
  };
}

enum Email {
  IBRA11_GMAIL_COM,
  IMRAN78_GMAIL_COM,
  IMRAN_GMAIL_COM,
  MOAZ_BEAUTYCONNECT_COM
}

final emailValues = EnumValues({
  "ibra11@gmail.com": Email.IBRA11_GMAIL_COM,
  "imran78@gmail.com": Email.IMRAN78_GMAIL_COM,
  "imran@gmail.com": Email.IMRAN_GMAIL_COM,
  "moaz@beautyconnect.com": Email.MOAZ_BEAUTYCONNECT_COM
});

enum Location {
  FAISALABAD
}

final locationValues = EnumValues({
  "Faisalabad": Location.FAISALABAD
});

enum Name {
  IBRA,
  IMRAN,
  PAULO
}

final nameValues = EnumValues({
  "ibra": Name.IBRA,
  "imran": Name.IMRAN,
  "PAULO": Name.PAULO
});

enum CancelBy {
  BARBER,
  USER
}

final cancelByValues = EnumValues({
  "barber": CancelBy.BARBER,
  "user": CancelBy.USER
});

class GuestUser {
  int? id;
  String? username;
  String? email;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? description;

  GuestUser({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  factory GuestUser.fromJson(Map<String, dynamic> json) => GuestUser(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "phone": phone,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "description": description,
  };
}

enum PaymentStatus {
  PENDING
}

final paymentStatusValues = EnumValues({
  "pending": PaymentStatus.PENDING
});

class Service {
  int? id;
  int? bookingId;
  int? serviceChargeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? serviceId;
  List<UserService>? userServices;

  Service({
    this.id,
    this.bookingId,
    this.serviceChargeId,
    this.createdAt,
    this.updatedAt,
    this.serviceId,
    this.userServices,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    bookingId: json["booking_id"],
    serviceChargeId: json["service_charge_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    serviceId: json["service_id"],
    userServices: json["user_services"] == null ? [] : List<UserService>.from(json["user_services"]!.map((x) => UserService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "service_charge_id": serviceChargeId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "service_id": serviceId,
    "user_services": userServices == null ? [] : List<dynamic>.from(userServices!.map((x) => x.toJson())),
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
    name: json["name"],
    image: json["image"],
    time: json["time"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    frenchName: json["french_name"],
    portugueseName: json["portuguese_name"],

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

enum Type {
  GUEST,
  USER
}

final typeValues = EnumValues({
  "Guest": Type.GUEST,
  "User": Type.USER
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
