import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'order_tracking_viewmodel.dart';

class OrderTrackingView extends StackedView<OrderTrackingViewModel> {
  const OrderTrackingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OrderTrackingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
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
                    _buildOrderHeader(context, viewModel),
                    const SizedBox(height: 24),
                    _buildOrderStatus(context, viewModel),
                    const SizedBox(height: 24),
                    _buildOrderItems(context, viewModel),
                    const SizedBox(height: 24),
                    _buildOrderDetails(context, viewModel),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildOrderHeader(BuildContext context, OrderTrackingViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${viewModel.orderNumber}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(viewModel.orderStatus).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  viewModel.orderStatus,
                  style: TextStyle(
                    color: _getStatusColor(viewModel.orderStatus),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Placed on ${viewModel.orderDate}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 8),
          if (viewModel.isDelivery)
            Text(
              'Delivery to: ${viewModel.deliveryAddress}',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          else
            Text(
              'Pickup from: ${viewModel.storeLocation}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }

  Widget _buildOrderStatus(BuildContext context, OrderTrackingViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Status',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatusStep(
                context,
                icon: Icons.receipt_long,
                title: 'Order Placed',
                isCompleted: viewModel.currentStep >= 1,
                isActive: viewModel.currentStep == 1,
                showConnector: true,
              ),
            ),
            Expanded(
              child: _buildStatusStep(
                context,
                icon: Icons.coffee,
                title: 'Preparing',
                isCompleted: viewModel.currentStep >= 2,
                isActive: viewModel.currentStep == 2,
                showConnector: true,
              ),
            ),
            Expanded(
              child: _buildStatusStep(
                context,
                icon: viewModel.isDelivery ? Icons.delivery_dining : Icons.store,
                title: viewModel.isDelivery ? 'Delivering' : 'Ready for Pickup',
                isCompleted: viewModel.currentStep >= 3,
                isActive: viewModel.currentStep == 3,
                showConnector: true,
              ),
            ),
            Expanded(
              child: _buildStatusStep(
                context,
                icon: Icons.check_circle,
                title: 'Completed',
                isCompleted: viewModel.currentStep >= 4,
                isActive: viewModel.currentStep == 4,
                showConnector: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.access_time,
                color: kcPrimaryColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.isDelivery ? 'Estimated Delivery Time' : 'Estimated Pickup Time',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    Text(
                      viewModel.estimatedTime,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusStep(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isCompleted,
    required bool isActive,
    required bool showConnector,
  }) {
    final Color color = isCompleted || isActive ? kcPrimaryColor : Colors.grey.shade400;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? color : Colors.white,
            border: Border.all(
              color: color,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: isCompleted ? Colors.white : color,
            size: 20,
          ),
        ),
        if (showConnector)
          Container(
            height: 2,
            color: isCompleted ? color : Colors.grey.shade300,
          ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: isActive || isCompleted ? kcPrimaryColor : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOrderItems(BuildContext context, OrderTrackingViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Items',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.orderItems.length,
          itemBuilder: (context, index) {
            final item = viewModel.orderItems[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(item.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          item.customization,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${item.quantity}x',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildOrderDetails(BuildContext context, OrderTrackingViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              _buildOrderDetailRow(
                context,
                label: 'Subtotal',
                value: 'RM ${viewModel.subtotal.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 8),
              _buildOrderDetailRow(
                context,
                label: 'Tax (6%)',
                value: 'RM ${viewModel.tax.toStringAsFixed(2)}',
              ),
              if (viewModel.isDelivery) ...[
                const SizedBox(height: 8),
                _buildOrderDetailRow(
                  context,
                  label: 'Delivery Fee',
                  value: 'RM ${viewModel.deliveryFee.toStringAsFixed(2)}',
                ),
              ],
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              _buildOrderDetailRow(
                context,
                label: 'Total',
                value: 'RM ${viewModel.total.toStringAsFixed(2)}',
                isTotal: true,
              ),
              const SizedBox(height: 16),
              _buildOrderDetailRow(
                context,
                label: 'Payment Method',
                value: viewModel.paymentMethod,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        if (viewModel.canCancel)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: viewModel.cancelOrder,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.red),
                foregroundColor: Colors.red,
              ),
              child: const Text('Cancel Order'),
            ),
          ),
      ],
    );
  }

  Widget _buildOrderDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          value,
          style: isTotal
              ? Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: kcPrimaryColor,
                  )
              : Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Processing':
        return Colors.orange;
      case 'Preparing':
        return Colors.blue;
      case 'Ready for Pickup':
      case 'Out for Delivery':
        return Colors.indigo;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  OrderTrackingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OrderTrackingViewModel();
}
