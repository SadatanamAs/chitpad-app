import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../data/providers/mock_data_service.dart';
import '../../app/providers/app_providers.dart';

class SettingsController extends ChangeNotifier {
  final Ref ref;

  SettingsController(this.ref) {
    _init();
  }

  MockDataService get _mock => ref.read(mockDataServiceProvider);

  // Edit profile fields
  String displayName = '';
  String username = '';
  String email = '';
  String bio = '';

  late TextEditingController displayNameCtrl;
  late TextEditingController usernameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController bioCtrl;

  // Notification toggles
  bool dailyReminder = true;
  bool weeklyDigest = false;
  bool syncNotifications = true;

  // Avatar & cover
  int avatarColorIndex = 0;
  int coverGradientIndex = 0;

  void _init() {
    displayNameCtrl = TextEditingController();
    usernameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    bioCtrl = TextEditingController();

    final user = _mock.currentUser;
    if (user != null) {
      displayName = user.displayName;
      displayNameCtrl.text = user.displayName;

      username = user.username;
      usernameCtrl.text = user.username;

      email = user.email;
      emailCtrl.text = user.email;

      bio = user.bio;
      bioCtrl.text = user.bio;

      avatarColorIndex = user.avatarColorIndex;
      coverGradientIndex = user.coverGradientIndex;
    }

    displayNameCtrl.addListener(() {
      displayName = displayNameCtrl.text;
      notifyListeners();
    });
    usernameCtrl.addListener(() {
      username = usernameCtrl.text;
      notifyListeners();
    });
    emailCtrl.addListener(() {
      email = emailCtrl.text;
      notifyListeners();
    });
    bioCtrl.addListener(() {
      bio = bioCtrl.text;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    displayNameCtrl.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();
    bioCtrl.dispose();
    super.dispose();
  }

  void toggleDailyReminder() {
    dailyReminder = !dailyReminder;
    notifyListeners();
  }

  void toggleWeeklyDigest() {
    weeklyDigest = !weeklyDigest;
    notifyListeners();
  }

  void toggleSyncNotifications() {
    syncNotifications = !syncNotifications;
    notifyListeners();
  }

  void setAvatarColor(int index) {
    avatarColorIndex = index;
    notifyListeners();
  }

  void setCoverGradient(int index) {
    coverGradientIndex = index;
    notifyListeners();
  }

  void setCoverColor(int index) {
    coverGradientIndex = index;
    notifyListeners();
  }

  void saveProfile() {
    final user = _mock.currentUser;
    if (user != null) {
      user.displayName = displayName.trim();
      user.username = username.trim();
      user.email = email.trim();
      user.bio = bio.trim();
      user.avatarColorIndex = avatarColorIndex;
      user.coverGradientIndex = coverGradientIndex;

      // Notify HomeController so ProfileTab re-renders with new user data
      ref.read(homeProvider.notifier).notifyListeners();

      Get.snackbar(
        'Profile updated!',
        '',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      Get.back();
    }
  }
}
