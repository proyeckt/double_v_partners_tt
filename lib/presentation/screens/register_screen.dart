import 'package:double_v_partners_tt/domain/models/user_model.dart';
import 'package:double_v_partners_tt/presentation/cubits/user_cubit.dart';
import 'package:double_v_partners_tt/utils/colors.dart';
import 'package:double_v_partners_tt/utils/styles.dart';
import 'package:double_v_partners_tt/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late Size size;

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: Scaffold(
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (user) => context.go('/home'),
              error: (message) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              },
            );
          },
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                _buildBackground(context),
                _buildForm(context, state),
              ],
            );
          },
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
    return Container(
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
  }

  Widget _buildForm(BuildContext context, UserState state) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SafeArea(child: Container(height: 20.0)),
            Container(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              width: size.width * 0.92,
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
                      Text('Sign up', style: Styles.headlineBlackStyle),
                      SizedBox(height: 20),
                      _buildFirstNameField(),
                      SizedBox(height: 10),
                      _buildLastNameField(),
                      SizedBox(height: 10),
                      _buildEmailField(),
                      SizedBox(height: 10),
                      _buildPasswordField(),
                      SizedBox(height: 10),
                      _buildBirthdate(),
                      SizedBox(height: 20),
                      state.maybeWhen(
                        loading: () => const CircularProgressIndicator(),
                        orElse: () => _buildButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              child: Text(
                'Already registered? Login',
                style: Styles.secondarySubtitleBold,
              ),
              onPressed: () => context.push('/login'),
            ),
          ],
        ),
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: Styles.errorStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: Styles.errorStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
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
        onPressed: _submit,
        child: Text('Sign up', style: Styles.mainButton),
      ),
    );
  }

  Widget _buildBirthdate() {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        icon: Icon(Icons.calendar_month, color: AppColors.primaryColor),
        enabled: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: Styles.errorStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        hintStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(color: Colors.black),
        labelText: 'Birth date',
        hintText: 'dd-mm-yyyy',
      ),
      validator: Validators.validateRequiredField,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final date = await _pickDate();

        if (date != null && mounted) {
          setState(() {
            _selectedDate = date;
            _dateController.text = DateFormat('dd-MM-yyyy').format(date);
          });
        }
      },
    );
  }

  Widget _buildFirstNameField() {
    return TextFormField(
      controller: _firstNameController,
      textCapitalization: TextCapitalization.words,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: Styles.errorStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        hintStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(color: Colors.black),
        icon: Icon(
          Icons.person_outlined,
          color: Theme.of(context).primaryColor,
        ),
        labelText: 'First name',
      ),
      validator: Validators.validateRequiredField,
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      controller: _lastNameController,
      textCapitalization: TextCapitalization.words,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: Styles.errorStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        hintStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(color: Colors.black),
        icon: Icon(
          Icons.person_outlined,
          color: Theme.of(context).primaryColor,
        ),
        labelText: 'Last name',
      ),
      validator: Validators.validateRequiredField,
    );
  }

  Future<DateTime?> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    return picked;
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<UserCubit>();
    FocusScope.of(context).unfocus();
    User user = User(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      birthdate: _selectedDate!,
    );
    await cubit.register(user);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
