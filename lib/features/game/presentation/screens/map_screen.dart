import 'package:dunya_kasifi/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import '../controllers/route_controller.dart';
import '../../../mini_games/presentation/screens/cloud_painting_screen.dart';
import '../../../mini_games/presentation/screens/weather_prediction_screen.dart';
import '../../../mini_games/presentation/screens/sky_math_race_screen.dart';

class MapScreen extends GetView<RouteController> {
  const MapScreen({super.key});

  void _showBottomSheet(BuildContext context, RoutePoint point) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(point.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          point.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          point.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              // Mini Oyun
              _buildActivitySection(
                'Mini Oyun',
                point.miniGame.name,
                point.miniGame.description,
                Icons.games,
                () {
                  if (point.miniGame.name.contains('Bulut')) {
                    Get.to(() => const CloudPaintingScreen());
                  } else if (point.miniGame.name.contains('Hava')) {
                    Get.to(() => const WeatherPredictionScreen());
                  } else if (point.miniGame.name.contains('Matematik')) {
                    Get.to(() => const SkyMathRaceScreen());
                  }
                },
              ),
              const SizedBox(height: 16.0),
              // Coğrafi Keşifler
              _buildActivitySection(
                'Coğrafi Keşifler',
                point.geographicDiscovery.arModelName,
                point.geographicDiscovery.arModelDescription,
                Icons.explore,
                () {
                  // TODO: Navigate to AR view
                },
              ),
              const SizedBox(height: 16.0),
              // Kültürel Maceralar
              _buildActivitySection(
                'Kültürel Maceralar',
                'Geleneksel Kıyafetler ve Yemekler',
                '${point.culturalAdventure.traditionalClothes.first} ve ${point.culturalAdventure.localFoods.first}',
                Icons.celebration,
                () {
                  // TODO: Navigate to cultural activities
                },
              ),
              const SizedBox(height: 16.0),
              // Dil Öğrenme
              _buildActivitySection(
                'Dil Öğrenme',
                'Yerel Kelimeler ve Cümleler',
                point.languageActivity.localPhrases.first,
                Icons.language,
                () {
                  // TODO: Navigate to language activities
                },
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActivitySection(
    String title,
    String subtitle,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: title == 'Mini Oyun'
                  ? const EdgeInsets.all(0.0)
                  : const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: title == 'Mini Oyun'
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: _getGameIcon(subtitle),
                    )
                  : Icon(
                      icon,
                      color: AppColors.errorColor,
                      size: 24,
                    ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getGameIcon(String gameName) {
    String iconPath;
    if (gameName.contains('Matematik')) {
      iconPath = 'assets/images/game_icons/math.jpeg';
    } else if (gameName.contains('Hava')) {
      iconPath = 'assets/images/game_icons/weather.jpeg';
    } else if (gameName.contains('Bulut')) {
      iconPath = 'assets/images/game_icons/cloude.jpeg';
    } else if (gameName.contains('Telaffuz')) {
      iconPath = 'assets/images/game_icons/language.jpeg';
    } else {
      return Icon(
        Icons.games,
        color: AppColors.errorColor,
        size: 24,
      );
    }

    return Image.asset(
      iconPath,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  }

  Marker customMarker(BuildContext context, RoutePoint point) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(point.location.latitude + 0.50, point.location.longitude),
      rotate: true,
      child: GestureDetector(
        onTap: () => _showBottomSheet(context, point),
        child: Stack(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.errorColor,
              size: 80.0,
              shadows: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: AppColors.errorColor,
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 0,
              left: 0,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(point.imagePath),
                    fit: BoxFit.contain,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              top: 80,
              bottom: 112,
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
                    initialCenter: const LatLng(40.0, 34.0),
                    initialZoom: 6,
                    minZoom: 4,
                    maxZoom: 18,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.dunyakasifi.app',
                      tileProvider: NetworkTileProvider(),
                      backgroundColor: Colors.transparent,
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: controller.getRouteCoordinates(),
                          color: Colors.blue.withOpacity(0.7),
                          strokeWidth: 4,
                          borderColor: Colors.blue.withOpacity(0.3),
                          borderStrokeWidth: 6,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: controller.routePoints
                          .map((point) => customMarker(context, point))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // // Geri Butonu
        // Positioned(
        //   top: MediaQuery.of(context).padding.top + 16,
        //   left: 16,
        //   child: IconButton(
        //     icon: const Icon(Icons.arrow_back, color: Colors.white),
        //     onPressed: () => Get.back(),
        //     style: IconButton.styleFrom(
        //       backgroundColor: Colors.white.withAlpha(25),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
