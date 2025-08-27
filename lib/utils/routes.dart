import 'package:double_v_partners_tt/presentation/screens/home_screen.dart';
import 'package:double_v_partners_tt/presentation/screens/login_screen.dart';
import 'package:double_v_partners_tt/presentation/screens/onboarding_screen.dart';
import 'package:double_v_partners_tt/presentation/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
  ],
);
