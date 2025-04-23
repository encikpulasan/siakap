import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:siakap/ui/common/app_strings.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'package:siakap/ui/views/forgot_password/forgot_password_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StackedView<ForgotPasswordViewModel> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ForgotPasswordViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ksForgotPasswordTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                ).animate().fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 16),
                Text(
                  'Enter your email address and we\'ll send you a link to reset your password',
                  style: Theme.of(context).textTheme.bodyMedium,
                ).animate(delay: 100.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 32),
                RoundedTextField(
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  controller: viewModel.emailController,
                  keyboardType: TextInputType.emailAddress,
                ).animate(delay: 200.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 32),
                AppButton(
                  title: 'Send Reset Link',
                  onTap: viewModel.sendResetLink,
                  isLoading: viewModel.isBusy,
                ).animate(delay: 300.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                if (viewModel.isSuccess)
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Password reset link sent to your email.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.green,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ForgotPasswordViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ForgotPasswordViewModel();

  @override
  void onDispose(ForgotPasswordViewModel viewModel) {
    super.onDispose(viewModel);
    viewModel.emailController.dispose();
  }
}
