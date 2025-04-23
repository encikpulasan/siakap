import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class Reward {
  final String id;
  final String title;
  final String description;
  final int pointsRequired;

  Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsRequired,
  });
}

class PointsHistoryItem {
  final String id;
  final String title;
  final String date;
  final int points;

  PointsHistoryItem({
    required this.id,
    required this.title,
    required this.date,
    required this.points,
  });
}

class LoyaltyViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  // Member details (would normally come from backend)
  final String _memberName = 'John Doe';
  final String _memberSince = 'June 2022';
  final String _membershipTier = 'GOLD';
  final int _points = 720;

  // Next reward details
  final int _pointsToNextReward = 80;
  final String _nextRewardTitle = 'Free Large Cappuccino';
  final String _nextRewardDescription = 'Redeem a free large cappuccino at any ZAS Coffee outlet';

  // Getters
  String get memberName => _memberName;
  String get memberSince => _memberSince;
  String get membershipTier => _membershipTier;
  int get points => _points;
  int get pointsToNextReward => _pointsToNextReward;
  String get nextRewardTitle => _nextRewardTitle;
  String get nextRewardDescription => _nextRewardDescription;
  double get progressToNextReward => (_points % 800) / 800; // Assuming 800 points needed for next reward

  // Available rewards
  final List<Reward> _availableRewards = [
    Reward(
      id: '1',
      title: 'Free Cappuccino',
      description: 'Redeem a free regular cappuccino',
      pointsRequired: 500,
    ),
    Reward(
      id: '2',
      title: 'Free Croissant',
      description: 'Redeem a free butter croissant',
      pointsRequired: 300,
    ),
    Reward(
      id: '3',
      title: 'Free Latte',
      description: 'Redeem a free regular latte',
      pointsRequired: 500,
    ),
    Reward(
      id: '4',
      title: 'Free Cake Slice',
      description: 'Redeem a free slice of cake',
      pointsRequired: 700,
    ),
    Reward(
      id: '5',
      title: '50% Off Any Drink',
      description: 'Get 50% off any drink',
      pointsRequired: 400,
    ),
  ];

  List<Reward> get availableRewards => _availableRewards;

  // Points history
  final List<PointsHistoryItem> _history = [
    PointsHistoryItem(
      id: '1',
      title: 'Purchase at ZAS Coffee KLCC',
      date: 'May 12, 2023',
      points: 120,
    ),
    PointsHistoryItem(
      id: '2',
      title: 'Redeemed Free Cappuccino',
      date: 'May 5, 2023',
      points: -500,
    ),
    PointsHistoryItem(
      id: '3',
      title: 'Purchase at ZAS Coffee Bukit Bintang',
      date: 'May 1, 2023',
      points: 150,
    ),
    PointsHistoryItem(
      id: '4',
      title: 'Birthday Bonus',
      date: 'April 15, 2023',
      points: 200,
    ),
  ];

  List<PointsHistoryItem> get history => _history;

  void viewAllRewards() {
    // Navigate to rewards page
  }

  void viewAllHistory() {
    // Navigate to history page
  }

  void selectReward(Reward reward) {
    if (points >= reward.pointsRequired) {
      // Show confirmation dialog
    }
  }
}
