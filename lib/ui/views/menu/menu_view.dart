import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_strings.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'package:siakap/ui/views/menu/menu_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MenuView extends StackedView<MenuViewModel> {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MenuViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => viewModel.showFavoritesOnly(),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => viewModel.navigateToCart(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(viewModel),
            _buildCategorySelector(viewModel),
            Expanded(
              child: _buildProductGrid(viewModel),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Menu is selected
        onTap: viewModel.onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kcPrimaryColor,
        unselectedItemColor: kcSecondaryTextColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee_outlined),
            activeIcon: Icon(Icons.coffee),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined),
            activeIcon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(MenuViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: viewModel.onSearchTextChanged,
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 500));
  }

  Widget _buildCategorySelector(MenuViewModel viewModel) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildCategoryChip('All', null, viewModel),
          _buildCategoryChip('Coffee', 'Coffee', viewModel),
          _buildCategoryChip('Tea', 'Tea', viewModel),
          _buildCategoryChip('Pastry', 'Food', viewModel),
          _buildCategoryChip('Snacks', 'Snacks', viewModel),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, String? category, MenuViewModel viewModel) {
    final isSelected = viewModel.selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => viewModel.selectCategory(category),
        backgroundColor: Colors.grey[200],
        selectedColor: Colors.blue[100],
      ),
    );
  }

  Widget _buildProductGrid(MenuViewModel viewModel) {
    if (viewModel.filteredProducts.isEmpty) {
      return Center(
        child: EmptyStateWidget(
          title: 'No products found',
          subtitle: 'Try changing your search query or category',
          icon: Icons.coffee,
          buttonText: 'Clear Search',
          onButtonTap: viewModel.clearSearch,
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: viewModel.filteredProducts.length,
      itemBuilder: (context, index) {
        final product = viewModel.filteredProducts[index];
        return _buildProductCard(product, viewModel, index);
      },
    );
  }

  Widget _buildProductCard(Product product, MenuViewModel viewModel, int cardIndex) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => viewModel.navigateToProductDetail(product),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 1,
                child: product.imageUrl.isNotEmpty
                    ? Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_not_supported, size: 50),
                        ),
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, size: 50),
                      ),
              ),
            ),
            // Product details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'RM ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Favorite button
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: product.isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () => viewModel.toggleFavorite(product.id),
              ),
            ),
          ],
        ),
      ),
    ).animate(delay: Duration(milliseconds: 50 * (cardIndex % 2))).fadeIn(duration: const Duration(milliseconds: 500)).slideY(
          begin: 0.1,
          end: 0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuad,
        );
  }

  @override
  MenuViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MenuViewModel();
}
