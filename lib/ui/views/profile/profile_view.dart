import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: viewModel.editProfile,
          ),
        ],
      ),
      body: SafeArea(
        child: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileHeader(context, viewModel),
                    const SizedBox(height: 16),
                    _buildPersonalInformation(context, viewModel),
                    const SizedBox(height: 16),
                    _buildOptions(context, viewModel),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileViewModel viewModel) {
    return Container(
      color: kcPrimaryColor,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: viewModel.profilePictureUrl.isEmpty
                ? Text(
                    viewModel.initials,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : null,
            backgroundImage: viewModel.profilePictureUrl.isNotEmpty ? NetworkImage(viewModel.profilePictureUrl) : null,
          ),
          const SizedBox(height: 16),
          Text(
            viewModel.userName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            viewModel.email,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileStat(
                context,
                label: 'Points',
                value: viewModel.loyaltyPoints.toString(),
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.white.withOpacity(0.3),
                margin: const EdgeInsets.symmetric(horizontal: 24),
              ),
              _buildProfileStat(
                context,
                label: 'Orders',
                value: viewModel.orderCount.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildPersonalInformation(BuildContext context, ProfileViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            context: context,
            icon: Icons.phone,
            label: 'Phone Number',
            value: viewModel.phoneNumber,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            context: context,
            icon: Icons.calendar_today,
            label: 'Date of Birth',
            value: viewModel.dateOfBirth,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            context: context,
            icon: Icons.location_on,
            label: 'Address',
            value: viewModel.address,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: kcPrimaryColor,
          size: 20,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptions(BuildContext context, ProfileViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Options',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildOptionTile(
            context: context,
            icon: Icons.favorite,
            title: 'My Favorites',
            onTap: viewModel.navigateToFavorites,
          ),
          _buildOptionTile(
            context: context,
            icon: Icons.shopping_bag,
            title: 'Order History',
            onTap: viewModel.navigateToOrderHistory,
          ),
          _buildOptionTile(
            context: context,
            icon: Icons.credit_card,
            title: 'Payment Methods',
            onTap: viewModel.navigateToPaymentMethods,
          ),
          _buildOptionTile(
            context: context,
            icon: Icons.location_on,
            title: 'Saved Addresses',
            onTap: viewModel.navigateToSavedAddresses,
          ),
          _buildOptionTile(
            context: context,
            icon: Icons.notifications,
            title: 'Notification Settings',
            onTap: viewModel.navigateToNotificationSettings,
          ),
          const Divider(),
          _buildOptionTile(
            context: context,
            icon: Icons.help,
            title: 'Help & Support',
            onTap: viewModel.navigateToHelp,
          ),
          _buildOptionTile(
            context: context,
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: viewModel.navigateToPrivacyPolicy,
          ),
          _buildOptionTile(
            context: context,
            icon: Icons.description,
            title: 'Terms & Conditions',
            onTap: viewModel.navigateToTerms,
          ),
          const Divider(),
          _buildOptionTile(
            context: context,
            icon: Icons.logout,
            title: 'Logout',
            iconColor: Colors.red,
            titleColor: Colors.red,
            onTap: viewModel.logout,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    Color? iconColor,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: iconColor ?? kcPrimaryColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: titleColor,
            ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
