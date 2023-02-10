import 'dart:convert';

List<Location> locationFromJson(List<dynamic> data) => List<Location>.from(data.map((x) => Location.fromJson(x)));

String locationToJson(List<Location> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Location {
  Location({
    this.id,
    this.country,
    this.city,
  });

  final int? id;
  final String? country;
  final String? city;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    country: json["country"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country": country,
    "city": city,
  };
}