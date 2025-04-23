import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';

class ProfileViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  // Mock user data
  final String _userName = 'John Doe';
  final String _email = 'john.doe@example.com';
  final String _profilePictureUrl = '';
  final String _phoneNumber = '+60 12 345 6789';
  final String _dateOfBirth = '15 Jan 1990';
  final String _address = '123 Coffee Street, Kuala Lumpur, Malaysia';
  final int _loyaltyPoints = 750;
  final int _orderCount = 24;

  // Getters
  String get userName => _userName;
  String get email => _email;
  String get profilePictureUrl => _profilePictureUrl;
  String get phoneNumber => _phoneNumber;
  String get dateOfBirth => _dateOfBirth;
  String get address => _address;
  int get loyaltyPoints => _loyaltyPoints;
  int get orderCount => _orderCount;

  // Get the first letter of first and last name as initials
  String get initials {
    final nameParts = _userName.split(' ');
    if (nameParts.length > 1) {
      return '${nameParts.first[0]}${nameParts.last[0]}'.toUpperCase();
    }
    return nameParts.first[0].toUpperCase();
  }

  // Navigation methods
  void editProfile() {
    // TODO: Implement navigation to profile edit screen
    print('Navigate to edit profile');
  }

  void navigateToFavorites() {
    // TODO: Implement navigation to favorites screen
    print('Navigate to favorites');
  }

  void navigateToOrderHistory() {
    // TODO: Implement navigation to order history screen
    print('Navigate to order history');
  }

  void navigateToPaymentMethods() {
    // TODO: Implement navigation to payment methods screen
    print('Navigate to payment methods');
  }

  void navigateToSavedAddresses() {
    // TODO: Implement navigation to saved addresses screen
    print('Navigate to saved addresses');
  }

  void navigateToNotificationSettings() {
    // TODO: Implement navigation to notification settings screen
    print('Navigate to notification settings');
  }

  void navigateToHelp() {
    // TODO: Implement navigation to help and support screen
    print('Navigate to help and support');
  }

  void navigateToPrivacyPolicy() {
    // TODO: Implement navigation to privacy policy screen
    print('Navigate to privacy policy');
  }

  void navigateToTerms() {
    // TODO: Implement navigation to terms and conditions screen
    print('Navigate to terms and conditions');
  }

  void logout() {
    // TODO: Implement logout functionality
    print('Logout user');
    // After logout, navigate to login screen
    // _navigationService.clearStackAndShow(Routes.loginView);
  }
}
