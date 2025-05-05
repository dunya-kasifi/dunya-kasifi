import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import '../controllers/route_controller.dart';

class GameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(() => GameController());
    Get.lazyPut<RouteController>(() => RouteController());
  }
}
