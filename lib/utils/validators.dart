import 'package:double_v_partners_tt/extensions/string_extensions.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value.isNullOrEmpty) return 'Please enter your email';
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegExp.hasMatch(value!)) return 'Please enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value.isNullOrEmpty) return 'Please enter your password';
    if (value!.length < 6) return 'Must be at least 6 characters';
    return null;
  }
}
