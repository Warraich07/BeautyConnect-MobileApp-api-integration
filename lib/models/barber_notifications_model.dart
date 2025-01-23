class BarberNotificationsModel {
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

  BarberNotificationsModel({
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

  factory BarberNotificationsModel.fromJson(Map<String, dynamic> json) => BarberNotificationsModel(
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
    "type": barberNotificationsModelTypeValues.reverse[type],
    "message": messageValues.reverse[message],
    "sent_to": sentToValues.reverse[sentTo],
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
  PaymentStatus paymentStatus;
  String totalAmount;
  String status;
  dynamic reason;
  DateTime createdAt;
  DateTime updatedAt;
  String totalTime;
  BookingType type;
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
    paymentStatus: paymentStatusValues.map[json["payment_status"]]!,
    totalAmount: json["total_amount"],
    status: json["status"],
    reason: json["reason"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    totalTime: json["total_time"],
    type: bookingTypeValues.map[json["type"]]!,
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
    "payment_status": paymentStatusValues.reverse[paymentStatus],
    "total_amount": totalAmount,
    "status": statusValues.reverse[status],
    "reason": reason,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "total_time": totalTime,
    "type": bookingTypeValues.reverse[type],
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
  String? type;
  String? email;
  String image;
  String? about;
  String? location;
  String? lat;
  String? long;
  String status;
  String? otp;
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
     this.type,
     this.email,
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
    type: json["type"]==null?"":json["type"],
    email: json["email"]==null?'':json["email"],
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
    "name": nameValues.reverse[name],
    "type": userTypeValues.reverse[type],
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
    "phone": phoneValues.reverse[phone],
    "country_code": countryCode,
    "fcm_token": fcmToken,
  };
}

enum About {
  HI,
  TOMI
}

final aboutValues = EnumValues({
  "hi": About.HI,
  "tomi": About.TOMI
});

enum Email {
  MAXBAR_GMAIL_COM,
  NIKE_GMAIL_COM,
  ONAEEM002_GMAIL_COM,
  RAMOS_GMAIL_COM
}

final emailValues = EnumValues({
  "maxbar@gmail.com": Email.MAXBAR_GMAIL_COM,
  "nike@gmail.com": Email.NIKE_GMAIL_COM,
  "onaeem002@gmail.com": Email.ONAEEM002_GMAIL_COM,
  "ramos@gmail.com": Email.RAMOS_GMAIL_COM
});

enum Location {
  MULTAN
}

final locationValues = EnumValues({
  "multan": Location.MULTAN
});

enum Name {
  ARSLAN,
  MAXBARB,
  NIKE,
  RAMOS
}

final nameValues = EnumValues({
  "Arslan": Name.ARSLAN,
  "maxbarb": Name.MAXBARB,
  "nike": Name.NIKE,
  "ramos": Name.RAMOS
});

enum Phone {
  THE_34563265437,
  THE_35678963
}

final phoneValues = EnumValues({
  "34 563 265437": Phone.THE_34563265437,
  "35 67 89 63": Phone.THE_35678963
});

enum UserType {
  BARBER,
  USER
}

final userTypeValues = EnumValues({
  "barber": UserType.BARBER,
  "user": UserType.USER
});

enum PaymentStatus {
  PENDING
}

final paymentStatusValues = EnumValues({
  "pending": PaymentStatus.PENDING
});

enum Status {
  ABSENT
}

final statusValues = EnumValues({
  "absent": Status.ABSENT
});

enum BookingType {
  GUEST,
  USER
}

final bookingTypeValues = EnumValues({
  "Guest": BookingType.GUEST,
  "User": BookingType.USER
});

enum Message {
  HAS_BOOKED_AN_APPOINTMENT
}

final messageValues = EnumValues({
  " has booked an appointment.": Message.HAS_BOOKED_AN_APPOINTMENT
});

enum SentTo {
  BARBER
}

final sentToValues = EnumValues({
  "Barber": SentTo.BARBER
});

enum BarberNotificationsModelType {
  APPOINTMENT_REQUEST
}

final barberNotificationsModelTypeValues = EnumValues({
  "Appointment Request": BarberNotificationsModelType.APPOINTMENT_REQUEST
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
