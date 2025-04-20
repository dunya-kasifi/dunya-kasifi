import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnboardingController extends GetxController {
  // Sayfa kontrolü
  final RxInt currentPage = 0.obs;
  final PageController pageController = PageController();

  // Avatar seçimi
  final RxInt selectedAvatarIndex = 0.obs;
  final RxString selectedAvatarName = ''.obs;
  final List<String> avatarNames = [
    'Cesur Kaşif',
    'Bilge Gezgin',
    'Maceraperest',
    'Doğa Dostu',
    'Gizem Avcısı',
    'Yıldız Gezgini'
  ];

  // Ekipman seçimi
  final RxList<bool> selectedEquipment = List.generate(4, (index) => false).obs;
  final List<String> equipmentNames = [
    'Sihirli Pusula',
    'Not Defteri',
    'Fotoğraf Makinesi',
    'Sanal Dürbün'
  ];
  final List<Color> equipmentColors = [
    const Color(0xFFFF6B6B), // Kırmızı
    const Color(0xFF4ECDC4), // Turkuaz
    const Color(0xFFFFD166), // Sarı
    const Color(0xFF7E4AE5), // Mor
  ];

  // Araç seçimi
  final RxInt selectedVehicleIndex = 0.obs;
  final List<String> vehicleNames = [
    'Sihirli Halı',
    'Küçük Uçak',
    'Roket',
    'Sıcak Hava Balonu'
  ];
  final List<String> vehicleImages = [
    'assets/images/vehicles/1.jpeg',
    'assets/images/vehicles/2.jpeg',
    'assets/images/vehicles/3.jpeg',
    'assets/images/vehicles/4.jpeg',
  ];

  // İmza durumu
  final RxBool isSignatureComplete = false.obs;
  final RxList<Offset> signaturePoints = <Offset>[].obs;

  // Sayfa geçişleri
  void nextPage() {
    if (currentPage.value < 4) {
      pageController.nextPage(
        duration: 300.milliseconds,
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: 300.milliseconds,
        curve: Curves.easeInOut,
      );
    }
  }

  void updatePage(int index) {
    currentPage.value = index;
  }

  // Avatar seçimini güncelle
  void updateAvatarSelection(int index) {
    selectedAvatarIndex.value = index;
    selectedAvatarName.value = avatarNames[index];
  }

  // Ekipman seçimini güncelle
  void toggleEquipment(int index) {
    selectedEquipment[index] = !selectedEquipment[index];
  }

  // Araç seçimini güncelle
  void selectVehicle(int index) {
    selectedVehicleIndex.value = index;
  }

  // İmza işlemleri
  void startDrawing(Offset point) {
    signaturePoints.clear();
    signaturePoints.add(point);
  }

  void updateDrawing(Offset point) {
    signaturePoints.add(point);
  }

  void endDrawing() {
    if (signaturePoints.isNotEmpty) {
      isSignatureComplete.value = true;
    }
  }

  void clearSignature() {
    signaturePoints.clear();
    isSignatureComplete.value = false;
  }

  // Seçilen ekipmanların listesini getir
  List<String> getSelectedEquipmentNames() {
    return List.generate(4, (index) {
      if (selectedEquipment[index]) {
        return equipmentNames[index];
      }
      return '';
    }).where((name) => name.isNotEmpty).toList();
  }

  // Seçilen ekipmanların renklerini getir
  List<Color> getSelectedEquipmentColors() {
    return List.generate(4, (index) {
      if (selectedEquipment[index]) {
        return equipmentColors[index];
      }
      return Colors.transparent;
    }).where((color) => color != Colors.transparent).toList();
  }

  // Onboarding tamamlandı mı kontrol et
  bool isOnboardingComplete() {
    return selectedAvatarIndex.value >= 0 &&
        selectedEquipment.any((element) => element) &&
        selectedVehicleIndex.value >= 0 &&
        isSignatureComplete.value;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
