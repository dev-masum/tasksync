import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BatteryService {
  static const _channel = MethodChannel('com.tasksync.app/battery');

  Future<int> getBatteryLevel() async {
    try {
      final int result = await _channel.invokeMethod('getBatteryLevel');
      return result;
    } on PlatformException catch (e) {
      throw Exception(e.message ?? 'Failed to get battery level.');
    }
  }
}
