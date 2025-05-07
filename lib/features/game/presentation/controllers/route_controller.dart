import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';

class MiniGame {
  final String name;
  final String description;
  final String type;

  MiniGame({
    required this.name,
    required this.description,
    required this.type,
  });
}

class GeographicDiscovery {
  final String arModelName;
  final String arModelDescription;
  final List<String> landmarks;

  GeographicDiscovery({
    required this.arModelName,
    required this.arModelDescription,
    required this.landmarks,
  });
}

class CulturalAdventure {
  final List<String> traditionalClothes;
  final List<String> localFoods;

  CulturalAdventure({
    required this.traditionalClothes,
    required this.localFoods,
  });
}

class LanguageActivity {
  final List<String> localPhrases;
  final List<String> localWords;

  LanguageActivity({
    required this.localPhrases,
    required this.localWords,
  });
}

class RoutePoint {
  final LatLng location;
  final String name;
  final String description;
  final String imagePath;
  final String gameRoute;
  final MiniGame miniGame;
  final GeographicDiscovery geographicDiscovery;
  final CulturalAdventure culturalAdventure;
  final LanguageActivity languageActivity;
  final RxBool isCompleted;

  RoutePoint({
    required this.location,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.gameRoute,
    required this.miniGame,
    required this.geographicDiscovery,
    required this.culturalAdventure,
    required this.languageActivity,
  }) : isCompleted = false.obs;
}

class RouteController extends GetxController {
  final routePoints = <RoutePoint>[].obs;
  final routeCoordinates = <LatLng>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeRoute();
    generateRouteCoordinates();
  }

  void initializeRoute() {
    routePoints.addAll([
      RoutePoint(
        location: const LatLng(41.0082, 28.9784), // İstanbul
        name: 'İstanbul Macerası',
        description: 'Boğazın sularında gizli hazineleri keşfet!',
        imagePath: 'assets/images/game_image.jpeg',
        gameRoute: '/games/istanbul-adventure',
        miniGame: MiniGame(
          name: 'Gökyüzü Matematik Yarışı',
          description:
              'Boğaz üzerinde uçarken mesafe ve hız hesaplamaları yap!',
          type: 'math',
        ),
        geographicDiscovery: GeographicDiscovery(
          arModelName: 'Ayasofya',
          arModelDescription: 'Ayasofya\'nın 3D modelini keşfet!',
          landmarks: [
            'Boğaz Köprüsü',
            'Galata Kulesi',
            'Topkapı Sarayı',
          ],
        ),
        culturalAdventure: CulturalAdventure(
          traditionalClothes: [
            'Osmanlı Kaftanı',
            'Fes',
            'Yemeni',
          ],
          localFoods: [
            'Boğaz\'da Balık Ekmek',
            'İstanbul Simidi',
            'Lokum',
          ],
        ),
        languageActivity: LanguageActivity(
          localPhrases: [
            'N\'aber?',
            'N\'oluyor?',
            'Eyvallah!',
          ],
          localWords: [
            'Kanka',
            'Abi',
            'Kardeşim',
          ],
        ),
      ),
      RoutePoint(
        location: const LatLng(38.4192, 27.1287), // İzmir
        name: 'İzmir\'in Gizemleri',
        description: 'Ege\'nin incisinde kayıp eşyaları bul!',
        imagePath: 'assets/images/game_image.jpeg',
        gameRoute: '/games/izmir-mysteries',
        miniGame: MiniGame(
          name: 'Hava Durumu Tahmincisi',
          description: 'İzmir\'in güneşli havasını tahmin et!',
          type: 'weather',
        ),
        geographicDiscovery: GeographicDiscovery(
          arModelName: 'Saat Kulesi',
          arModelDescription: 'İzmir Saat Kulesi\'nin 3D modelini keşfet!',
          landmarks: [
            'Kemeraltı',
            'Kordon',
            'Kadifekale',
          ],
        ),
        culturalAdventure: CulturalAdventure(
          traditionalClothes: [
            'Ege Yöresi Kıyafetleri',
            'Fes',
            'Yemeni',
          ],
          localFoods: [
            'Boyoz',
            'Kumru',
            'İzmir Köfte',
          ],
        ),
        languageActivity: LanguageActivity(
          localPhrases: [
            'N\'apıyon?',
            'Geliyon mu?',
            'Eyv!',
          ],
          localWords: [
            'Kanka',
            'Abi',
            'Kardeşim',
          ],
        ),
      ),
      RoutePoint(
        location: const LatLng(37.8560, 27.8416), // Aydın
        name: 'Aydın\'ın Sırları',
        description: 'Antik kentlerde gizli mesajları çöz!',
        imagePath: 'assets/images/game_image.jpeg',
        gameRoute: '/games/aydin-secrets',
        miniGame: MiniGame(
          name: 'Bulut Boyama Oyunu',
          description: 'Efes\'in gökyüzündeki bulutları boya!',
          type: 'drawing',
        ),
        geographicDiscovery: GeographicDiscovery(
          arModelName: 'Efes Antik Kenti',
          arModelDescription: 'Efes\'in 3D modelini keşfet!',
          landmarks: [
            'Didim',
            'Kuşadası',
            'Efes',
          ],
        ),
        culturalAdventure: CulturalAdventure(
          traditionalClothes: [
            'Ege Yöresi Kıyafetleri',
            'Fes',
            'Yemeni',
          ],
          localFoods: [
            'Çine Köfte',
            'Keşkek',
            'Kabak Çiçeği Dolması',
          ],
        ),
        languageActivity: LanguageActivity(
          localPhrases: [
            'N\'apıyon?',
            'Geliyon mu?',
            'Eyv!',
          ],
          localWords: [
            'Kanka',
            'Abi',
            'Kardeşim',
          ],
        ),
      ),
      RoutePoint(
        location: const LatLng(37.7765, 29.0864), // Denizli
        name: 'Denizli\'nin Hazineleri',
        description: 'Pamukkale\'de efsanevi hazineleri bul!',
        imagePath: 'assets/images/game_image.jpeg',
        gameRoute: '/games/denizli-treasures',
        miniGame: MiniGame(
          name: 'Telaffuz Oyunu',
          description: 'Denizli ağzıyla kelimeleri telaffuz et!',
          type: 'pronunciation',
        ),
        geographicDiscovery: GeographicDiscovery(
          arModelName: 'Pamukkale',
          arModelDescription: 'Pamukkale\'nin 3D modelini keşfet!',
          landmarks: [
            'Pamukkale',
            'Hierapolis',
            'Kleopatra Havuzu',
          ],
        ),
        culturalAdventure: CulturalAdventure(
          traditionalClothes: [
            'Ege Yöresi Kıyafetleri',
            'Fes',
            'Yemeni',
          ],
          localFoods: [
            'Denizli Kebap',
            'Şıra',
            'Kuzu Tandır',
          ],
        ),
        languageActivity: LanguageActivity(
          localPhrases: [
            'N\'apıyon?',
            'Geliyon mu?',
            'Eyv!',
          ],
          localWords: [
            'Kanka',
            'Abi',
            'Kardeşim',
          ],
        ),
      ),
      RoutePoint(
        location: const LatLng(39.9334, 32.8597), // Ankara
        name: 'Ankara\'nın Efsaneleri',
        description: 'Başkentin tarihi yapılarını keşfet!',
        imagePath: 'assets/images/game_image.jpeg',
        gameRoute: '/games/ankara-legends',
        miniGame: MiniGame(
          name: 'Gökyüzü Matematik Yarışı',
          description: 'Anıtkabir\'in yüksekliğini hesapla!',
          type: 'math',
        ),
        geographicDiscovery: GeographicDiscovery(
          arModelName: 'Anıtkabir',
          arModelDescription: 'Anıtkabir\'in 3D modelini keşfet!',
          landmarks: [
            'Anıtkabir',
            'Kızılay',
            'Ulus',
          ],
        ),
        culturalAdventure: CulturalAdventure(
          traditionalClothes: [
            'Ankara Yöresi Kıyafetleri',
            'Fes',
            'Yemeni',
          ],
          localFoods: [
            'Ankara Tava',
            'Beypazarı Kurusu',
            'Simit',
          ],
        ),
        languageActivity: LanguageActivity(
          localPhrases: [
            'N\'apıyon?',
            'Geliyon mu?',
            'Eyv!',
          ],
          localWords: [
            'Kanka',
            'Abi',
            'Kardeşim',
          ],
        ),
      ),
      RoutePoint(
        location: const LatLng(38.6810, 39.2264), // Elazığ
        name: 'Elazığ\'ın Efsaneleri',
        description: 'Harput\'un efsanevi hazinelerini bul!',
        imagePath: 'assets/images/game_image.jpeg',
        gameRoute: '/games/elazig-legends',
        miniGame: MiniGame(
          name: 'Hava Durumu Tahmincisi',
          description: 'Elazığ\'ın havasını tahmin et!',
          type: 'weather',
        ),
        geographicDiscovery: GeographicDiscovery(
          arModelName: 'Harput Kalesi',
          arModelDescription: 'Harput Kalesi\'nin 3D modelini keşfet!',
          landmarks: [
            'Harput Kalesi',
            'Keban Barajı',
            'Hazar Gölü',
          ],
        ),
        culturalAdventure: CulturalAdventure(
          traditionalClothes: [
            'Doğu Anadolu Kıyafetleri',
            'Fes',
            'Yemeni',
          ],
          localFoods: [
            'Çiğ Köfte',
            'İçli Köfte',
            'Kadayıf Dolması',
          ],
        ),
        languageActivity: LanguageActivity(
          localPhrases: [
            'N\'apıyon?',
            'Geliyon mu?',
            'Eyv!',
          ],
          localWords: [
            'Kanka',
            'Abi',
            'Kardeşim',
          ],
        ),
      ),
    ]);
  }

  void generateRouteCoordinates() {
    routeCoordinates.clear();

    // Ana noktalar arasına ara noktalar ekleyerek daha doğal bir rota oluştur
    for (int i = 0; i < routePoints.length - 1; i++) {
      final start = routePoints[i].location;
      final end = routePoints[i + 1].location;

      // Ana noktaları ekle
      routeCoordinates.add(start);

      // Ara noktaları ekle (Bézier eğrisi benzeri bir efekt için)
      final midPoint = LatLng(
        (start.latitude + end.latitude) / 2,
        (start.longitude + end.longitude) / 2,
      );

      // Rastgele sapma ekle (daha doğal görünüm için)
      final deviation = 0.5; // Sapma miktarı
      final randomOffset = LatLng(
        (midPoint.latitude + (Random().nextDouble() - 0.5) * deviation),
        (midPoint.longitude + (Random().nextDouble() - 0.5) * deviation),
      );

      routeCoordinates.add(randomOffset);
    }

    // Son noktayı ekle
    routeCoordinates.add(routePoints.last.location);
  }

  List<LatLng> getRouteCoordinates() {
    return routeCoordinates;
  }

  void addPoint(RoutePoint point) {
    routePoints.add(point);
    generateRouteCoordinates();
  }

  void removePoint(int index) {
    if (index >= 0 && index < routePoints.length) {
      routePoints.removeAt(index);
      generateRouteCoordinates();
    }
  }

  void clearRoute() {
    routePoints.clear();
    routeCoordinates.clear();
  }

  void completeMission(int pointIndex, String activityType) {
    if (pointIndex >= 0 && pointIndex < routePoints.length) {
      final point = routePoints[pointIndex];
      point.isCompleted.value = true;
    }
  }
}
