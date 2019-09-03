
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'charades_game.dart';

// wait until `setPreferredOrientations` is done and start the app
void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(CharadesGameApp());
  });
}
