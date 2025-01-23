class CreatedBookingModel {
  int? userId;
  String? barberId;
  DateTime? date;
  String? time;
  String? paymentStatus;
  int? totalAmount;
  int? totalTime;
  String? startTime;
  String? endTime;
  String? status;
  String? type;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  List<Service>? services;

  CreatedBookingModel({
    this.userId,
    this.barberId,
    this.date,
    this.time,
    this.paymentStatus,
    this.totalAmount,
    this.totalTime,
    this.startTime,
    this.endTime,
    this.status,
    this.type,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.services,
  });

  factory CreatedBookingModel.fromJson(Map<String, dynamic> json) => CreatedBookingModel(
    userId: json["user_id"],
    barberId: json["barber_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    paymentStatus: json["payment_status"],
    totalAmount: json["total_amount"],
    totalTime: json["total_time"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    status: json["status"],
    type: json["type"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "barber_id": barberId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "payment_status": paymentStatus,
    "total_amount": totalAmount,
    "total_time": totalTime,
    "start_time": startTime,
    "end_time": endTime,
    "status": status,
    "type": type,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
  };
}

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
  String? frenchName;
  String? portugueseName;
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
    this.frenchName,
    this.portugueseName
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
