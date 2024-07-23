import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ZoomCube extends StatefulWidget {
  const ZoomCube({super.key});

  @override
  State<ZoomCube> createState() => _ZoomCubeState();
}

class _ZoomCubeState extends State<ZoomCube> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController? _unityWidgetController;
  double _sliderValue = 0.0;
  double _baseSizeValue = 1.0; // Tamanho base
  double _currentSizeValue = 1.0; // Tamanho atual, atualizado pelo gesto

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Unity Flutter Demo'),
        ),
        body: Card(
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              GestureDetector(
                onScaleUpdate: (ScaleUpdateDetails details) {
                  setState(() {
                    _currentSizeValue = _baseSizeValue * details.scale;
                  });
                  print("Current Size: $_currentSizeValue");
                  setSize(_currentSizeValue.toString());
                },
                onScaleEnd: (ScaleEndDetails details) {
                  setState(() {
                    _baseSizeValue = _currentSizeValue;
                  });
                },
                child: UnityWidget(
                  onUnityCreated: onUnityCreated,
                  onUnityMessage: onUnityMessage,
                  onUnitySceneLoaded: onUnitySceneLoaded,
                  fullscreen: true,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Rotation speed:"),
                      ),
                      Slider(
                        onChanged: (value) {
                          setState(() {
                            _sliderValue = value;
                          });
                          setRotationSpeed(value.toString());
                        },
                        value: _sliderValue,
                        min: 0,
                        max: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  // Communication from Flutter to Unity
  void setRotationSpeed(String speed) {
    _unityWidgetController?.postMessage('Controller', 'SetRotationSpeed', speed);
  }

  void setSize(String size) {
    _unityWidgetController?.postMessage('Controller', 'SetSize', size);
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    print('Mensagem recebida da unidade: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded? sceneInfo) {
    if (sceneInfo != null) {
      print('Cena recebida carregada da unidade: ${sceneInfo.name}');
      print(
          'Cena recebida carregada da unidade buildIndex: ${sceneInfo.buildIndex}');
    }
  }
}
