import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/providers/app_providers.dart';
import '../../../app/theme/app_colors.dart';
import '../settings_controller.dart';

class EditProfileView extends ConsumerWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tc = ref.watch(themeProvider);
    final controller = ref.watch(settingsProvider);
    final colors = tc.colors;

    return Scaffold(
      backgroundColor: colors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: colors.card,
                border: Border(bottom: BorderSide(color: colors.border)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: colors.card2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 14,
                        color: colors.text2,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Edit profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 34),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Cover
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors:
                              AppColors.coverGradients[controller
                                      .coverGradientIndex %
                                  AppColors.coverGradients.length],
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Cover gradient + color picker
                          Positioned(
                            right: 10,
                            bottom: 8,
                            child: GestureDetector(
                              onTap: () => _showCoverColorPicker(
                                context,
                                controller,
                                colors,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.palette,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Color',
                                      style: GoogleFonts.nunito(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Avatar
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: -28,
                            child: Center(
                              child: GestureDetector(
                                onTap: () => _showAvatarPicker(
                                  context,
                                  controller,
                                  colors,
                                ),
                                child: Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        AppColors.avatarColors[controller
                                                .avatarColorIndex %
                                            AppColors.avatarColors.length],
                                    border: Border.all(
                                      color: colors.bg,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.15,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Builder(
                                      builder: (_) {
                                        final name = controller.displayName;
                                        final initials = name
                                            .trim()
                                            .split(' ')
                                            .map(
                                              (w) => w.isNotEmpty ? w[0] : '',
                                            )
                                            .join('')
                                            .toUpperCase();
                                        return Text(
                                          initials.isEmpty
                                              ? '?'
                                              : initials.substring(
                                                  0,
                                                  initials.length.clamp(0, 2),
                                                ),
                                          style: GoogleFonts.nunito(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _field(
                            'DISPLAY NAME',
                            controller.displayNameCtrl,
                            colors,
                          ),
                          _field('USERNAME', controller.usernameCtrl, colors),
                          _field(
                            'EMAIL',
                            controller.emailCtrl,
                            colors,
                            inputType: TextInputType.emailAddress,
                          ),
                          _textArea('BIO', controller.bioCtrl, colors),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.saveProfile();
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.accent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: Text(
                                'Save changes',
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAvatarPicker(
    BuildContext context,
    SettingsController controller,
    dynamic colors,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Avatar color',
              style: GoogleFonts.nunito(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: colors.text,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Choose a solid color for your avatar',
              style: GoogleFonts.dmMono(fontSize: 12, color: colors.text3),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showCoverColorPicker(
    BuildContext context,
    SettingsController controller,
    dynamic colors,
  ) {
    // Also pick solid cover colors (not just gradients)
    final coverColors = [
      const Color(0xFF3B3BE8),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEF4444),
      const Color(0xFF8B5CF6),
      const Color(0xFFEC4899),
      const Color(0xFF06B6D4),
      const Color(0xFF84CC16),
      const Color(0xFF1A1A2E),
      const Color(0xFF2D1B00),
      const Color(0xFF0F2027),
      const Color(0xFF1C0A1A),
    ];

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cover color',
              style: GoogleFonts.nunito(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: colors.text,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pick a solid color for your cover',
              style: GoogleFonts.dmMono(fontSize: 12, color: colors.text3),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(coverColors.length, (i) {
                final isSelected = controller.coverGradientIndex == i;
                return GestureDetector(
                  onTap: () {
                    controller.setCoverColor(i);
                    Get.back();
                  },
                  child: Container(
                    width: 52,
                    height: 36,
                    decoration: BoxDecoration(
                      color: coverColors[i],
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: colors.text, width: 2.5)
                          : Border.all(color: colors.border),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 18)
                        : null,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Text(
              'Or choose a gradient',
              style: GoogleFonts.dmMono(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: colors.text3,
                letterSpacing: 0.7,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(AppColors.coverGradients.length, (i) {
                final isSelected =
                    controller.coverGradientIndex == coverColors.length + i;
                return GestureDetector(
                  onTap: () {
                    controller.setCoverGradient(coverColors.length + i);
                    Get.back();
                  },
                  child: Container(
                    width: 52,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: AppColors.coverGradients[i],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: colors.text, width: 2.5)
                          : Border.all(color: colors.border),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 18)
                        : null,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController textController,
    dynamic colors, {
    TextInputType? inputType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.dmMono(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: colors.text3,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: textController,
            keyboardType: inputType,
            style: GoogleFonts.nunito(fontSize: 14, color: colors.text),
            decoration: InputDecoration(
              filled: true,
              fillColor: colors.card2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.border, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textArea(
    String label,
    TextEditingController textController,
    dynamic colors,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.dmMono(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: colors.text3,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: textController,
            maxLines: 3,
            style: GoogleFonts.nunito(fontSize: 14, color: colors.text),
            decoration: InputDecoration(
              filled: true,
              fillColor: colors.card2,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colors.border, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
