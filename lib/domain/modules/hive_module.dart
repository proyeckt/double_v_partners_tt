import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:double_v_partners_tt/domain/models/user_model.dart';

@module
abstract class HiveModule {
  @preResolve
  Future<Box<User>> get usersBox async => await Hive.openBox<User>('users');
  @preResolve
  Future<Box<String>> get sessionBox async =>
      await Hive.openBox<String>('session');
}
