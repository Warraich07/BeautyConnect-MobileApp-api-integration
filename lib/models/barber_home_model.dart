class BarberHomeModel {
  int id;
  int? userId;
  int barberId;
  DateTime date;
  String? time;
  String startTime;
  String endTime;
  PaymentStatus paymentStatus;
  String totalAmount;
  Status status;
  String? reason;
  DateTime createdAt;
  DateTime updatedAt;
  String totalTime;
  BarberHomeModelType type;
  int? guestId;
  String? ticket;
  dynamic cancelBy;
  List<Service> services;
  Barber? getUser;
  Barber barber;
  GuestUser? guestUser;

  BarberHomeModel({
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
    required this.services,
    required this.getUser,
    required this.barber,
    required this.guestUser,
  });

  factory BarberHomeModel.fromJson(Map<String, dynamic> json) => BarberHomeModel(
    id: json["id"],
    userId: json["user_id"],
    barberId: json["barber_id"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    paymentStatus: paymentStatusValues.map[json["payment_status"]]!,
    totalAmount: json["total_amount"],
    status: statusValues.map[json["status"]]!,
    reason: json["reason"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    totalTime: json["total_time"],
    type: barberHomeModelTypeValues.map[json["type"]]!,
    guestId: json["guest_id"],
    ticket: json["ticket"],
    cancelBy: json["cancel_by"],
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    getUser: json["get_user"] == null ? null : Barber.fromJson(json["get_user"]),
    barber: Barber.fromJson(json["barber"]),
    guestUser: json["guest_user"] == null ? null : GuestUser.fromJson(json["guest_user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "barber_id": barberId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "start_time": startTime,
    "end_time": endTime,
    "payment_status": paymentStatusValues.reverse[paymentStatus],
    "total_amount": totalAmount,
    "status": statusValues.reverse[status],
    "reason": reason,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "total_time": totalTime,
    "type": barberHomeModelTypeValues.reverse[type],
    "guest_id": guestId,
    "ticket": ticket,
    "cancel_by": cancelBy,
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
    "get_user": getUser?.toJson(),
    "barber": barber.toJson(),
    "guest_user": guestUser?.toJson(),
  };
}

class Barber {
  int id;
  BarberName name;
  BarberType type;
  Email email;
  String image;
  About? about;
  Location? location;
  String? lat;
  String? long;
  String? status;
  String? otp;
  String profileStatus;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String? phone;
  dynamic deletedAt;
  String? countryCode;

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
  });

  factory Barber.fromJson(Map<String, dynamic> json) => Barber(
    id: json["id"],
    name: barberNameValues.map[json["name"]]!,
    type: barberTypeValues.map[json["type"]]!,
    email: emailValues.map[json["email"]]!,
    image: json["image"],
    about: aboutValues.map[json["about"]]!,
    location: locationValues.map[json["location"]]!,
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": barberNameValues.reverse[name],
    "type": barberTypeValues.reverse[type],
    "email": emailValues.reverse[email],
    "image": image,
    "about": aboutValues.reverse[about],
    "location": locationValues.reverse[location],
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

enum About {
  HI
}

final aboutValues = EnumValues({
  "hi": About.HI
});

enum Email {
  MARYUMAKHTER35_GMAIL_COM,
  ONAEEM002_GMAIL_COM,
  TAHA22_GMAIL_COM,
  TAHA77_GMAIL_COM,
  TALHAWARRAICH878_GMAIL_COM,
  TALI19_GMAIL_COM,
  TALI99_GMAIL_COM
}

final emailValues = EnumValues({
  "maryumakhter35@gmail.com": Email.MARYUMAKHTER35_GMAIL_COM,
  "onaeem002@gmail.com": Email.ONAEEM002_GMAIL_COM,
  "taha22@gmail.com": Email.TAHA22_GMAIL_COM,
  "taha77@gmail.com": Email.TAHA77_GMAIL_COM,
  "talhawarraich878@gmail.com": Email.TALHAWARRAICH878_GMAIL_COM,
  "tali19@gmail.com": Email.TALI19_GMAIL_COM,
  "tali99@gmail.com": Email.TALI99_GMAIL_COM
});

enum Location {
  MULTAN
}

final locationValues = EnumValues({
  "multan": Location.MULTAN
});

enum BarberName {
  ARSLAN,
  MARYUM,
  NAME_TAHA,
  NAME_TALHA,
  TAHA,
  TALHA,
  TALHAA
}

final barberNameValues = EnumValues({
  "Arslan": BarberName.ARSLAN,
  "Maryum": BarberName.MARYUM,
  "taha": BarberName.NAME_TAHA,
  "talha": BarberName.NAME_TALHA,
  "Taha": BarberName.TAHA,
  "Talha": BarberName.TALHA,
  "talhaa": BarberName.TALHAA
});

enum BarberType {
  BARBER,
  USER
}

final barberTypeValues = EnumValues({
  "barber": BarberType.BARBER,
  "user": BarberType.USER
});

class GuestUser {
  int id;
  String username;
  String email;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  String? description;

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

enum PaymentStatus {
  PENDING
}

final paymentStatusValues = EnumValues({
  "pending": PaymentStatus.PENDING
});

class Service {
  int id;
  int bookingId;
  int? serviceChargeId;
  DateTime createdAt;
  DateTime updatedAt;
  int serviceId;
  List<UserService> userServices;

  Service({
    required this.id,
    required this.bookingId,
    required this.serviceChargeId,
    required this.createdAt,
    required this.updatedAt,
    required this.serviceId,
    required this.userServices,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    bookingId: json["booking_id"],
    serviceChargeId: json["service_charge_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    serviceId: json["service_id"],
    userServices: List<UserService>.from(json["user_services"].map((x) => UserService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "service_charge_id": serviceChargeId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "service_id": serviceId,
    "user_services": List<dynamic>.from(userServices.map((x) => x.toJson())),
  };
}

class UserService {
  int id;
  UserServiceName name;
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
  });

  factory UserService.fromJson(Map<String, dynamic> json) => UserService(
    id: json["id"],
    name: userServiceNameValues.map[json["name"]]!,
    image: json["image"],
    time: json["time"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": userServiceNameValues.reverse[name],
    "image": image,
    "time": time,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum UserServiceName {
  APARAR_BARBA_CONTORNO_TRATAMENTO,
  CONTORNO_BARBA,
  CORTE_CRIANA,
  CORTE_HOMEM
}

final userServiceNameValues = EnumValues({
  "Aparar barba + contorno + tratamento": UserServiceName.APARAR_BARBA_CONTORNO_TRATAMENTO,
  "Contorno barba": UserServiceName.CONTORNO_BARBA,
  "Corte criança": UserServiceName.CORTE_CRIANA,
  "Corte homem": UserServiceName.CORTE_HOMEM
});

enum Status {
  ABSENT,
  CANCEL,
  COMPLETED,
  IN_PROGRESS
}

final statusValues = EnumValues({
  "absent": Status.ABSENT,
  "cancel": Status.CANCEL,
  "completed": Status.COMPLETED,
  "in_progress": Status.IN_PROGRESS
});

enum BarberHomeModelType {
  GUEST,
  USER
}

final barberHomeModelTypeValues = EnumValues({
  "Guest": BarberHomeModelType.GUEST,
  "User": BarberHomeModelType.USER
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
