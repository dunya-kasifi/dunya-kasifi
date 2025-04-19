import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class ARView extends ConsumerStatefulWidget {
  const ARView({super.key});

  @override
  ConsumerState<ARView> createState() => _ARViewState();
}

class _ARViewState extends ConsumerState<ARView> {
  ARKitController? arController;

  @override
  void dispose() {
    arController?.dispose();
    super.dispose();
  }

  void _onARKitViewCreated(ARKitController controller) {
    arController = controller;
    _addSphere(controller);
  }

  void _addSphere(ARKitController controller) {
    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty.color(Colors.blue),
    );
    final sphere = ARKitSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ARKitNode(
      geometry: sphere,
      position: Vector3(0, 0, -0.5),
    );
    controller.add(node);
  }

  @override
  Widget build(BuildContext context) {
    return ARKitSceneView(
      onARKitViewCreated: _onARKitViewCreated,
      enableTapRecognizer: true,
    );
  }
}
