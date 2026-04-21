import 'package:get/get.dart';
import 'app_routes.dart';
import '../widgets/splash_screen.dart';
import '../../modules/auth/views/login_view.dart';
import '../../modules/auth/views/register_view.dart';
import '../../modules/auth/views/forgot_password_view.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/note_editor/note_editor_view.dart';
import '../../modules/settings/views/edit_profile_view.dart';
import '../../modules/settings/views/appearance_view.dart';
import '../../modules/settings/views/notifications_view.dart';
import '../../modules/settings/views/privacy_view.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.noteEditor,
      page: () => const NoteEditorView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.newNote,
      page: () => const NoteEditorView(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.appearance,
      page: () => const AppearanceView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.privacy,
      page: () => const PrivacyView(),
      transition: Transition.rightToLeft,
    ),
  ];
}
