import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart' as rive;

import 'package:double_v_partners_tt/utils/colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: rive.RiveAnimation.asset(
                    'assets/riv/breathing_animation_edited.riv',
                    fit: BoxFit.fill,
                  ),
                ),
                buildScreen(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 220,
            child: rive.RiveAnimation.asset(
              'assets/riv/cute_dog_typing_anim.riv',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          const Text(
            'Welcome to Double V Partners',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            'Get started by logging in or creating an account.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(12.0),
                foregroundColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () => context.push('/login'),
              child: const Text('Login'),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(12),
                foregroundColor: Colors.white.withAlpha(235),
                backgroundColor: AppColors.secondaryColor,
              ),
              onPressed: () => context.push('/register'),
              child: const Text('Register'),
            ),
          ),
          const SizedBox(height: 20),
          buildCreditsText('Developed by Edwin Alejandro Turizo Prieto'),
          buildCreditsText(
            'Credits to animoox.com for "Cute Dog Typing" — Rive (CC)',
          ),
        ],
      ),
    );
  }

  Widget buildCreditsText(String text) => Text(
    text,
    textAlign: TextAlign.start,
    style: const TextStyle(fontSize: 11, color: Colors.black38),
  );
}
