import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/models/route_point.dart';

class RouteNotifier extends StateNotifier<List<RoutePoint>> {
  RouteNotifier() : super([]);

  void addPoint(RoutePoint point) {
    state = [...state, point];
  }

  void removePoint(int index) {
    state = List.from(state)..removeAt(index);
  }

  void updatePoint(int index, RoutePoint point) {
    state = List.from(state)..[index] = point;
  }

  void clearRoute() {
    state = [];
  }

  void completeMission(int pointIndex, int missionIndex) {
    final point = state[pointIndex];
    final updatedMissions = List<String>.from(point.missions);
    updatedMissions[missionIndex] = '✓ ${updatedMissions[missionIndex]}';

    state = List.from(state)
      ..[pointIndex] = point.copyWith(
        missions: updatedMissions,
        isCompleted:
            updatedMissions.every((mission) => mission.startsWith('✓')),
      );
  }
}

final routeProvider = StateNotifierProvider<RouteNotifier, List<RoutePoint>>(
  (ref) => RouteNotifier(),
);
