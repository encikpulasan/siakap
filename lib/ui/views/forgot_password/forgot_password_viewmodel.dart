import 'package:flutter/material.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  final TextEditingController emailController = TextEditingController();

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  Future<void> sendResetLink() async {
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      // Show error
      return;
    }

    setBusy(true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    _isSuccess = true;

    setBusy(false);
    notifyListeners();
  }

  void navigateBack() {
    _navigationService.back();
  }
}
