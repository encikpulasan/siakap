import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';
import 'package:siakap/ui/views/cart/cart_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';

enum DeliveryMethod { pickup, delivery }

enum PaymentMethod { creditCard, onlineWallet, cashOnDelivery }

class CheckoutViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController addressController = TextEditingController();

  // Mock cart items for demonstration, in real app would come from cart service
  final List<CartItem> _cartItems = [
    CartItem(
      id: '1',
      name: 'Cappuccino',
      customization: 'Medium, Less Sugar',
      imageUrl: 'assets/images/cappuccino.png',
      price: 15.90,
      quantity: 1,
    ),
    CartItem(
      id: '2',
      name: 'Latte',
      customization: 'Large, Extra Shot',
      imageUrl: 'assets/images/latte.png',
      price: 16.90,
      quantity: 2,
    ),
  ];

  List<CartItem> get cartItems => _cartItems;

  // Delivery method
  DeliveryMethod _deliveryMethod = DeliveryMethod.pickup;
  DeliveryMethod get deliveryMethod => _deliveryMethod;

  void setDeliveryMethod(DeliveryMethod method) {
    _deliveryMethod = method;
    notifyListeners();
  }

  // Store selection
  final List<String> _stores = [
    'ZAS Coffee Bukit Bintang',
    'ZAS Coffee KLCC',
    'ZAS Coffee Mid Valley',
  ];
  List<String> get stores => _stores;

  String _selectedStore = 'ZAS Coffee Bukit Bintang';
  String get selectedStore => _selectedStore;

  void setSelectedStore(String store) {
    _selectedStore = store;
    notifyListeners();
  }

  // Payment method
  PaymentMethod _paymentMethod = PaymentMethod.creditCard;
  PaymentMethod get paymentMethod => _paymentMethod;

  void setPaymentMethod(PaymentMethod method) {
    _paymentMethod = method;
    notifyListeners();
  }

  // Price calculations
  double get subtotal => _cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
  double get tax => subtotal * 0.06; // 6% tax
  double get deliveryFee => _deliveryMethod == DeliveryMethod.delivery ? 5.0 : 0.0;
  double get total => subtotal + tax + deliveryFee;

  Future<void> placeOrder() async {
    setBusy(true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Navigate to order success or tracking screen
    setBusy(false);

    // TODO: Navigate to order tracking or success screen
    _navigationService.back();
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}
