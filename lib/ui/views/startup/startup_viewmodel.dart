import 'package:stacked/stacked.dart';
import 'package:siakap/app/app.locator.dart';
import 'package:siakap/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 2));

    // Here you would check if the user has completed onboarding
    // and if they are logged in
    bool hasCompletedOnboarding = false;
    bool isLoggedIn = false;

    if (!hasCompletedOnboarding) {
      _navigationService.replaceWith(Routes.onboardingView);
    } else if (!isLoggedIn) {
      _navigationService.replaceWith(Routes.loginView);
    } else {
      _navigationService.replaceWith(Routes.homeView);
    }
  }
}
