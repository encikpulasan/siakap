import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/ui/views/menu/menu_viewmodel.dart';

class ProductDetailViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final Product product;

  ProductDetailViewModel({required this.product}) {
    _isFavorite = product.isFavorite;
  }

  // Size selection
  int _selectedSizeIndex = 1; // Default to medium size
  int get selectedSizeIndex => _selectedSizeIndex;

  // Size pricing
  final List<double> _sizePrices = [0.0, 2.0, 4.0]; // Small, Medium, Large price additions

  double getSizePrice(int index) {
    return _sizePrices[index];
  }

  void selectSize(int index) {
    _selectedSizeIndex = index;
    notifyListeners();
  }

  // Customization options
  bool _hasExtraShot = false;
  bool get hasExtraShot => _hasExtraShot;

  bool _hasLessIce = false;
  bool get hasLessIce => _hasLessIce;

  bool _hasLessSugar = false;
  bool get hasLessSugar => _hasLessSugar;

  void toggleExtraShot() {
    _hasExtraShot = !_hasExtraShot;
    notifyListeners();
  }

  void toggleLessIce() {
    _hasLessIce = !_hasLessIce;
    notifyListeners();
  }

  void toggleLessSugar() {
    _hasLessSugar = !_hasLessSugar;
    notifyListeners();
  }

  // Special instructions
  final TextEditingController specialInstructionsController = TextEditingController();

  // Quantity
  int _quantity = 1;
  int get quantity => _quantity;

  void increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  // Price calculations
  double get basePrice => product.price;

  double get sizePrice => _sizePrices[_selectedSizeIndex];

  double get extraShotPrice => _hasExtraShot ? 2.0 : 0.0;

  double get totalPrice => basePrice + sizePrice + extraShotPrice;

  double get cartTotal => totalPrice * _quantity;

  // Favorite handling
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    // Here you would update the product's favorite status in your data store
    notifyListeners();
  }

  // Navigation
  void navigateBack() {
    _navigationService.back();
  }

  // Cart handling
  void addToCart() {
    // TODO: Implement cart functionality
    final customizations = <String>[];

    if (_hasExtraShot) customizations.add('Extra Shot');
    if (_hasLessIce) customizations.add('Less Ice');
    if (_hasLessSugar) customizations.add('Less Sugar');

    final specialInstructions = specialInstructionsController.text.trim();
    if (specialInstructions.isNotEmpty) {
      customizations.add('Special: $specialInstructions');
    }

    // Here you would add the item to your cart service
    // For now, just print what would be added
    print('Added to cart: ${product.name}');
    print('Size: ${_selectedSizeIndex == 0 ? 'Small' : _selectedSizeIndex == 1 ? 'Medium' : 'Large'}');
    print('Quantity: $_quantity');
    print('Customizations: ${customizations.join(', ')}');
    print('Total: RM${cartTotal.toStringAsFixed(2)}');

    // Navigate back or to cart
    _navigationService.back();
  }

  @override
  void dispose() {
    specialInstructionsController.dispose();
    super.dispose();
  }
}
