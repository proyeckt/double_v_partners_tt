import 'package:double_v_partners_tt/domain/models/user_model.dart';
import 'package:double_v_partners_tt/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies({
  required Box<User> usersBox,
  required Box<String> sessionBox,
}) async {
  await getIt.allReady();
  getIt.init();
}
