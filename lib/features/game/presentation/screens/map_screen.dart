import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../providers/route_provider.dart';
import '../../domain/models/route_point.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  bool _isPlanningRoute = false;
  int? _selectedPointIndex;

  @override
  Widget build(BuildContext context) {
    final routePoints = ref.watch(routeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Uçuş Rotası'),
        actions: [
          IconButton(
            icon: Icon(_isPlanningRoute ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                _isPlanningRoute = !_isPlanningRoute;
                if (!_isPlanningRoute) {
                  _showMissionDetails(context, routePoints);
                }
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(41.0082, 28.9784),
              initialZoom: 5,
              onTap: _isPlanningRoute ? _addRoutePoint : null,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.dunyakasifi.app',
              ),
              MarkerLayer(
                markers: routePoints.asMap().entries.map((entry) {
                  final index = entry.key;
                  final point = entry.value;
                  return Marker(
                    point: point.location,
                    child: GestureDetector(
                      onTap: () => _showPointDetails(context, index, point),
                      child: Icon(
                        Icons.location_on,
                        color: point.isCompleted ? Colors.green : Colors.red,
                        size: 32,
                      ),
                    ),
                  );
                }).toList(),
              ),
              PolylineLayer(
                polylines: [
                  if (routePoints.length > 1)
                    Polyline(
                      points:
                          routePoints.map((point) => point.location).toList(),
                      color: Colors.blue,
                      strokeWidth: 3,
                    ),
                ],
              ),
            ],
          ),
          if (_isPlanningRoute)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rota Planlaması',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Haritaya tıklayarak rotanızı belirleyin. Her nokta bir keşif durağıdır.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _RouteActionButton(
                            icon: Icons.undo,
                            label: 'Geri Al',
                            onTap: () {
                              if (routePoints.isNotEmpty) {
                                ref
                                    .read(routeProvider.notifier)
                                    .removePoint(routePoints.length - 1);
                              }
                            },
                          ),
                          _RouteActionButton(
                            icon: Icons.delete,
                            label: 'Temizle',
                            onTap: () {
                              ref.read(routeProvider.notifier).clearRoute();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _addRoutePoint(TapPosition position, LatLng point) {
    final newPoint = RoutePoint(
      location: point,
      name: 'Durak ${ref.read(routeProvider).length + 1}',
      description: 'Burada keşfedilecek harika şeyler var!',
      missions: [
        'Yerel kültürü keşfet',
        'Önemli yapıları bul',
        'Yöresel yemekleri tat',
      ],
    );
    ref.read(routeProvider.notifier).addPoint(newPoint);
  }

  void _showPointDetails(BuildContext context, int index, RoutePoint point) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              point.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(point.description),
            const SizedBox(height: 16),
            Text(
              'Görevler:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...point.missions.asMap().entries.map((entry) {
              final missionIndex = entry.key;
              final mission = entry.value;
              return ListTile(
                leading: Icon(
                  mission.startsWith('✓')
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  color: mission.startsWith('✓') ? Colors.green : Colors.grey,
                ),
                title: Text(mission.replaceAll('✓ ', '')),
                onTap: () {
                  ref
                      .read(routeProvider.notifier)
                      .completeMission(index, missionIndex);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showMissionDetails(BuildContext context, List<RoutePoint> points) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rota Detayları'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Toplam Durak: ${points.length}'),
            const SizedBox(height: 8),
            Text(
                'Tamamlanan Görevler: ${points.where((p) => p.isCompleted).length}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}

class _RouteActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _RouteActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(height: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}
