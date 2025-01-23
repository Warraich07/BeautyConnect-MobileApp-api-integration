class UserNotificationsModel {
  int id;
  int userId;
  int bookingId;
  String type;
  String message;
  String sentTo;
  int isSeen;
  DateTime createdAt;
  DateTime updatedAt;
  int isFeedback;
  User user;
  Booking booking;

  UserNotificationsModel({
    required this.id,
    required this.userId,
    required this.bookingId,
    required this.type,
    required this.message,
    required this.sentTo,
    required this.isSeen,
    required this.createdAt,
    required this.updatedAt,
    required this.isFeedback,
    required this.user,
    required this.booking,
  });

  factory UserNotificationsModel.fromJson(Map<String, dynamic> json) => UserNotificationsModel(
    id: json["id"],
    userId: json["user_id"],
    bookingId: json["booking_id"],
    type: json["type"],
    message: json["message"],
    sentTo: json["sent_to"],
    isSeen: json["is_seen"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isFeedback: json["is_feedback"],
    user: User.fromJson(json["user"]),
    booking: Booking.fromJson(json["booking"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "booking_id": bookingId,
    "type": type,
    "message": message,
    "sent_to": sentTo,
    "is_seen": isSeen,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_feedback": isFeedback,
    "user": user.toJson(),
    "booking": booking.toJson(),
  };
}

class Booking {
  int id;
  int? userId;
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
  int? guestId;
  String? ticket;
  dynamic cancelBy;
  int? guestUserId;
  User barber;
  User? getUser;

  Booking({
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
    required this.barber,
    required this.getUser,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
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
    barber: User.fromJson(json["barber"]),
    getUser: json["get_user"] == null ? null : User.fromJson(json["get_user"]),
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
    "barber": barber.toJson(),
    "get_user": getUser?.toJson(),
  };
}

class User {
  int id;
  String name;
  Type type;
  String email;
  String image;
  String? about;
  String? location;
  String? lat;
  String? long;
  String status;
  dynamic otp;
  String profileStatus;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String? phone;
  String? countryCode;
  String fcmToken;

  User({
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
    required this.countryCode,
    required this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    type: typeValues.map[json["type"]]!,
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
    countryCode: json["country_code"],
    fcmToken: json["fcm_token"]==null?'':json["fcm_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": typeValues.reverse[type],
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
    "country_code": countryCode,
    "fcm_token": fcmToken,
  };
}

enum Type {
  BARBER,
  USER
}

final typeValues = EnumValues({
  "barber": Type.BARBER,
  "user": Type.USER
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
