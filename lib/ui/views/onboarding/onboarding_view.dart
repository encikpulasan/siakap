import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_strings.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'package:siakap/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';
import 'dart:ui' as ui;

class OnboardingView extends StackedView<OnboardingViewModel> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OnboardingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: viewModel.pageController,
                onPageChanged: viewModel.setCurrentPage,
                children: [
                  _OnboardingPage(
                    title: 'Welcome to ZAS Coffee',
                    description: 'Your daily brew, just a tap away.',
                    svgPath: 'assets/illustrations/onboarding1.svg',
                    animationDelay: 0,
                  ),
                  _OnboardingPage(
                    title: 'Order Ahead',
                    description: 'Skip the line by ordering ahead for pickup or delivery.',
                    svgPath: 'assets/illustrations/onboarding2.svg',
                    animationDelay: 0,
                  ),
                  _OnboardingPage(
                    title: 'Earn Rewards',
                    description: 'Collect points with every purchase and redeem for free drinks.',
                    svgPath: 'assets/illustrations/onboarding3.svg',
                    animationDelay: 0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: viewModel.pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: kcPrimaryColor,
                      dotColor: kcLightGrey,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 6,
                      expansionFactor: 3,
                    ),
                  ).animate().fadeIn(duration: const Duration(milliseconds: 600)),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (viewModel.currentPage != 0)
                        TextButton(
                          onPressed: viewModel.goToPreviousPage,
                          child: const Text('Back'),
                        ).animate().fadeIn(duration: const Duration(milliseconds: 400))
                      else
                        const SizedBox(width: 60),
                      AppButton(
                        title: viewModel.currentPage == 2 ? 'Get Started' : 'Next',
                        onTap: viewModel.currentPage == 2 ? viewModel.navigateToLogin : viewModel.goToNextPage,
                        width: 120,
                      ).animate().fadeIn(duration: const Duration(milliseconds: 400)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (viewModel.currentPage != 2)
                    TextButton(
                      onPressed: viewModel.navigateToLogin,
                      child: const Text('Skip'),
                    ).animate().fadeIn(duration: const Duration(milliseconds: 400)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  OnboardingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OnboardingViewModel();

  @override
  void onDispose(OnboardingViewModel viewModel) {
    super.onDispose(viewModel);
    viewModel.pageController.dispose();
  }
}

class _OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String svgPath;
  final int animationDelay;

  const _OnboardingPage({
    required this.title,
    required this.description,
    required this.svgPath,
    this.animationDelay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 300,
          )
              .animate(delay: Duration(milliseconds: 100 * animationDelay))
              .fadeIn(duration: const Duration(milliseconds: 600))
              .moveY(begin: 30, end: 0, duration: const Duration(milliseconds: 600), curve: Curves.easeOutQuad),
          const SizedBox(height: 48),
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          )
              .animate(delay: Duration(milliseconds: 200 * animationDelay + 100))
              .fadeIn(duration: const Duration(milliseconds: 600))
              .moveY(begin: 30, end: 0, duration: const Duration(milliseconds: 600), curve: Curves.easeOutQuad),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: kcSecondaryTextColor,
                ),
            textAlign: TextAlign.center,
          )
              .animate(delay: Duration(milliseconds: 200 * animationDelay + 200))
              .fadeIn(duration: const Duration(milliseconds: 600))
              .moveY(begin: 30, end: 0, duration: const Duration(milliseconds: 600), curve: Curves.easeOutQuad),
        ],
      ),
    );
  }
}

// Custom painter for steam effect
class SteamPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.6)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.75, size.height, size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
