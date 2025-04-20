import 'package:get/get.dart';

class OnboardingController extends GetxController {
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

  // Araç seçimi
  final RxInt selectedVehicleIndex = 0.obs;
  final List<String> vehicleNames = [
    'Sihirli Halı',
    'Küçük Uçak',
    'Roket',
    'Sıcak Hava Balonu'
  ];

  // İmza durumu
  final RxBool isSignatureComplete = false.obs;

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
  void updateVehicleSelection(int index) {
    selectedVehicleIndex.value = index;
  }

  // İmza durumunu güncelle
  void updateSignatureStatus(bool status) {
    isSignatureComplete.value = status;
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

  // Onboarding tamamlandı mı kontrol et
  bool isOnboardingComplete() {
    return selectedAvatarIndex.value >= 0 &&
        selectedEquipment.any((element) => element) &&
        selectedVehicleIndex.value >= 0 &&
        isSignatureComplete.value;
  }
}
