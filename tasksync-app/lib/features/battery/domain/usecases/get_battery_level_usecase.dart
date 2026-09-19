import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/battery/domain/repo/i_battery_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBatteryLevelUseCase {
  final IBatteryRepository _repository;

  GetBatteryLevelUseCase(this._repository);

  Future<Result<int>> call() async {
    try {
      final level = await _repository.getBatteryLevel();
      return Success(level);
    } on Failure catch (e) {
      return FailureResult(e);
    } catch (e) {
      return FailureResult(DeviceFailure('Failed to fetch battery level', e));
    }
  }
}
