import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/theme/app_theme.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/providers/app_providers.dart';

class AppearanceView extends ConsumerWidget {
  const AppearanceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tc = ref.watch(themeProvider);
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
                  Expanded(
                    child: Text(
                      'Appearance',
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

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'THEME',
                      style: GoogleFonts.dmMono(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: colors.text3,
                        letterSpacing: 0.7,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Theme grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.6,
                      children: ThemeController.allThemeIds.map((id) {
                        final scheme = AppColors.getScheme(id);
                        final isSelected = tc.currentThemeId == id;
                        return GestureDetector(
                          onTap: () => tc.setTheme(id),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: scheme.bg,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? colors.accent
                                    : colors.border,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    _swatch(scheme.accent),
                                    const SizedBox(width: 4),
                                    _swatch(scheme.bg2),
                                    const SizedBox(width: 4),
                                    _swatch(scheme.text),
                                  ],
                                ),
                                Text(
                                  scheme.label,
                                  style: GoogleFonts.dmMono(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: scheme.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'FONT SIZE',
                      style: GoogleFonts.dmMono(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: colors.text3,
                        letterSpacing: 0.7,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        color: colors.card,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: colors.border),
                      ),
                      child: Column(
                        children: [
                          _fontRow('Small', 'small', 13, colors, tc),
                          Divider(height: 1, color: colors.border),
                          _fontRow('Medium', 'medium', 14.5, colors, tc),
                          Divider(height: 1, color: colors.border),
                          _fontRow('Large', 'large', 17, colors, tc),
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

  Widget _swatch(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _fontRow(
    String label,
    String sizeId,
    double fontSize,
    dynamic colors,
    ThemeController tc,
  ) {
    final isSelected = tc.currentFontSize == sizeId;
    return InkWell(
      onTap: () => tc.setFontSize(sizeId),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.nunito(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: colors.text,
                ),
              ),
            ),
            if (isSelected)
              Text('✓', style: TextStyle(fontSize: 16, color: colors.accent)),
          ],
        ),
      ),
    );
  }
}
