import 'package:app/features/battery/data/service/battery_service.dart';
import 'package:app/features/battery/domain/repo/i_battery_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IBatteryRepository)
class BatteryRepository implements IBatteryRepository {
  final BatteryService _batteryService;

  BatteryRepository(this._batteryService);

  @override
  Future<int> getBatteryLevel() {
    return _batteryService.getBatteryLevel();
  }
}
