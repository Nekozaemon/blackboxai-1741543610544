import 'package:flutter/services.dart';

class BackendController {
  static const platform = MethodChannel('backend_channel');
  
  static Future<void> startBackend() async {
    try {
      await platform.invokeMethod('startBackend');
    } catch (e) {
      print("Error starting backend: $e");
    }
  }
}
