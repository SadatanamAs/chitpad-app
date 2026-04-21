import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/providers/app_providers.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../home_controller.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tc = ref.watch(themeProvider);
    final controller = ref.watch(homeProvider);
    final colors = tc.colors;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Facebook-style profile header ──────────────────────────────
          _FacebookProfileHeader(
            controller: controller,
            colors: colors,
            ref: ref,
          ),

          const SizedBox(height: 20),

          // Preferences section
          _SectionLabel(label: 'PREFERENCES', colors: colors),
          _SettingsCard(
            colors: colors,
            children: [
              _SettingsRow(
                icon: Icons.palette_outlined,
                label: 'Theme',
                value: tc.colors.label,
                iconBg: colors.accentLight,
                iconColor: colors.accent,
                onTap: () => Get.toNamed(AppRoutes.appearance),
                ref: ref,
              ),
              _SettingsRow(
                icon: Icons.notifications_outlined,
                label: 'Notifications',
                value: 'On',
                iconBg: colors.tagPersonalBg,
                iconColor: colors.tagPersonal,
                onTap: () => Get.toNamed(AppRoutes.notifications),
                ref: ref,
              ),
              _SettingsRow(
                icon: Icons.display_settings_outlined,
                label: 'Appearance',
                iconBg: colors.tagIdeasBg,
                iconColor: colors.tagIdeas,
                onTap: () => Get.toNamed(AppRoutes.appearance),
                isLast: true,
                ref: ref,
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Account section
          _SectionLabel(label: 'ACCOUNT', colors: colors),
          _SettingsCard(
            colors: colors,
            children: [
              _SettingsRow(
                icon: Icons.person_outline,
                label: 'Edit profile',
                iconBg: colors.tagWorkBg,
                iconColor: colors.tagWork,
                onTap: () => Get.toNamed(AppRoutes.editProfile),
                ref: ref,
              ),
              _SettingsRow(
                icon: Icons.shield_outlined,
                label: 'Privacy & security',
                iconBg: colors.accentLight,
                iconColor: colors.accent,
                onTap: () => Get.toNamed(AppRoutes.privacy),
                ref: ref,
              ),
              _SettingsRow(
                icon: Icons.cloud_upload_outlined,
                label: 'Backup & sync',
                value: 'On',
                iconBg: colors.tagIdeasBg,
                iconColor: colors.tagIdeas,
                onTap: () => Get.snackbar(
                  '📤',
                  'Backup complete!',
                  snackPosition: SnackPosition.TOP,
                ),
                isLast: true,
                ref: ref,
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Danger zone
          _SectionLabel(label: 'DANGER ZONE', colors: colors),
          _SettingsCard(
            colors: colors,
            children: [
              _SettingsRow(
                icon: Icons.logout_rounded,
                label: 'Sign out',
                isDestructive: true,
                iconBg: colors.dangerBg,
                iconColor: colors.danger,
                onTap: controller.signOut,
                isLast: true,
                ref: ref,
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Facebook-style Profile Header
//
// Layout (mirrors Facebook mobile):
//   ┌──────────────────────────────────────────┐
//   │         Cover photo / gradient            │  ← 190px tall
//   │                          [📷 Edit cover] │
//   └──────────────────────────────────────────┘
//   │  ◉ Avatar (left, half-overlaps cover)
//   │  [Edit Profile]    ← top-right of info row
//   │  Name
//   │  @username
//   │  bio text
// ─────────────────────────────────────────────────────────────────────────────
class _FacebookProfileHeader extends StatelessWidget {
  final HomeController controller;
  final dynamic colors;
  final WidgetRef ref;

  const _FacebookProfileHeader({
    required this.controller,
    required this.colors,
    required this.ref,
  });

  static const double _coverHeight = 190.0;
  static const double _avatarSize = 90.0;
  static const double _avatarBorderW = 4.0;
  static const double _avatarLeft = 16.0;

  void _openPicker(BuildContext context) {
    _showAvatarPicker(context, ref, controller, colors);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Cover + Avatar Stack ───────────────────────────────────────
        Stack(
          clipBehavior: Clip.none,
          children: [
            // ── Cover photo ────────────────────────────────────────────
            Container(
              width: double.infinity,
              height: _coverHeight,
              decoration: BoxDecoration(
                gradient: controller.isCoverSolid
                    ? null
                    : LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: controller.coverColors,
                      ),
                color: controller.isCoverSolid
                    ? controller.coverColors.first
                    : null,
              ),
              // "Edit cover" pill button — bottom-right (Facebook style)
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: GestureDetector(
                    onTap: () => _openPicker(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.42),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.camera_alt_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Edit cover',
                            style: GoogleFonts.nunito(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Avatar — bottom-left, half-overlapping cover ────────────
            Positioned(
              left: _avatarLeft,
              top: _coverHeight - (_avatarSize / 2), // half below cover
              child: Stack(
                children: [
                  // Avatar circle
                  GestureDetector(
                    onTap: () => _openPicker(context),
                    child: Container(
                      width: _avatarSize,
                      height: _avatarSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            AppColors.avatarColors[controller.avatarColorIndex %
                                AppColors.avatarColors.length],
                        border: Border.all(
                          color: colors.bg,
                          width: _avatarBorderW,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: controller.selectedImagePath != null
                            ? Image.file(
                                File(controller.selectedImagePath!),
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Text(
                                  controller.userInitials,
                                  style: GoogleFonts.nunito(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),

                  // Camera badge — bottom-right of avatar circle
                  Positioned(
                    right: 0,
                    bottom: 2,
                    child: GestureDetector(
                      onTap: () => _openPicker(context),
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: colors.bg2,
                          shape: BoxShape.circle,
                          border: Border.all(color: colors.bg, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 13,
                          color: colors.text2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // ── Spacer: accommodate the avatar overhang ────────────────────
        const SizedBox(height: _avatarSize / 2 + 10),

        // ── Name row + "Edit Profile" button (Facebook layout) ─────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name / username / bio — left-aligned
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.userDisplayName,
                      style: GoogleFonts.nunito(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: colors.text,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      controller.userUsername,
                      style: GoogleFonts.dmMono(
                        fontSize: 12.5,
                        color: colors.text3,
                      ),
                    ),
                    if (controller.userBio.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(
                        controller.userBio,
                        style: GoogleFonts.nunito(
                          fontSize: 13.5,
                          color: colors.text2,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // "Edit Profile" button — top-right (like Facebook)
              OutlinedButton(
                onPressed: () => Get.toNamed(AppRoutes.editProfile),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colors.border, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Edit profile',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: colors.text,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAvatarPicker(
    BuildContext context,
    WidgetRef ref,
    HomeController controller,
    dynamic colors,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Change profile photo',
              style: GoogleFonts.nunito(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: colors.text,
              ),
            ),
            const SizedBox(height: 14),
            // Gallery
            _PickerTile(
              icon: Icons.photo_library_outlined,
              label: 'Choose from gallery',
              sub: 'Pick a photo from your device',
              colors: colors,
              onTap: () async {
                Get.back();
                try {
                  await controller.pickProfileImage(ImageSource.gallery);
                } catch (_) {
                  Get.snackbar(
                    'Permission denied',
                    'Could not access your photos',
                    snackPosition: SnackPosition.TOP,
                  );
                }
              },
            ),
            const SizedBox(height: 6),
            // Camera
            _PickerTile(
              icon: Icons.camera_alt_outlined,
              label: 'Take a photo',
              sub: 'Use your camera',
              colors: colors,
              onTap: () async {
                Get.back();
                try {
                  await controller.pickProfileImage(ImageSource.camera);
                } catch (_) {
                  Get.snackbar(
                    'Permission denied',
                    'Could not access your camera',
                    snackPosition: SnackPosition.TOP,
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            // Avatar colour swatches
            Text(
              'or pick a colour',
              style: GoogleFonts.dmMono(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: colors.text3,
                letterSpacing: 0.7,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(AppColors.avatarColors.length, (i) {
                final isSelected = controller.avatarColorIndex == i;
                return GestureDetector(
                  onTap: () {
                    controller.setAvatarColor(i);
                    Get.back();
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.avatarColors[i],
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: colors.text, width: 3)
                          : null,
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;
  final dynamic colors;
  final VoidCallback onTap;

  const _PickerTile({
    required this.icon,
    required this.label,
    required this.sub,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colors.accentLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: colors.accent, size: 20),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: colors.text,
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.dmMono(
                    fontSize: 11.5,
                    color: colors.text3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helper widgets
// ─────────────────────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  final dynamic colors;
  const _SectionLabel({required this.label, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
      child: Text(
        label,
        style: GoogleFonts.dmMono(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: colors.text3,
          letterSpacing: 0.7,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final dynamic colors;
  final List<Widget> children;
  const _SettingsCard({required this.colors, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.border),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback onTap;
  final bool isLast;
  final bool isDestructive;
  final WidgetRef ref;

  const _SettingsRow({
    required this.icon,
    required this.label,
    this.value,
    required this.iconBg,
    required this.iconColor,
    required this.onTap,
    this.isLast = false,
    this.isDestructive = false,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final tc = ref.watch(themeProvider);
    final colors = tc.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? const BorderRadius.vertical(bottom: Radius.circular(14))
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(bottom: BorderSide(color: colors.border)),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDestructive ? colors.danger : colors.text,
                    ),
                  ),
                  if (value != null)
                    Text(
                      value!,
                      style: GoogleFonts.dmMono(
                        fontSize: 12,
                        color: colors.text3,
                      ),
                    ),
                ],
              ),
            ),
            if (!isDestructive)
              Icon(Icons.chevron_right, size: 20, color: colors.text3),
          ],
        ),
      ),
    );
  }
}
