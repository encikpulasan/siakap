import 'package:flutter/material.dart';
import 'package:siakap/app/app.bottomsheets.dart';
import 'package:siakap/app/app.dialogs.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';
import 'package:siakap/ui/views/menu/menu_viewmodel.dart' as menu;
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
  });
}

class Store {
  final String id;
  final String name;
  final String address;
  final double distance;
  final String imageUrl;

  Store({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.imageUrl,
  });
}

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  final TextEditingController searchController = TextEditingController();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  String _userName = 'John Doe';
  String get userName => _userName;

  String _userProfileImageUrl = '';
  String get userProfileImageUrl => _userProfileImageUrl;

  final List<Product> _popularItems = [
    Product(
      id: '1',
      name: 'Caramel Macchiato',
      imageUrl: 'https://images.unsplash.com/photo-1525480122447-64809d765a77',
      price: 15.50,
    ),
    Product(
      id: '2',
      name: 'Flat White',
      imageUrl: 'https://images.unsplash.com/photo-1577968897966-3d4325b36b61',
      price: 12.00,
    ),
    Product(
      id: '3',
      name: 'Iced Americano',
      imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c',
      price: 11.50,
    ),
    Product(
      id: '4',
      name: 'Latte',
      imageUrl: 'https://images.unsplash.com/photo-1570968915860-54d5c301fa9f',
      price: 13.00,
    ),
  ];

  List<Product> get popularItems => _popularItems;

  final List<Product> _recommendedItems = [
    Product(
      id: '5',
      name: 'Cappuccino',
      imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213',
      price: 13.50,
    ),
    Product(
      id: '6',
      name: 'Mocha Frappuccino',
      imageUrl: 'https://images.unsplash.com/photo-1572526423078-5a2337e0cb11',
      price: 18.00,
    ),
    Product(
      id: '7',
      name: 'Espresso Shot',
      imageUrl: 'https://images.unsplash.com/photo-1520031607889-97e2b0cf3d51',
      price: 7.50,
    ),
    Product(
      id: '8',
      name: 'Cold Brew',
      imageUrl: 'https://images.unsplash.com/photo-1559525142-9a84995e0445',
      price: 14.00,
    ),
  ];

  List<Product> get recommendedItems => _recommendedItems;

  final List<Store> _nearbyStores = [
    Store(
      id: '1',
      name: 'ZAS Coffee Bukit Bintang',
      address: 'Lot 123, Jalan Bukit Bintang, 50250 Kuala Lumpur',
      distance: 1.2,
      imageUrl: 'https://images.unsplash.com/photo-1554118811-1e0d58224f24',
    ),
    Store(
      id: '2',
      name: 'ZAS Coffee KLCC',
      address: 'Suria KLCC, Kuala Lumpur City Centre, 50088 Kuala Lumpur',
      distance: 2.5,
      imageUrl: 'https://images.unsplash.com/photo-1453614512568-c4024d13c247',
    ),
    Store(
      id: '3',
      name: 'ZAS Coffee Mid Valley',
      address: 'Mid Valley Megamall, Lingkaran Syed Putra, 59200 Kuala Lumpur',
      distance: 3.7,
      imageUrl: 'https://images.unsplash.com/photo-1525193612562-0ec53b0e5d7c',
    ),
  ];

  List<Store> get nearbyStores => _nearbyStores;

  void setIndex(int index) {
    if (index == _currentIndex) return; // No need to navigate if already on this tab

    switch (index) {
      case 0:
        // Already on Home view
        break;
      case 1:
        _navigationService.navigateToMenuView();
        break;
      case 2:
        // Navigate to Cart
        _navigationService.navigateToCartView();
        break;
      case 3:
        // Navigate to Rewards/Loyalty
        _navigationService.navigateToLoyaltyView();
        break;
      case 4:
        // Navigate to Profile
        _navigationService.navigateToProfileView();
        break;
      default:
        _currentIndex = index;
        notifyListeners();
    }
  }

  void onSearchChanged(String query) {
    // Handle search
  }

  void clearSearch() {
    searchController.clear();
    notifyListeners();
  }

  void navigateToNotifications() {
    // TODO: Add notifications view to app.dart and implement navigation
  }

  void navigateToProfile() {
    _navigationService.navigateToProfileView();
  }

  void navigateToMenu() {
    _navigationService.navigateToMenuView();
  }

  void navigateToAllPopularItems() {
    _navigationService.navigateToMenuView();
  }

  void navigateToAllRecommendedItems() {
    _navigationService.navigateToMenuView();
  }

  void navigateToStoreLocator() {
    // TODO: Add store locator view to app.dart and implement navigation
  }

  void navigateToProductDetail(Product product) {
    // Convert from Home Product to Menu Product
    final menuProduct = menu.Product(
      id: product.id,
      name: product.name,
      image: product.imageUrl,
      price: product.price,
      description: '', // We don't have this in Home Product
      category: '', // We don't have this in Home Product
      isFavorite: product.isFavorite,
    );

    _navigationService.navigateToProductDetailView(product: menuProduct);
  }

  void navigateToStoreDetail(Store store) {
    // TODO: Add store detail view to app.dart and implement navigation
  }

  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'ZAS Coffee',
      description: 'Enjoy your coffee!',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Special Offer',
      description: 'Buy 1 Get 1 Free on all drinks this weekend!',
    );
  }
}
