import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderItem {
  final String id;
  final String name;
  final String customization;
  final String imageUrl;
  final double price;
  final int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.customization,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}

class OrderTrackingViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  // Order details (would normally come from backend)
  final String _orderNumber = 'ZAS12345';
  final String _orderDate = 'May 15, 2023 • 10:30 AM';
  final bool _isDelivery = true;
  final String _deliveryAddress = '123 Main Street, Kuala Lumpur';
  final String _storeLocation = 'ZAS Coffee Bukit Bintang';
  final String _orderStatus = 'Preparing';
  final int _currentStep = 2; // 1: Placed, 2: Preparing, 3: Delivering/Ready, 4: Completed
  final String _estimatedTime = '11:15 AM';
  final String _paymentMethod = 'Credit Card (Visa **** 1234)';
  final bool _canCancel = true;

  // Getter methods
  String get orderNumber => _orderNumber;
  String get orderDate => _orderDate;
  bool get isDelivery => _isDelivery;
  String get deliveryAddress => _deliveryAddress;
  String get storeLocation => _storeLocation;
  String get orderStatus => _orderStatus;
  int get currentStep => _currentStep;
  String get estimatedTime => _estimatedTime;
  String get paymentMethod => _paymentMethod;
  bool get canCancel => _canCancel;

  // Mock order items
  final List<OrderItem> _orderItems = [
    OrderItem(
      id: '1',
      name: 'Cappuccino',
      customization: 'Medium, Less Sugar',
      imageUrl: 'assets/images/cappuccino.png',
      price: 15.90,
      quantity: 1,
    ),
    OrderItem(
      id: '2',
      name: 'Latte',
      customization: 'Large, Extra Shot',
      imageUrl: 'assets/images/latte.png',
      price: 16.90,
      quantity: 2,
    ),
  ];

  List<OrderItem> get orderItems => _orderItems;

  // Price calculations
  double get subtotal => _orderItems.fold(0, (total, item) => total + (item.price * item.quantity));
  double get tax => subtotal * 0.06; // 6% tax
  double get deliveryFee => _isDelivery ? 5.0 : 0.0;
  double get total => subtotal + tax + deliveryFee;

  Future<void> cancelOrder() async {
    setBusy(true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Navigate back to home or order list
    setBusy(false);
    _navigationService.back();
  }
}
