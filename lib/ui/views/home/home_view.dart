import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_strings.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, viewModel),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildPromotionBanner(context, viewModel),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: ksPopularItems,
                        actionText: ksSeeAll,
                        onActionTap: viewModel.navigateToAllPopularItems,
                      ),
                      const SizedBox(height: 16),
                      _buildPopularItems(viewModel),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: ksRecommendedForYou,
                        actionText: ksSeeAll,
                        onActionTap: viewModel.navigateToAllRecommendedItems,
                      ),
                      const SizedBox(height: 16),
                      _buildRecommendedItems(viewModel),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: ksNearbyStores,
                        actionText: ksSeeAll,
                        onActionTap: viewModel.navigateToStoreLocator,
                      ),
                      const SizedBox(height: 16),
                      _buildNearbyStores(viewModel),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(viewModel),
    );
  }

  Widget _buildHeader(BuildContext context, HomeViewModel viewModel) {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting = '${ksHomeGreeting} ';

    if (hour < 12) {
      greeting += 'Morning';
    } else if (hour < 17) {
      greeting += 'Afternoon';
    } else {
      greeting += 'Evening';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greeting,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      viewModel.userName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: viewModel.navigateToNotifications,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kcVeryLightGrey.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: kcTextColor,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: viewModel.navigateToProfile,
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: kcVeryLightGrey,
                      backgroundImage: viewModel.userProfileImageUrl.isNotEmpty ? NetworkImage(viewModel.userProfileImageUrl) : null,
                      child: viewModel.userProfileImageUrl.isEmpty ? const Icon(Icons.person, color: kcMediumGrey) : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomSearchBar(
            controller: viewModel.searchController,
            onChanged: viewModel.onSearchChanged,
            onClear: viewModel.clearSearch,
            hintText: 'Search coffee, food, or store...',
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildPromotionBanner(BuildContext context, HomeViewModel viewModel) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kcPrimaryColor, kcPrimaryColorLight],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Image.asset(
              'assets/images/coffee_cup.png',
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buy 1 Get 1 Free',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Every weekend from 2pm to 5pm',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                ),
                const SizedBox(height: 16),
                AppButton(
                  title: 'Order Now',
                  onTap: viewModel.navigateToMenu,
                  height: 40,
                  width: 120,
                  color: Colors.white,
                  isOutlined: false,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(
          begin: 0.1,
          end: 0,
          duration: 600.ms,
          curve: Curves.easeOutQuad,
        );
  }

  Widget _buildPopularItems(HomeViewModel viewModel) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: viewModel.popularItems.length,
        itemBuilder: (context, index) {
          final item = viewModel.popularItems[index];
          return ProductCard(
            name: item.name,
            imageUrl: item.imageUrl,
            price: item.price,
            isFavorite: item.isFavorite,
            onTap: () => viewModel.navigateToProductDetail(item),
            onFavoriteToggle: () => viewModel.toggleFavorite(item),
          ).animate(delay: (50 * index).ms).fadeIn(duration: 500.ms).slideY(
                begin: 0.1,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOutQuad,
              );
        },
      ),
    );
  }

  Widget _buildRecommendedItems(HomeViewModel viewModel) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: viewModel.recommendedItems.length,
        itemBuilder: (context, index) {
          final item = viewModel.recommendedItems[index];
          return ProductCard(
            name: item.name,
            imageUrl: item.imageUrl,
            price: item.price,
            isFavorite: item.isFavorite,
            onTap: () => viewModel.navigateToProductDetail(item),
            onFavoriteToggle: () => viewModel.toggleFavorite(item),
          ).animate(delay: (50 * index).ms).fadeIn(duration: 500.ms).slideY(
                begin: 0.1,
                end: 0,
                duration: 500.ms,
                curve: Curves.easeOutQuad,
              );
        },
      ),
    );
  }

  Widget _buildNearbyStores(HomeViewModel viewModel) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: viewModel.nearbyStores.length.clamp(0, 3),
      itemBuilder: (context, index) {
        final store = viewModel.nearbyStores[index];
        return StoreCard(
          name: store.name,
          address: store.address,
          distance: store.distance,
          imageUrl: store.imageUrl,
          onTap: () => viewModel.navigateToStoreDetail(store),
        ).animate(delay: (50 * index).ms).fadeIn(duration: 500.ms).slideX(
              begin: 0.05,
              end: 0,
              duration: 500.ms,
              curve: Curves.easeOutQuad,
            );
      },
    );
  }

  Widget _buildBottomNavigationBar(HomeViewModel viewModel) {
    return BottomNavigationBar(
      currentIndex: viewModel.currentIndex,
      onTap: viewModel.setIndex,
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
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
