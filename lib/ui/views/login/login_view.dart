import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_strings.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'package:siakap/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Center(
                  child: SvgPicture.asset(
                    'assets/illustrations/logo.svg',
                    height: 100,
                  ),
                ).animate().fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 48),
                Text(
                  ksLoginTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                ).animate(delay: 100.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 24),
                RoundedTextField(
                  hintText: 'Email or Phone Number',
                  prefixIcon: Icons.email_outlined,
                  controller: viewModel.emailController,
                  keyboardType: TextInputType.emailAddress,
                ).animate(delay: 200.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 16),
                RoundedTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: viewModel.obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  onSuffixIconTap: viewModel.togglePasswordVisibility,
                  controller: viewModel.passwordController,
                  obscureText: viewModel.obscurePassword,
                ).animate(delay: 300.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: viewModel.navigateToForgotPassword,
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: kcPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ).animate(delay: 400.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 32),
                AppButton(
                  title: 'Login',
                  onTap: viewModel.login,
                  isLoading: viewModel.isBusy,
                ).animate(delay: 500.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 32),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: kcLightGrey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: kcLightGrey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ).animate(delay: 600.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialLoginButton(
                      imagePath: 'assets/images/google.png',
                      onTap: viewModel.loginWithGoogle,
                    ),
                    const SizedBox(width: 24),
                    _SocialLoginButton(
                      imagePath: 'assets/images/facebook.png',
                      onTap: viewModel.loginWithFacebook,
                    ),
                    const SizedBox(width: 24),
                    _SocialLoginButton(
                      imagePath: 'assets/images/apple.png',
                      onTap: viewModel.loginWithApple,
                    ),
                  ],
                ).animate(delay: 700.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: viewModel.navigateToRegister,
                      child: Text(
                        'Register',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: kcPrimaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ).animate(delay: 800.ms).fadeIn(duration: 600.ms).moveY(begin: 30, end: 0, duration: 600.ms, curve: Curves.easeOutQuad),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();

  @override
  void onDispose(LoginViewModel viewModel) {
    super.onDispose(viewModel);
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const _SocialLoginButton({
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kcVeryLightGrey, width: 1),
        ),
        child: Image.asset(
          imagePath,
          height: 28,
          width: 28,
        ),
      ),
    );
  }
}
