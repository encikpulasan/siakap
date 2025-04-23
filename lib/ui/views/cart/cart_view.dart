import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'cart_viewmodel.dart';

class CartView extends StackedView<CartViewModel> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CartViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        elevation: 0,
      ),
      body: SafeArea(
        child: viewModel.cartItems.isEmpty ? _buildEmptyCart(context, viewModel) : _buildCartItems(context, viewModel),
      ),
      bottomNavigationBar: viewModel.cartItems.isEmpty ? null : _buildCheckoutBar(context, viewModel),
    );
  }

  Widget _buildEmptyCart(BuildContext context, CartViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Browse our menu and add something delicious',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 24),
          AppButton(
            title: 'Browse Menu',
            onTap: viewModel.navigateToMenu,
            width: 200,
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(BuildContext context, CartViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: viewModel.cartItems.length,
            itemBuilder: (context, index) {
              final item = viewModel.cartItems[index];
              return Dismissible(
                key: Key(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  viewModel.removeItem(item);
                },
                child: ListTile(
                  leading: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(item.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(item.name),
                  subtitle: Text(item.customization),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => viewModel.decreaseQuantity(item),
                      ),
                      Text(
                        '${item.quantity}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => viewModel.increaseQuantity(item),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'RM ${viewModel.subtotal.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tax',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'RM ${viewModel.tax.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'RM ${viewModel.total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: kcPrimaryColor,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutBar(BuildContext context, CartViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppButton(
        title: 'Proceed to Checkout',
        onTap: viewModel.navigateToCheckout,
      ),
    );
  }

  @override
  CartViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CartViewModel();
}
