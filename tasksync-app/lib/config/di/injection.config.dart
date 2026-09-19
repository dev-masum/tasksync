// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../core/api/api_client.dart' as _i430;
import '../../core/api/interceptors/auth_interceptor.dart' as _i304;
import '../../core/api/interceptors/error_mapping_interceptor.dart' as _i724;
import '../../core/api/interceptors/logging_interceptor.dart' as _i188;
import '../../core/cubit/l10n_cubit.dart' as _i32;
import '../../core/cubit/theme_cubit.dart' as _i887;
import '../../core/storage/prefs.dart' as _i531;
import '../../core/storage/token_manager.dart' as _i689;
import '../../features/auth/data/repo/auth_repo.dart' as _i607;
import '../../features/auth/domain/repo/i_auth_repo.dart' as _i318;
import '../../features/auth/domain/usecases/check_auth_usecase.dart' as _i831;
import '../../features/auth/domain/usecases/get_profile_usecase.dart' as _i568;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i189;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/presentation/cubit/auth_check_cubit.dart' as _i33;
import '../../features/auth/presentation/cubit/login_cubit.dart' as _i69;
import '../../features/auth/presentation/cubit/login_form_cubit.dart' as _i860;
import '../../features/auth/presentation/cubit/profile_cubit.dart' as _i421;
import '../../features/auth/presentation/cubit/register_cubit.dart' as _i759;
import '../../features/auth/presentation/cubit/register_form_cubit.dart'
    as _i714;
import '../../features/battery/data/repo/battery_repo.dart' as _i1044;
import '../../features/battery/data/service/battery_service.dart' as _i605;
import '../../features/battery/domain/repo/i_battery_repo.dart' as _i214;
import '../../features/battery/domain/usecases/get_battery_level_usecase.dart'
    as _i598;
import '../../features/battery/presentation/cubit/battery_cubit.dart' as _i481;
import '../../features/task/data/repo/task_repo.dart' as _i285;
import '../../features/task/domain/repo/i_task_repo.dart' as _i895;
import '../../features/task/domain/usecases/create_task_usecase.dart' as _i292;
import '../../features/task/domain/usecases/delete_task_usecase.dart' as _i896;
import '../../features/task/domain/usecases/get_task_by_id_usecase.dart'
    as _i235;
import '../../features/task/domain/usecases/get_tasks_usecase.dart' as _i118;
import '../../features/task/domain/usecases/update_task_usecase.dart' as _i149;
import '../../features/task/presentation/cubit/task_action_cubit.dart'
    as _i1034;
import '../../features/task/presentation/cubit/task_detail_cubit.dart' as _i841;
import '../../features/task/presentation/cubit/task_form_cubit.dart' as _i438;
import '../../features/task/presentation/cubit/task_list_cubit.dart' as _i900;
import '../router/auth_state_notifier.dart' as _i12;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i860.LoginFormCubit>(() => _i860.LoginFormCubit());
    gh.factory<_i714.RegisterFormCubit>(() => _i714.RegisterFormCubit());
    gh.factory<_i438.TaskFormCubit>(() => _i438.TaskFormCubit());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i12.AuthStateNotifier>(() => _i12.AuthStateNotifier());
    gh.lazySingleton<_i724.ErrorMappingInterceptor>(
      () => _i724.ErrorMappingInterceptor(),
    );
    gh.lazySingleton<_i188.LoggingInterceptor>(
      () => _i188.LoggingInterceptor(),
    );
    gh.lazySingleton<_i605.BatteryService>(() => _i605.BatteryService());
    gh.lazySingleton<_i214.IBatteryRepository>(
      () => _i1044.BatteryRepository(gh<_i605.BatteryService>()),
    );
    gh.factory<_i598.GetBatteryLevelUseCase>(
      () => _i598.GetBatteryLevelUseCase(gh<_i214.IBatteryRepository>()),
    );
    gh.factory<_i481.BatteryCubit>(
      () => _i481.BatteryCubit(gh<_i598.GetBatteryLevelUseCase>()),
    );
    gh.lazySingleton<_i531.SharedPrefsStorage>(
      () => _i531.SharedPrefsStorage(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i32.L10nCubit>(
      () => _i32.L10nCubit(gh<_i531.SharedPrefsStorage>()),
    );
    gh.lazySingleton<_i887.ThemeCubit>(
      () => _i887.ThemeCubit(gh<_i531.SharedPrefsStorage>()),
    );
    gh.lazySingleton<_i689.TokenManager>(
      () => _i689.TokenManagerImpl(gh<_i531.SharedPrefsStorage>()),
    );
    gh.lazySingleton<_i304.AuthInterceptor>(
      () => _i304.AuthInterceptor(gh<_i689.TokenManager>()),
    );
    gh.lazySingleton<_i430.ApiClient>(
      () => _i430.ApiClient(
        gh<_i361.Dio>(),
        authInterceptor: gh<_i304.AuthInterceptor>(),
        loggingInterceptor: gh<_i188.LoggingInterceptor>(),
        errorMappingInterceptor: gh<_i724.ErrorMappingInterceptor>(),
      ),
    );
    gh.lazySingleton<_i895.ITaskRepository>(
      () => _i285.TaskRepository(apiClient: gh<_i430.ApiClient>()),
    );
    gh.lazySingleton<_i318.IAuthRepository>(
      () => _i607.AuthRepository(
        apiClient: gh<_i430.ApiClient>(),
        tokenManager: gh<_i689.TokenManager>(),
      ),
    );
    gh.factory<_i831.CheckAuthUseCase>(
      () => _i831.CheckAuthUseCase(gh<_i318.IAuthRepository>()),
    );
    gh.factory<_i568.GetProfileUseCase>(
      () => _i568.GetProfileUseCase(gh<_i318.IAuthRepository>()),
    );
    gh.factory<_i189.LoginUseCase>(
      () => _i189.LoginUseCase(gh<_i318.IAuthRepository>()),
    );
    gh.factory<_i48.LogoutUseCase>(
      () => _i48.LogoutUseCase(gh<_i318.IAuthRepository>()),
    );
    gh.factory<_i941.RegisterUseCase>(
      () => _i941.RegisterUseCase(gh<_i318.IAuthRepository>()),
    );
    gh.factory<_i292.CreateTaskUseCase>(
      () => _i292.CreateTaskUseCase(gh<_i895.ITaskRepository>()),
    );
    gh.factory<_i896.DeleteTaskUseCase>(
      () => _i896.DeleteTaskUseCase(gh<_i895.ITaskRepository>()),
    );
    gh.factory<_i235.GetTaskByIdUseCase>(
      () => _i235.GetTaskByIdUseCase(gh<_i895.ITaskRepository>()),
    );
    gh.factory<_i118.GetTasksUseCase>(
      () => _i118.GetTasksUseCase(gh<_i895.ITaskRepository>()),
    );
    gh.factory<_i149.UpdateTaskUseCase>(
      () => _i149.UpdateTaskUseCase(gh<_i895.ITaskRepository>()),
    );
    gh.factory<_i900.TaskListCubit>(
      () => _i900.TaskListCubit(
        gh<_i118.GetTasksUseCase>(),
        gh<_i149.UpdateTaskUseCase>(),
        gh<_i896.DeleteTaskUseCase>(),
      ),
    );
    gh.factory<_i33.AuthCheckCubit>(
      () => _i33.AuthCheckCubit(
        gh<_i831.CheckAuthUseCase>(),
        gh<_i48.LogoutUseCase>(),
      ),
    );
    gh.factory<_i69.LoginCubit>(
      () => _i69.LoginCubit(gh<_i189.LoginUseCase>()),
    );
    gh.factory<_i421.ProfileCubit>(
      () => _i421.ProfileCubit(gh<_i568.GetProfileUseCase>()),
    );
    gh.factory<_i759.RegisterCubit>(
      () => _i759.RegisterCubit(gh<_i941.RegisterUseCase>()),
    );
    gh.factory<_i841.TaskDetailCubit>(
      () => _i841.TaskDetailCubit(gh<_i235.GetTaskByIdUseCase>()),
    );
    gh.factory<_i1034.TaskActionCubit>(
      () => _i1034.TaskActionCubit(
        gh<_i292.CreateTaskUseCase>(),
        gh<_i149.UpdateTaskUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
