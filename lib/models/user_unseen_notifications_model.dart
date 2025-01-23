class UnseenNotificationsModel {
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

  UnseenNotificationsModel({
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
  });

  factory UnseenNotificationsModel.fromJson(Map<String, dynamic> json) => UnseenNotificationsModel(
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
  };
}
