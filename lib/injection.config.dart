// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:double_v_partners_tt/data/repositories/user_repository.dart'
    as _i386;
import 'package:double_v_partners_tt/domain/models/user_model.dart' as _i938;
import 'package:double_v_partners_tt/domain/modules/hive_module.dart' as _i36;
import 'package:double_v_partners_tt/domain/usecases/user_usecases.dart'
    as _i969;
import 'package:double_v_partners_tt/presentation/cubits/user_cubit.dart'
    as _i313;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final hiveModule = _$HiveModule();
    await gh.factoryAsync<_i979.Box<_i938.User>>(
      () => hiveModule.usersBox,
      preResolve: true,
    );
    await gh.factoryAsync<_i979.Box<String>>(
      () => hiveModule.sessionBox,
      preResolve: true,
    );
    gh.lazySingleton<_i386.UserRepository>(() => _i386.HiveUserRepository(
          gh<_i979.Box<_i938.User>>(),
          gh<_i979.Box<String>>(),
        ));
    gh.factory<_i969.UserUseCases>(
        () => _i969.UserUseCases(gh<_i386.UserRepository>()));
    gh.factory<_i313.UserCubit>(
        () => _i313.UserCubit(gh<_i969.UserUseCases>()));
    return this;
  }
}

class _$HiveModule extends _i36.HiveModule {}
