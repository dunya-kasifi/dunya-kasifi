import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class RoutePoint {
  final LatLng location;
  final String name;
  final String description;
  final List<String> missions;
  final RxBool isCompleted;

  RoutePoint({
    required this.location,
    required this.name,
    required this.description,
    required this.missions,
  }) : isCompleted = false.obs;
}

class RouteController extends GetxController {
  final routePoints = <RoutePoint>[].obs;

  void addPoint(RoutePoint point) {
    routePoints.add(point);
  }

  void removePoint(int index) {
    if (index >= 0 && index < routePoints.length) {
      routePoints.removeAt(index);
    }
  }

  void clearRoute() {
    routePoints.clear();
  }

  void completeMission(int pointIndex, int missionIndex) {
    if (pointIndex >= 0 &&
        pointIndex < routePoints.length &&
        missionIndex >= 0 &&
        missionIndex < routePoints[pointIndex].missions.length) {
      final point = routePoints[pointIndex];
      final mission = point.missions[missionIndex];
      point.missions[missionIndex] = '✓ $mission';
      point.isCompleted.value = true;
    }
  }
}
