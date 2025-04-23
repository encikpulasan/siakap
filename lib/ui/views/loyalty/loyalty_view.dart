import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'loyalty_viewmodel.dart';

class LoyaltyView extends StackedView<LoyaltyViewModel> {
  const LoyaltyView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoyaltyViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loyalty Program'),
        elevation: 0,
      ),
      body: SafeArea(
        child: viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMembershipCard(context, viewModel),
                    _buildPointsProgress(context, viewModel),
                    _buildRewardsList(context, viewModel),
                    _buildHistorySection(context, viewModel),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildMembershipCard(BuildContext context, LoyaltyViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kcPrimaryColor, Colors.brown.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ZAS COFFEE',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'REWARDS PROGRAM',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  viewModel.membershipTier,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.memberName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Member since ${viewModel.memberSince}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    viewModel.points.toString(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'POINTS',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointsProgress(BuildContext context, LoyaltyViewModel viewModel) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Next Reward',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${viewModel.pointsToNextReward} points to go',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: kcPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: viewModel.progressToNextReward,
            backgroundColor: Colors.grey.shade200,
            color: kcPrimaryColor,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 16),
          Text(
            viewModel.nextRewardTitle,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          Text(
            viewModel.nextRewardDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsList(BuildContext context, LoyaltyViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Rewards',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: viewModel.viewAllRewards,
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.availableRewards.length,
              itemBuilder: (context, index) {
                final reward = viewModel.availableRewards[index];
                return Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => viewModel.selectReward(reward),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: kcPrimaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${reward.pointsRequired} POINTS',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: kcPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              reward.title,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              reward.description,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (viewModel.points >= reward.pointsRequired)
                                  Text(
                                    'Redeem',
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          color: kcPrimaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  )
                                else
                                  Text(
                                    'Not Enough Points',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context, LoyaltyViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Points History',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: viewModel.viewAllHistory,
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.history.length.clamp(0, 3),
            itemBuilder: (context, index) {
              final item = viewModel.history[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.points > 0 ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    item.points > 0 ? Icons.add_circle_outline : Icons.remove_circle_outline,
                    color: item.points > 0 ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(item.title),
                subtitle: Text(item.date),
                trailing: Text(
                  '${item.points > 0 ? '+' : ''}${item.points} pts',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: item.points > 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  LoyaltyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoyaltyViewModel();
}
