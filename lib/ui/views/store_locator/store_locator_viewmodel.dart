import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

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

class StoreLocatorViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController searchController = TextEditingController();

  final List<Store> _allStores = [
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

  List<Store> _filteredStores = [];

  List<Store> get stores => _filteredStores;

  StoreLocatorViewModel() {
    _filteredStores = List.from(_allStores);
  }

  void searchStores(String query) {
    if (query.isEmpty) {
      _filteredStores = List.from(_allStores);
    } else {
      _filteredStores = _allStores
          .where((store) => store.name.toLowerCase().contains(query.toLowerCase()) || store.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void selectStore(Store store) {
    // TODO: Navigate to store details or implement selection
    _navigationService.back();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
