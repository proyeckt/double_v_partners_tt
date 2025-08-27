import 'package:double_v_partners_tt/domain/models/user_model.dart';
import 'package:double_v_partners_tt/domain/usecases/user_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_cubit.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(User user) = _Loaded;
  const factory UserState.error(String message) = _Error;
  const factory UserState.unauthenticated() = _Unauthenticated;
}

@injectable
class UserCubit extends Cubit<UserState> {
  final UserUseCases _useCases;

  UserCubit(this._useCases) : super(const UserState.initial()) {
    init();
  }

  Future<void> init() async {
    final activeUser = await _useCases.getActiveUser();
    if (activeUser != null) {
      emit(UserState.loaded(activeUser));
      return;
    }
    emit(const UserState.unauthenticated());
  }

  Future<void> loadUser(String email) async {
    emit(const UserState.loading());
    try {
      final user = await _useCases.getUser(email);
      emit(user != null ? UserState.loaded(user) : const UserState.initial());
    } catch (e) {
      emit(UserState.error('Failed to load user: $e'));
    }
  }

  Future<void> register(User user) async {
    emit(const UserState.loading());
    try {
      await _useCases.saveUser(user);
      emit(UserState.loaded(user));
    } catch (e) {
      emit(UserState.error('Registration failed: $e'));
    }
  }

  Future<void> login(String email, String password) async {
    emit(const UserState.loading());
    try {
      final user = await _useCases.loginUser(email, password);
      if (user != null) {
        await _useCases.saveUser(user);
        emit(UserState.loaded(user));
      } else {
        emit(const UserState.error("Invalid email or password"));
      }
    } catch (e) {
      emit(UserState.error('Login failed: $e'));
    }
  }

  Future<void> logout() async {
    await _useCases.clearActiveUser();
    emit(const UserState.unauthenticated());
  }

  User? get currentUser {
    final activeUser = _useCases.getActiveUser();
    return activeUser as User?;
  }
}
