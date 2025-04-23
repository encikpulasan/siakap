import 'package:flutter/material.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  bool _agreeToTerms = false;
  bool get agreeToTerms => _agreeToTerms;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void setAgreeToTerms(bool value) {
    _agreeToTerms = value;
    notifyListeners();
  }

  Future<void> register() async {
    if (!_validateInputs()) {
      return;
    }

    if (!_agreeToTerms) {
      // Show error message
      return;
    }

    setBusy(true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setBusy(false);
    _navigationService.replaceWith(Routes.homeView);
  }

  bool _validateInputs() {
    // Validate name
    if (nameController.text.isEmpty) {
      return false;
    }

    // Validate email
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      return false;
    }

    // Validate phone
    if (phoneController.text.isEmpty) {
      return false;
    }

    // Validate password
    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      return false;
    }

    // Validate confirm password
    if (confirmPasswordController.text != passwordController.text) {
      return false;
    }

    return true;
  }

  void navigateToLogin() {
    _navigationService.replaceWith(Routes.loginView);
  }

  void navigateToTermsAndConditions() {
    // Navigate to terms and conditions
  }

  void navigateToPrivacyPolicy() {
    // Navigate to privacy policy
  }
}
