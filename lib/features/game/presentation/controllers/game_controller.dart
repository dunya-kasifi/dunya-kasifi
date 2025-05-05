import 'package:get/get.dart';

class GameController extends GetxController {
  final isARMode = false.obs;

  void toggleARMode() {
    isARMode.value = !isARMode.value;
  }
}
