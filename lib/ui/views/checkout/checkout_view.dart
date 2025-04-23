import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'checkout_viewmodel.dart';

class CheckoutView extends StackedView<CheckoutViewModel> {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CheckoutViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        elevation: 0,
      ),
      body: SafeArea(
        child: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderSummary(context, viewModel),
                    const SizedBox(height: 24),
                    _buildDeliverySection(context, viewModel),
                    const SizedBox(height: 24),
                    _buildPaymentSection(context, viewModel),
                    const SizedBox(height: 24),
                    _buildPriceDetails(context, viewModel),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: _buildPlaceOrderButton(context, viewModel),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CheckoutViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.cartItems.length,
          itemBuilder: (context, index) {
            final item = viewModel.cartItems[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(item.name),
              subtitle: Text('${item.quantity}x - ${item.customization}'),
              trailing: Text(
                'RM ${(item.price * item.quantity).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDeliverySection(BuildContext context, CheckoutViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Method',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSelectionCard(
                context,
                isSelected: viewModel.deliveryMethod == DeliveryMethod.pickup,
                title: 'Pickup',
                subtitle: 'Collect from store',
                iconData: Icons.store,
                onTap: () => viewModel.setDeliveryMethod(DeliveryMethod.pickup),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSelectionCard(
                context,
                isSelected: viewModel.deliveryMethod == DeliveryMethod.delivery,
                title: 'Delivery',
                subtitle: 'Deliver to address',
                iconData: Icons.delivery_dining,
                onTap: () => viewModel.setDeliveryMethod(DeliveryMethod.delivery),
              ),
            ),
          ],
        ),
        if (viewModel.deliveryMethod == DeliveryMethod.pickup)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Store:'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: viewModel.selectedStore,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  items: viewModel.stores.map((store) {
                    return DropdownMenuItem<String>(
                      value: store,
                      child: Text(store),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      viewModel.setSelectedStore(value);
                    }
                  },
                ),
              ],
            ),
          ),
        if (viewModel.deliveryMethod == DeliveryMethod.delivery)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Delivery Address:'),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  maxLines: 3,
                  controller: viewModel.addressController,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPaymentSection(BuildContext context, CheckoutViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Column(
          children: PaymentMethod.values.map((method) {
            return RadioListTile<PaymentMethod>(
              title: Text(method.name),
              value: method,
              groupValue: viewModel.paymentMethod,
              onChanged: (value) {
                if (value != null) {
                  viewModel.setPaymentMethod(value);
                }
              },
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceDetails(BuildContext context, CheckoutViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Subtotal'),
            Text('RM ${viewModel.subtotal.toStringAsFixed(2)}'),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tax (6%)'),
            Text('RM ${viewModel.tax.toStringAsFixed(2)}'),
          ],
        ),
        if (viewModel.deliveryMethod == DeliveryMethod.delivery) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delivery Fee'),
              Text('RM ${viewModel.deliveryFee.toStringAsFixed(2)}'),
            ],
          ),
        ],
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'RM ${viewModel.total.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: kcPrimaryColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectionCard(
    BuildContext context, {
    required bool isSelected,
    required String title,
    required String subtitle,
    required IconData iconData,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? kcPrimaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              iconData,
              color: isSelected ? kcPrimaryColor : Colors.grey,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? kcPrimaryColor : Colors.black,
                  ),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context, CheckoutViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppButton(
        title: 'Place Order',
        onTap: viewModel.placeOrder,
        isLoading: viewModel.isBusy,
      ),
    );
  }

  @override
  CheckoutViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CheckoutViewModel();
}
