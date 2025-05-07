import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import '../controllers/route_controller.dart';

class MapScreen extends GetView<RouteController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient Arka Plan
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A237E).withAlpha(230),
                const Color(0xFF0D47A1).withAlpha(230),
              ],
            ),
          ),
        ),

        // Harita
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 80, // Üst bar için boşluk
              bottom: 112, // Alt bar için boşluk (80 + 32)
              left: 16,
              right: 16,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withAlpha(51),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: const LatLng(41.0082, 28.9784), // İstanbul
                    initialZoom: 5,
                    minZoom: 2,
                    maxZoom: 18,
                    onTap: (_, point) {
                      // TODO: Add route point
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.dunyakasifi.app',
                      tileProvider: NetworkTileProvider(),
                      backgroundColor: Colors.transparent,
                      tileBuilder: (context, tileWidget, tile) {
                        return tileWidget;
                      },
                    ),
                    MarkerLayer(
                      markers: [
                        // Örnek marker
                        Marker(
                          point: const LatLng(41.0082, 28.9784),
                          width: 40,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(25),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withAlpha(51),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
