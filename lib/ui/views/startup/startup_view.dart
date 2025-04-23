import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/illustrations/logo.svg',
              height: 160,
              width: 160,
            ).animate().fadeIn(duration: 800.ms).scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  duration: 1000.ms,
                  curve: Curves.easeOutBack,
                ),
            const SizedBox(height: 24),
            Text(
              ksAppName,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: kcPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ).animate(delay: 300.ms).fadeIn(duration: 800.ms),
            const SizedBox(height: 8),
            Text(
              ksAppTagline,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: kcSecondaryTextColor,
                  ),
              textAlign: TextAlign.center,
            ).animate(delay: 500.ms).fadeIn(duration: 800.ms),
            const SizedBox(height: 48),
            SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                color: kcPrimaryColor,
                strokeWidth: 3,
              ),
            ).animate(delay: 700.ms).fadeIn(duration: 800.ms),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance.addPostFrameCallback(
        (timeStamp) => viewModel.runStartupLogic(),
      );
}
