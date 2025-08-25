import 'package:double_v_partners_tt/utils/colors.dart';
import 'package:double_v_partners_tt/utils/routes.dart';
import 'package:double_v_partners_tt/utils/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Double V Partners Test',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
