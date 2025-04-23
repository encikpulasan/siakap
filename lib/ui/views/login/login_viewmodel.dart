import 'package:flutter/material.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> login() async {
    setBusy(true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setBusy(false);
    _navigationService.replaceWith(Routes.homeView);
  }

  Future<void> loginWithGoogle() async {
    // Implementation would go here
    _navigationService.replaceWith(Routes.homeView);
  }

  Future<void> loginWithFacebook() async {
    // Implementation would go here
    _navigationService.replaceWith(Routes.homeView);
  }

  Future<void> loginWithApple() async {
    // Implementation would go here
    _navigationService.replaceWith(Routes.homeView);
  }

  void navigateToRegister() {
    _navigationService.navigateTo(Routes.registerView);
  }

  void navigateToForgotPassword() {
    _navigationService.navigateTo(Routes.forgotPasswordView);
  }
}
