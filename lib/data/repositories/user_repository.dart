import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:double_v_partners_tt/domain/models/user_model.dart';

abstract class UserRepository {
  Future<void> saveUser(User user);
  Future<User?> getUser(String email);
  Future<User?> loginUser(String email, String password);
  Future<void> saveActiveUser(String email);
  Future<User?> getActiveUser();
  Future<void> clearActiveUser();
}

@LazySingleton(as: UserRepository)
class HiveUserRepository implements UserRepository {
  final Box<User> _usersBox;
  final Box<String> _sessionBox;

  HiveUserRepository(this._usersBox, this._sessionBox);

  @override
  Future<void> saveUser(User user) async {
    await _usersBox.put(user.email, user);
  }

  @override
  Future<User?> getUser(String email) async {
    return _usersBox.get(email);
  }

  @override
  Future<User?> loginUser(String email, String password) async {
    final user = _usersBox.get(email);
    if (user == null) return null;

    // Check credentials
    if (user.password == password) {
      return user;
    }
    return null; // invalid credentials
  }

  List<User> getAllUsers() {
    return _usersBox.values.toList();
  }

  @override
  Future<void> saveActiveUser(String email) async {
    await _sessionBox.put('activeEmail', email);
  }

  @override
  Future<User?> getActiveUser() async {
    final email = _sessionBox.get('activeEmail');
    return email != null ? _usersBox.get(email) : null;
  }

  @override
  Future<void> clearActiveUser() async {
    await _sessionBox.delete('activeEmail');
  }
}
