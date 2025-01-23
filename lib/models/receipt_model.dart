class ReceiptModel {
  Booking? booking;
  List<dynamic>? feedback;

  ReceiptModel({
    this.booking,
    this.feedback,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => ReceiptModel(
    booking: json["booking"] == null ? null : Booking.fromJson(json["booking"]),
    feedback: json["feedback"] == null ? [] : List<dynamic>.from(json["feedback"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "booking": booking?.toJson(),
    "feedback": feedback == null ? [] : List<dynamic>.from(feedback!.map((x) => x)),
  };
}

class Booking {
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
  String? reason;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? totalTime;
  String? type;
  dynamic guestId;
  dynamic ticket;
  String? cancelBy;
  dynamic guestUserId;
  String? saloonName;
  String? saloonAddress;
  List<Service>? services;
  Barber? getUser;
  Barber? barber;
  dynamic guestUser;

  Booking({
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
    this.saloonName,
    this.saloonAddress,
    this.services,
    this.getUser,
    this.barber,
    this.guestUser,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    userId: json["user_id"],
    barberId: json["barber_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
    cancelBy: json["cancel_by"],
    guestUserId: json["guest_user_id"],
    saloonName: json["saloon_name"]??'',
    saloonAddress: json["saloon_address"],
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    getUser: json["get_user"] == null ? null : Barber.fromJson(json["get_user"]),
    barber: json["barber"] == null ? null : Barber.fromJson(json["barber"]),
    guestUser: json["guest_user"],
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
    "cancel_by": cancelBy,
    "guest_user_id": guestUserId,
    "saloon_name": saloonName,
    "saloon_address": saloonAddress,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "get_user": getUser?.toJson(),
    "barber": barber?.toJson(),
    "guest_user": guestUser,
  };
}

class Barber {
  int? id;
  String? name;
  String? type;
  String? email;
  String? image;
  dynamic about;
  dynamic location;
  dynamic lat;
  dynamic long;
  String? status;
  dynamic otp;
  String? profileStatus;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? phone;
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
    this.countryCode,
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
    countryCode: json["country_code"],
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
    "country_code": countryCode,
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
  dynamic price;
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
  dynamic portugueseName;
  dynamic frenchName;
  String? image;
  String? time;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserService({
    this.id,
    this.name,
    this.portugueseName,
    this.frenchName,
    this.image,
    this.time,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory UserService.fromJson(Map<String, dynamic> json) => UserService(
    id: json["id"],
    name: json["name"],
    portugueseName: json["portuguese_name"],
    frenchName: json["french_name"],
    image: json["image"],
    time: json["time"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "portuguese_name": portugueseName,
    "french_name": frenchName,
    "image": image,
    "time": time,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
