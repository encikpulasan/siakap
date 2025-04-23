import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class CartItem {
  final String id;
  final String name;
  final String customization;
  final String imageUrl;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.customization,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;
}

class CartViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  // Mock cart items for demonstration
  final List<CartItem> _cartItems = [
    CartItem(
      id: '1',
      name: 'Cappuccino',
      customization: 'Medium, Less Sugar',
      imageUrl: 'assets/images/cappuccino.png',
      price: 15.90,
    ),
    CartItem(
      id: '2',
      name: 'Latte',
      customization: 'Large, Extra Shot',
      imageUrl: 'assets/images/latte.png',
      price: 16.90,
    ),
  ];

  List<CartItem> get cartItems => _cartItems;

  double get subtotal => _cartItems.fold(0, (total, item) => total + item.total);

  double get tax => subtotal * 0.06; // 6% tax

  double get total => subtotal + tax;

  void increaseQuantity(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      notifyListeners();
    } else {
      removeItem(item);
    }
  }

  void removeItem(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void navigateToMenu() {
    _navigationService.navigateToMenuView();
  }

  void navigateToCheckout() {
    // TODO: Navigate to checkout view once it's created
    // _navigationService.navigateToCheckoutView();
  }
}
