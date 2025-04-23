import 'package:siakap/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:siakap/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:siakap/ui/views/forgot_password/forgot_password_view.dart';
import 'package:siakap/ui/views/home/home_view.dart';
import 'package:siakap/ui/views/login/login_view.dart';
import 'package:siakap/ui/views/menu/menu_view.dart';
import 'package:siakap/ui/views/onboarding/onboarding_view.dart';
import 'package:siakap/ui/views/product_detail/product_detail_view.dart';
import 'package:siakap/ui/views/register/register_view.dart';
import 'package:siakap/ui/views/startup/startup_view.dart';
import 'package:siakap/ui/views/cart/cart_view.dart';
import 'package:siakap/ui/views/loyalty/loyalty_view.dart';
import 'package:siakap/ui/views/profile/profile_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: ForgotPasswordView),
    MaterialRoute(page: MenuView),
    MaterialRoute(page: ProductDetailView),
    MaterialRoute(page: CartView),
    MaterialRoute(page: LoyaltyView),
    MaterialRoute(page: ProfileView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
