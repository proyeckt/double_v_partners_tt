// user_usecases.dart
import 'package:double_v_partners_tt/data/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:double_v_partners_tt/domain/models/user_model.dart';

@injectable
class UserUseCases {
  final UserRepository _repository;

  UserUseCases(this._repository);

  Future<void> saveUser(User user) => _repository.saveUser(user);
  Future<User?> getUser(String email) => _repository.getUser(email);
  Future<User?> loginUser(String email, String password) =>
      _repository.loginUser(email, password);
  Future<void> saveActiveUser(String email) =>
      _repository.saveActiveUser(email);
  Future<User?> getActiveUser() => _repository.getActiveUser();
  Future<void> clearActiveUser() => _repository.clearActiveUser();
}
