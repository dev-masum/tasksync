import 'package:app/core/result/result.dart';
import 'package:app/features/battery/domain/usecases/get_battery_level_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'battery_state.dart';

@injectable
class BatteryCubit extends Cubit<BatteryState> {
  final GetBatteryLevelUseCase _getBatteryLevelUseCase;

  BatteryCubit(this._getBatteryLevelUseCase) : super(BatteryInitial());

  Future<void> fetchBatteryLevel() async {
    emit(BatteryLoading());
    final result = await _getBatteryLevelUseCase();

    switch (result) {
      case Success(:final data):
        emit(BatteryLoaded(data));
      case FailureResult(:final failure):
        emit(BatteryError(failure.message));
    }
  }
}
