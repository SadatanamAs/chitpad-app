import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/providers/app_providers.dart';

class PrivacyView extends ConsumerWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tc = ref.watch(themeProvider);
    final colors = tc.colors;

    return Scaffold(
      backgroundColor: colors.bg,
      body: SafeArea(
        child: Column(
          children: [
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
                  Expanded(
                    child: Text(
                      'Privacy & security',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: colors.text,
                      ),
                    ),
                  ),
                  const SizedBox(width: 34),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors.border),
                ),
                child: Column(
                  children: [
                    _row(
                      Icons.fingerprint,
                      'Biometric lock',
                      'Off',
                      colors.accentLight,
                      colors.accent,
                      colors,
                      () => Get.snackbar(
                        '🔒',
                        'Biometric lock enabled',
                        snackPosition: SnackPosition.TOP,
                      ),
                    ),
                    Divider(height: 1, color: colors.border),
                    _row(
                      Icons.key_rounded,
                      'Change password',
                      null,
                      colors.tagWorkBg,
                      colors.tagWork,
                      colors,
                      () => Get.snackbar(
                        '🔑',
                        'Change password flow coming!',
                        snackPosition: SnackPosition.TOP,
                      ),
                    ),
                    Divider(height: 1, color: colors.border),
                    _row(
                      Icons.delete_outline_rounded,
                      'Delete account',
                      null,
                      colors.dangerBg,
                      colors.danger,
                      colors,
                      () => Get.snackbar(
                        '🗑',
                        'Account deletion requires email confirmation',
                        snackPosition: SnackPosition.TOP,
                      ),
                      isDestructive: true,
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

  Widget _row(
    IconData icon,
    String label,
    String? value,
    Color iconBg,
    Color iconColor,
    dynamic colors,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
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
                      value,
                      style: GoogleFonts.dmMono(
                        fontSize: 12,
                        color: colors.text3,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: isDestructive ? colors.danger : colors.text3,
            ),
          ],
        ),
      ),
    );
  }
}
