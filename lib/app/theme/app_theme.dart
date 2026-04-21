import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class ThemeController extends ChangeNotifier {
  String _currentThemeId = 'light';
  String _currentFontSize = 'medium';

  String get currentThemeId => _currentThemeId;
  String get currentFontSize => _currentFontSize;

  ChitpadColorScheme get colors => AppColors.getScheme(_currentThemeId);

  static const allThemeIds = [
    'light',
    'dark',
    'solarized',
    'rosepine',
    'nord',
    'catppuccin',
  ];

  double get noteFontSize {
    switch (_currentFontSize) {
      case 'small':
        return 13.0;
      case 'large':
        return 16.0;
      default:
        return 14.5;
    }
  }

  void setTheme(String id) {
    _currentThemeId = id;
    final isDark = ['dark', 'rosepine', 'catppuccin'].contains(id);
    Get.changeTheme(isDark ? AppTheme.dark : AppTheme.light);
    notifyListeners();
  }

  void setFontSize(String size) {
    _currentFontSize = size;
    notifyListeners();
  }
}

class AppTheme {
  static final _baseTextTheme = GoogleFonts.nunitoTextTheme();

  static ThemeData get light {
    const c = AppColors.light;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: c.bg,
      colorScheme: ColorScheme.light(
        primary: c.accent,
        secondary: c.accent,
        surface: c.card,
        error: c.danger,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: c.text,
        onError: Colors.white,
      ),
      textTheme: _baseTextTheme.apply(bodyColor: c.text, displayColor: c.text),
      appBarTheme: AppBarTheme(
        backgroundColor: c.card,
        foregroundColor: c.text,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: c.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: c.border),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: c.card,
        selectedItemColor: c.accent,
        unselectedItemColor: c.text3,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.card2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.danger, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        hintStyle: TextStyle(color: c.text3, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.accent,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: GoogleFonts.nunito(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(color: c.border, thickness: 1),
    );
  }

  static ThemeData get dark {
    const c = AppColors.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: c.bg,
      colorScheme: ColorScheme.dark(
        primary: c.accent,
        secondary: c.accent,
        surface: c.card,
        error: c.danger,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: c.text,
        onError: Colors.white,
      ),
      textTheme: _baseTextTheme.apply(bodyColor: c.text, displayColor: c.text),
      appBarTheme: AppBarTheme(
        backgroundColor: c.card,
        foregroundColor: c.text,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: c.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: c.border),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: c.card,
        selectedItemColor: c.accent,
        unselectedItemColor: c.text3,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.card2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c.danger, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        hintStyle: TextStyle(color: c.text3, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.accent,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: GoogleFonts.nunito(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(color: c.border, thickness: 1),
    );
  }
}
