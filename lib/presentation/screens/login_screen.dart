import 'package:double_v_partners_tt/utils/colors.dart';
import 'package:double_v_partners_tt/utils/styles.dart';
import 'package:double_v_partners_tt/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Size size;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: Scaffold(
        body: Stack(
          children: <Widget>[_buildBackground(context), _buildForm(context)],
        ),
      ),
    );
  }

  Future<void> _onPopInvokedWithResult(bool didPop, dynamic result) async {
    if (didPop) return;
    FocusScope.of(context).unfocus();
  }

  Widget _buildBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final background = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const <Color>[
            AppColors.highGradientColor,
            AppColors.lowGradientColor,
          ],
        ),
      ),
    );

    final circle = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    return Stack(
      children: [
        background,
        Positioned(top: 90, left: 30, child: circle),
        Positioned(top: -40, right: -30, child: circle),
        Positioned(bottom: -50, right: -10, child: circle),
        Positioned(bottom: 120, right: 20, child: circle),
        Positioned(bottom: -50, left: -20, child: circle),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(child: Container(height: 250.0)),
          Container(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  offset: Offset(0.0, 0.05), //dx,dy
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Text('Sign In', style: Styles.headlineBlackStyle),
                    SizedBox(height: 20),
                    _buildEmailField(),
                    SizedBox(height: 10),
                    _buildPasswordField(),
                    SizedBox(height: 20),
                    _buildButton(),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            child: Text(
              '¿Nuevo usuario? Registrate',
              style: Styles.secondarySubtitleBold,
            ),
            onPressed: () => context.push('/register'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.alternate_email,
          color: Theme.of(context).primaryColor,
        ),
        errorStyle: Styles.errorStyle,
        labelText: 'Email',
        hintStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: Validators.validateEmail,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !showPassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          icon: Icon(
            showPassword ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColor,
          ),
        ),
        icon: Icon(Icons.lock_outline, color: Theme.of(context).primaryColor),
        errorStyle: Styles.errorStyle,
        labelText: 'Password',
        hintStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(color: Colors.black),
      ),
      validator: Validators.validatePassword,
    );
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        ),
        child: Text('Sign in', style: Styles.mainButton),
        onPressed: () {},
      ),
    );
  }

  Future<bool> _onWillPop() async {
    FocusScope.of(context).unfocus(); // Dismiss keyboard
    await Future.delayed(
      const Duration(milliseconds: 100),
    ); // Brief delay to ensure keyboard hides
    return true; // Allow pop
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
