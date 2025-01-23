class NotificationsModel {
  String image;
  String title;
  String desc;
  String time;

  NotificationsModel({
    required this.image,
    required this.title,
    required this.desc,
    required this.time,
  });
}

List<NotificationsModel> notificationsUser = [
  NotificationsModel(
    image: "assets/images/barber1.png",
    title: "Jane Cooper",
    desc: "has completed your appointment.",
    time: "06:00 PM",
  ),
  NotificationsModel(
      image: "assets/images/barber2.png",
      title: "Darrell Steward",
      desc: "has conformed your appointment.",
      time: "02:00 PM"),
  NotificationsModel(
      image: "assets/images/mastercard_white.png",
      title: "",
      desc: "You have added MasterCard as you payment method",
      time: "12:00 PM"),
];
List<NotificationsModel> notificationsBarber = [
  NotificationsModel(
    image: "assets/images/cameron.png",
    title: "Cameron Williamson",
    desc: "has confirmed completion of appointment and left 5 star Feedback",
    time: "06:00 PM",
  ),
  NotificationsModel(
      image: "assets/images/cameron.png",
      title: "Cameron Williamson",
      desc: " has booked appointment.",
      time: "02:00 PM"),
  NotificationsModel(
      image: "assets/images/mastercard_white.png",
      title: "",
      desc: "You have added MasterCard as you payment method",
      time: "12:00 PM"),
];
