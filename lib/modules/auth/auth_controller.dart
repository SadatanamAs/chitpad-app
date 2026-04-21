import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';
import '../../data/models/auth_models.dart';
import '../../data/repositories/auth_repository.dart';
import '../../app/providers/app_providers.dart';

class AuthController extends ChangeNotifier {
  final Ref ref;

  AuthController(this.ref);

  AuthRepository get _authRepo => ref.read(authRepositoryProvider);

  // Login fields
  String loginEmail = '';
  String loginPassword = '';
  String loginEmailError = '';
  String loginPasswordError = '';
  bool loginLoading = false;
  bool loginShowPassword = false;

  void toggleLoginShowPassword() {
    loginShowPassword = !loginShowPassword;
    notifyListeners();
  }

  void setLoginEmail(String val) {
    loginEmail = val;
    loginEmailError = '';
    notifyListeners();
  }

  void setLoginPassword(String val) {
    loginPassword = val;
    loginPasswordError = '';
    notifyListeners();
  }

  // Register fields
  String regUsername = '';
  String regEmail = '';
  String regPassword = '';
  String regUsernameError = '';
  String regEmailError = '';
  String regPasswordError = '';
  bool regLoading = false;
  bool regShowPassword = false;
  int regPasswordStrength = 0; // 0-4

  void toggleRegShowPassword() {
    regShowPassword = !regShowPassword;
    notifyListeners();
  }

  void setRegUsername(String val) {
    regUsername = val;
    regUsernameError = '';
    notifyListeners();
  }

  void setRegEmail(String val) {
    regEmail = val;
    regEmailError = '';
    notifyListeners();
  }

  void setRegPassword(String val) {
    regPassword = val;
    regPasswordError = '';
    updatePasswordStrength(val);
    notifyListeners();
  }

  // Forgot password
  String forgotEmail = '';
  String forgotEmailError = '';
  bool forgotLoading = false;
  bool forgotSent = false;

  void setForgotEmail(String val) {
    forgotEmail = val;
    forgotEmailError = '';
    notifyListeners();
  }

  // --- Validation ---

  bool _isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  void updatePasswordStrength(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) strength++;
    regPasswordStrength = strength;
  }

  String get passwordStrengthLabel {
    switch (regPasswordStrength) {
      case 0:
        return 'Enter a password';
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Strong';
      default:
        return '';
    }
  }

  // --- Login ---

  bool _validateLogin() {
    bool valid = true;
    loginEmailError = '';
    loginPasswordError = '';

    if (loginEmail.trim().isEmpty) {
      loginEmailError = 'Email is required';
      valid = false;
    } else if (!_isValidEmail(loginEmail.trim())) {
      loginEmailError = 'Please enter a valid email';
      valid = false;
    }

    if (loginPassword.isEmpty) {
      loginPasswordError = 'Password is required';
      valid = false;
    }

    notifyListeners();
    return valid;
  }

  Future<void> doLogin() async {
    if (!_validateLogin()) return;

    loginLoading = true;
    notifyListeners();
    try {
      _authRepo.login(
        LoginRequest(email: loginEmail.trim(), password: loginPassword),
      );
      Get.snackbar(
        'Welcome back! 👋',
        'Signed in successfully',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      loginLoading = false;
      notifyListeners();
    }
  }

  // --- Register ---

  bool _validateRegister() {
    bool valid = true;
    regUsernameError = '';
    regEmailError = '';
    regPasswordError = '';

    if (regUsername.trim().isEmpty) {
      regUsernameError = 'Username is required';
      valid = false;
    } else if (regUsername.trim().length < 3) {
      regUsernameError = 'Username must be at least 3 characters';
      valid = false;
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(regUsername.trim())) {
      regUsernameError = 'Only letters, numbers and underscore allowed';
      valid = false;
    }

    if (regEmail.trim().isEmpty) {
      regEmailError = 'Email is required';
      valid = false;
    } else if (!_isValidEmail(regEmail.trim())) {
      regEmailError = 'Please enter a valid email';
      valid = false;
    }

    if (regPassword.isEmpty) {
      regPasswordError = 'Password is required';
      valid = false;
    } else if (regPassword.length < 6) {
      regPasswordError = 'Password must be at least 6 characters';
      valid = false;
    }

    notifyListeners();
    return valid;
  }

  Future<void> doRegister() async {
    if (!_validateRegister()) return;

    regLoading = true;
    notifyListeners();
    try {
      _authRepo.signup(
        SignUpRequest(
          email: regEmail.trim(),
          password: regPassword,
          username: regUsername.trim(),
        ),
      );
      Get.snackbar(
        'Account created! 🎉',
        'Welcome to Chitpad',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Registration failed. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      regLoading = false;
      notifyListeners();
    }
  }

  // --- Forgot Password ---

  bool _validateForgot() {
    forgotEmailError = '';
    bool valid = true;
    if (forgotEmail.trim().isEmpty) {
      forgotEmailError = 'Email is required';
      valid = false;
    } else if (!_isValidEmail(forgotEmail.trim())) {
      forgotEmailError = 'Please enter a valid email';
      valid = false;
    }
    notifyListeners();
    return valid;
  }

  Future<void> doForgot() async {
    if (!_validateForgot()) return;
    forgotLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    forgotSent = true;
    forgotLoading = false;
    notifyListeners();
  }

  void doGoogleLogin() {
    Get.snackbar(
      'Google OAuth',
      'Redirecting to Google…',
      snackPosition: SnackPosition.TOP,
    );
  }
}
