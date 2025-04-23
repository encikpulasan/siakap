import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';

class Product {
  final String id;
  final String name;
  final String image;
  String get imageUrl => image;
  final double price;
  final String description;
  final String category;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
    this.isFavorite = false,
  });

  // Sample factory method to create a product from map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      price: (map['price'] as num).toDouble(),
      description: map['description'],
      category: map['category'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}

class MenuViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  // Categories
  List<String> categories = [
    'All',
    'Coffee',
    'Non-Coffee',
    'Tea',
    'Food',
    'Snacks',
  ];

  int _selectedCategoryIndex = 0;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  String? get selectedCategory => _selectedCategoryIndex == 0 ? null : categories[_selectedCategoryIndex];

  void selectCategory(dynamic category) {
    if (category is int) {
      _selectedCategoryIndex = category;
    } else if (category is String?) {
      if (category == null) {
        _selectedCategoryIndex = 0;
      } else {
        int index = categories.indexOf(category);
        if (index >= 0) {
          _selectedCategoryIndex = index;
        }
      }
    }

    _filterProducts();
    notifyListeners();
  }

  // Search functionality
  final TextEditingController searchController = TextEditingController();

  void onSearchChanged() {
    _filterProducts();
    notifyListeners();
  }

  void onSearchTextChanged(String text) {
    searchController.text = text;
    onSearchChanged();
  }

  void clearSearch() {
    searchController.clear();
    onSearchChanged();
  }

  // Products
  final List<Product> _allProducts = [
    Product(
      id: '1',
      name: 'Cappuccino',
      image: 'assets/images/cappuccino.png',
      price: 15.90,
      description: 'A cappuccino is an espresso-based coffee drink that originated in Italy and is prepared with steamed milk foam.',
      category: 'Coffee',
    ),
    Product(
      id: '2',
      name: 'Latte',
      image: 'assets/images/latte.png',
      price: 13.90,
      description: 'Coffee drink made with espresso and steamed milk.',
      category: 'Coffee',
    ),
    Product(
      id: '3',
      name: 'Espresso',
      image: 'assets/images/espresso.png',
      price: 10.90,
      description: 'Concentrated form of coffee served in small, strong shots.',
      category: 'Coffee',
    ),
    Product(
      id: '4',
      name: 'Green Tea',
      image: 'assets/images/green_tea.png',
      price: 12.90,
      description: 'Tea made from Camellia sinensis leaves that have not undergone the same withering and oxidation process used to make oolong and black tea.',
      category: 'Tea',
    ),
    Product(
      id: '5',
      name: 'Chocolate Cake',
      image: 'assets/images/chocolate_cake.png',
      price: 18.90,
      description: 'Delicious cake made with chocolate or cocoa.',
      category: 'Food',
    ),
  ];

  List<Product> _filteredProducts = [];
  List<Product> get filteredProducts => _filteredProducts;

  bool _showFavoritesOnly = false;

  void showFavoritesOnly() {
    _showFavoritesOnly = !_showFavoritesOnly;
    _filterProducts();
    notifyListeners();
  }

  void onBottomNavTap(int index) {
    switch (index) {
      case 0:
        _navigationService.navigateToHomeView();
        break;
      case 1:
        // Already on Menu view
        break;
      case 2:
        navigateToCart();
        break;
      case 3:
        _navigationService.navigateToLoyaltyView();
        break;
      case 4:
        _navigationService.navigateToProfileView();
        break;
    }
  }

  void navigateToCart() {
    _navigationService.navigateToCartView();
  }

  void _filterProducts() {
    final searchTerm = searchController.text.toLowerCase();
    final selectedCategory = categories[_selectedCategoryIndex];

    _filteredProducts = _allProducts.where((product) {
      // Filter by search term
      final matchesSearch = searchTerm.isEmpty || product.name.toLowerCase().contains(searchTerm) || product.description.toLowerCase().contains(searchTerm);

      // Filter by category
      final matchesCategory = selectedCategory == 'All' || product.category == selectedCategory;

      // Filter by favorites if enabled
      final matchesFavorite = !_showFavoritesOnly || product.isFavorite;

      return matchesSearch && matchesCategory && matchesFavorite;
    }).toList();
  }

  void toggleFavorite(String productId) {
    toggleProductFavorite(productId);
  }

  void toggleProductFavorite(String productId) {
    final index = _allProducts.indexWhere((product) => product.id == productId);
    if (index != -1) {
      _allProducts[index].isFavorite = !_allProducts[index].isFavorite;
      _filterProducts();
      notifyListeners();
    }
  }

  void navigateToProductDetail(Product product) {
    _navigationService.navigateToProductDetailView(product: product);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
