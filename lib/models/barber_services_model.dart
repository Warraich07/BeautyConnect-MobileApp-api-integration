class Feedback {
  int? id;
  int? userId;
  int? barberId;
  String? rating;
  String? reason;
  String? feedback;
  DateTime? createdAt;
  DateTime? updatedAt;
  ServicesBarberModel? user;

  Feedback({
    this.id,
    this.userId,
    this.barberId,
    this.rating,
    this.reason,
    this.feedback,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    id: json["id"],
    userId: json["user_id"],
    barberId: json["barber_id"],
    rating: json["rating"],
    reason: json["reason"],
    feedback: json["feedback"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : ServicesBarberModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "barber_id": barberId,
    "rating": rating,
    "reason": reason,
    "feedback": feedback,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class ServicesBarberModel {
  int? id;
  String? name;
  String? type;
  String? email;
  String? image;
  String about;
  String? location;
  String? lat;
  String? long;
  String? status;
  String? otp;
  String? profileStatus;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? phone;
  String? countryCode;
  int? feedbackCount;
  List<WorkingDay>? workingDays;
  List<ServiceCharge> serviceCharges;
  List<Feedback>? feedback;

  ServicesBarberModel({
    this.id,
    this.name,
    this.type,
    this.email,
    this.image,
    required this.about,
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
    this.feedbackCount,
    this.workingDays,
    required this.serviceCharges,
    this.feedback,
  });

  factory ServicesBarberModel.fromJson(Map<String, dynamic> json) => ServicesBarberModel(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    email: json["email"],
    image: json["image"],
    about: json["about"]==null?'':json["about"],
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
    feedbackCount: json["feedbackCount"]==null?0:json["feedbackCount"],
    workingDays: json["working_days"] == null ? [] : List<WorkingDay>.from(json["working_days"]!.map((x) => WorkingDay.fromJson(x))),
    serviceCharges: json["service_charges"] == null ? [] : List<ServiceCharge>.from(json["service_charges"]!.map((x) => ServiceCharge.fromJson(x))),
    feedback: json["feedback"] == null ? [] : List<Feedback>.from(json["feedback"]!.map((x) => Feedback.fromJson(x))),
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
    "feedbackCount": feedbackCount,
    "working_days": workingDays == null ? [] : List<dynamic>.from(workingDays!.map((x) => x.toJson())),
    "service_charges": serviceCharges == null ? [] : List<dynamic>.from(serviceCharges!.map((x) => x.toJson())),
    "feedback": feedback == null ? [] : List<dynamic>.from(feedback!.map((x) => x.toJson())),
  };
}

class ServiceCharge {
  int? id;
  int? barberId;
  int? serviceId;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Service>? services;

  ServiceCharge({
    this.id,
    this.barberId,
    this.serviceId,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.services,
  });

  factory ServiceCharge.fromJson(Map<String, dynamic> json) => ServiceCharge(
    id: json["id"],
    barberId: json["barber_id"],
    serviceId: json["service_id"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "barber_id": barberId,
    "service_id": serviceId,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
  };
}

class Service {
  int? id;
  String? name;
  dynamic portugueseName;
  dynamic frenchName;
  String? image;
  String? time;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  Service({
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

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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

class WorkingDay {
  int? id;
  int? barberId;
  String? day;
  String? from;
  String? to;
  DateTime? createdAt;
  DateTime? updatedAt;

  WorkingDay({
    this.id,
    this.barberId,
    this.day,
    this.from,
    this.to,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) => WorkingDay(
    id: json["id"],
    barberId: json["barber_id"],
    day: json["day"],
    from: json["from"],
    to: json["to"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "barber_id": barberId,
    "day": day,
    "from": from,
    "to": to,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
