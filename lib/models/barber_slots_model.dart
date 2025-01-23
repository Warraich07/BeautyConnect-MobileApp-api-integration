class BarberSlots {
  String start;
  String end;

  BarberSlots({
    required this.start,
    required this.end,
  });

  factory BarberSlots.fromJson(Map<String, dynamic> json) => BarberSlots(
    start: json["start"],
    end: json["end"],
  );

  Map<String, dynamic> toJson() => {
    "start": start,
    "end": end,
  };
}
