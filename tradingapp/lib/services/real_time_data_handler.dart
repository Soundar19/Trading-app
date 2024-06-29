import 'package:flutter/services.dart';

class RealTimeDataHandler {
  static const MethodChannel _channel = MethodChannel('com.example.tradingapp/realtime');

  Future<void> startReceivingData() async {
    try {
      print('Invoking startReceivingData method...');
      await _channel.invokeMethod('startReceivingData');
      print('Method startReceivingData invoked successfully');
    } on PlatformException catch (e) {
      print("Failed to start receiving data: '${e.message}'.");
    }
  }
}
