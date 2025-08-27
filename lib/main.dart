import 'package:double_v_partners_tt/utils/routes.dart';
import 'package:double_v_partners_tt/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;
import 'package:double_v_partners_tt/presentation/cubits/user_cubit.dart';
import 'package:double_v_partners_tt/domain/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter()); // Register the generated adapter
  final usersBox = await Hive.openBox<User>('usersBox');
  final sessionBox = await Hive.openBox<String>('sessionBox');
  await di.configureDependencies(usersBox: usersBox, sessionBox: sessionBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<UserCubit>(),
      child: MaterialApp.router(
        title: 'Double V Partners Test',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
