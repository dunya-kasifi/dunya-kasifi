import 'package:latlong2/latlong.dart';

class RoutePoint {
  final LatLng location;
  final String name;
  final String description;
  final List<String> missions;
  final bool isCompleted;

  const RoutePoint({
    required this.location,
    required this.name,
    required this.description,
    required this.missions,
    this.isCompleted = false,
  });

  RoutePoint copyWith({
    LatLng? location,
    String? name,
    String? description,
    List<String>? missions,
    bool? isCompleted,
  }) {
    return RoutePoint(
      location: location ?? this.location,
      name: name ?? this.name,
      description: description ?? this.description,
      missions: missions ?? this.missions,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
