import 'package:dio/dio.dart';
import 'package:weather_app/services/locations_service.dart';

class LocationRepository {
  final LocationsAPI api;

  LocationRepository({required this.api});

  Future<Response> getLocations({String? id}) => api.getLocation(id: id);
}
