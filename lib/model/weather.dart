import 'dart:convert';

List<Weather> weatherFromJson(List<dynamic> data) => List<Weather>.from(data.map((x) => Weather.fromJson(x)));

String weatherToJson(List<Weather> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Weather {
  Weather({
    this.temperature,
    this.windSpeed,
    this.status,
    this.id,
    this.locationId,
    this.date,
    this.humidity,
  });

  final int? temperature;
  final int? windSpeed;
  final String? status;
  final int? id;
  final int? locationId;
  final DateTime? date;
  final int? humidity;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    temperature: json["temperature"],
    windSpeed: json["wind_speed"],
    status: json["status"],
    id: json["id"],
    locationId: json["location_id"],
    date: DateTime.parse(json["date"]),
    humidity: json["humidity"],
  );

  Map<String, dynamic> toJson() => {
    "temperature": temperature,
    "wind_speed": windSpeed,
    "status": status,
    "id": id,
    "location_id": locationId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "humidity": humidity,
  };
}