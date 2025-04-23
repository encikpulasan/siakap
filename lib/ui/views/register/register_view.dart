import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_strings.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'package:siakap/ui/views/register/register_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
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
                Center(
                  child: SvgPicture.asset(
                    'assets/illustrations/logo.svg',
                    height: 80,
                  ),
                ).animate().fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 32),
                Text(
                  ksRegisterTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                ).animate(delay: 100.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 16),
                Text(
                  'Create an account to get started with ZAS Coffee',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: kcSecondaryTextColor,
                      ),
                ).animate(delay: 150.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 32),
                RoundedTextField(
                  hintText: 'Full Name',
                  prefixIcon: Icons.person_outline,
                  controller: viewModel.nameController,
                ).animate(delay: 200.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 16),
                RoundedTextField(
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  controller: viewModel.emailController,
                  keyboardType: TextInputType.emailAddress,
                ).animate(delay: 250.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 16),
                RoundedTextField(
                  hintText: 'Phone Number',
                  prefixIcon: Icons.phone_outlined,
                  controller: viewModel.phoneController,
                  keyboardType: TextInputType.phone,
                ).animate(delay: 300.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 16),
                RoundedTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: viewModel.obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  onSuffixIconTap: viewModel.togglePasswordVisibility,
                  controller: viewModel.passwordController,
                  obscureText: viewModel.obscurePassword,
                ).animate(delay: 350.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 16),
                RoundedTextField(
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: viewModel.obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  onSuffixIconTap: viewModel.toggleConfirmPasswordVisibility,
                  controller: viewModel.confirmPasswordController,
                  obscureText: viewModel.obscureConfirmPassword,
                ).animate(delay: 400.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Checkbox(
                      value: viewModel.agreeToTerms,
                      onChanged: (value) => viewModel.setAgreeToTerms(value ?? false),
                      activeColor: kcPrimaryColor,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            const TextSpan(
                              text: 'I agree to the ',
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: viewModel.navigateToTermsAndConditions,
                                child: Text(
                                  'Terms and Conditions',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: kcPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            const TextSpan(
                              text: ' and ',
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: viewModel.navigateToPrivacyPolicy,
                                child: Text(
                                  'Privacy Policy',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: kcPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).animate(delay: 450.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 32),
                AppButton(
                  title: 'Register',
                  onTap: viewModel.register,
                  isLoading: viewModel.isBusy,
                ).animate(delay: 500.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: viewModel.navigateToLogin,
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: kcPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ).animate(delay: 550.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel();

  @override
  void onDispose(RegisterViewModel viewModel) {
    super.onDispose(viewModel);
    viewModel.nameController.dispose();
    viewModel.emailController.dispose();
    viewModel.phoneController.dispose();
    viewModel.passwordController.dispose();
    viewModel.confirmPasswordController.dispose();
  }
}
