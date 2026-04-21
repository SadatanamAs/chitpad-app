import 'package:flutter/material.dart';

class AppColors {
  // Light theme
  static const light = _LightColors();
  static const dark = _DarkColors();
  static const solarized = _SolarizedColors();
  static const rosepine = _RosePineColors();
  static const nord = _NordColors();
  static const catppuccin = _CatppuccinColors();

  static ChitpadColorScheme getScheme(String themeId) {
    switch (themeId) {
      case 'dark':
        return dark;
      case 'solarized':
        return solarized;
      case 'rosepine':
        return rosepine;
      case 'nord':
        return nord;
      case 'catppuccin':
        return catppuccin;
      default:
        return light;
    }
  }

  // Predefined avatar background colors
  static const List<Color> avatarColors = [
    Color(0xFF3B3BE8), // accent blue
    Color(0xFF10B981), // emerald
    Color(0xFFF59E0B), // amber
    Color(0xFFEF4444), // red
    Color(0xFF8B5CF6), // violet
    Color(0xFF06B6D4), // cyan
    Color(0xFFEC4899), // pink
    Color(0xFF84CC16), // lime
  ];

  // Predefined cover gradients (pairs of colors)
  static const List<List<Color>> coverGradients = [
    [Color(0xFF3B3BE8), Color(0xFF818CF8)], // blue-purple
    [Color(0xFF10B981), Color(0xFF34D399)], // emerald
    [Color(0xFFF59E0B), Color(0xFFFBBF24)], // amber
    [Color(0xFFEF4444), Color(0xFFF87171)], // red
    [Color(0xFF8B5CF6), Color(0xFFA78BFA)], // violet
    [Color(0xFFEC4899), Color(0xFFF472B6)], // pink
    [Color(0xFF06B6D4), Color(0xFF22D3EE)], // cyan
    [Color(0xFF84CC16), Color(0xFFA3E635)], // lime
  ];
}

abstract class ChitpadColorScheme {
  Color get bg;
  Color get bg2;
  Color get bg3;
  Color get card;
  Color get card2;
  Color get text;
  Color get text2;
  Color get text3;
  Color get border;
  Color get accent;
  Color get accentLight;
  Color get star;
  Color get danger;
  Color get dangerBg;
  Color get tagWorkBg;
  Color get tagWork;
  Color get tagPersonalBg;
  Color get tagPersonal;
  Color get tagIdeasBg;
  Color get tagIdeas;
  String get id;
  String get label;
}

class _LightColors implements ChitpadColorScheme {
  const _LightColors();
  @override
  Color get bg => const Color(0xFFF7F6F3);
  @override
  Color get bg2 => const Color(0xFFEEECEA);
  @override
  Color get bg3 => const Color(0xFFE4E0DA);
  @override
  Color get card => const Color(0xFFFFFFFF);
  @override
  Color get card2 => const Color(0xFFF7F6F3);
  @override
  Color get text => const Color(0xFF1A1A1E);
  @override
  Color get text2 => const Color(0xFF6B6B78);
  @override
  Color get text3 => const Color(0xFFAAAAAA);
  @override
  Color get border => const Color(0xFFE4E2DC);
  @override
  Color get accent => const Color(0xFF3B3BE8);
  @override
  Color get accentLight => const Color(0xFFEBEBFD);
  @override
  Color get star => const Color(0xFFF59E0B);
  @override
  Color get danger => const Color(0xFFDC2626);
  @override
  Color get dangerBg => const Color(0xFFFEF2F2);
  @override
  Color get tagWorkBg => const Color(0xFFE8F0FE);
  @override
  Color get tagWork => const Color(0xFF1A56DB);
  @override
  Color get tagPersonalBg => const Color(0xFFFEF3C7);
  @override
  Color get tagPersonal => const Color(0xFF92400E);
  @override
  Color get tagIdeasBg => const Color(0xFFF0FDF4);
  @override
  Color get tagIdeas => const Color(0xFF166634);
  @override
  String get id => 'light';
  @override
  String get label => 'Light';
}

class _DarkColors implements ChitpadColorScheme {
  const _DarkColors();
  @override
  Color get bg => const Color(0xFF0F0F12);
  @override
  Color get bg2 => const Color(0xFF1A1A20);
  @override
  Color get bg3 => const Color(0xFF24242C);
  @override
  Color get card => const Color(0xFF1A1A20);
  @override
  Color get card2 => const Color(0xFF24242C);
  @override
  Color get text => const Color(0xFFE8E8F0);
  @override
  Color get text2 => const Color(0xFF8888A0);
  @override
  Color get text3 => const Color(0xFF444458);
  @override
  Color get border => const Color(0xFF2E2E3A);
  @override
  Color get accent => const Color(0xFF818CF8);
  @override
  Color get accentLight => const Color(0xFF1E1E35);
  @override
  Color get star => const Color(0xFFFBBF24);
  @override
  Color get danger => const Color(0xFFF87171);
  @override
  Color get dangerBg => const Color(0xFF1F0A0A);
  @override
  Color get tagWorkBg => const Color(0xFF1A2640);
  @override
  Color get tagWork => const Color(0xFF93C5FD);
  @override
  Color get tagPersonalBg => const Color(0xFF2A1C00);
  @override
  Color get tagPersonal => const Color(0xFFFCD34D);
  @override
  Color get tagIdeasBg => const Color(0xFF0F2A0F);
  @override
  Color get tagIdeas => const Color(0xFF86EFAC);
  @override
  String get id => 'dark';
  @override
  String get label => 'Dark';
}

class _SolarizedColors implements ChitpadColorScheme {
  const _SolarizedColors();
  @override
  Color get bg => const Color(0xFFFDF6E3);
  @override
  Color get bg2 => const Color(0xFFEEE8D5);
  @override
  Color get bg3 => const Color(0xFFDDD8C4);
  @override
  Color get card => const Color(0xFFFFF8E7);
  @override
  Color get card2 => const Color(0xFFF0EBD8);
  @override
  Color get text => const Color(0xFF073642);
  @override
  Color get text2 => const Color(0xFF657B83);
  @override
  Color get text3 => const Color(0xFF93A1A1);
  @override
  Color get border => const Color(0xFFD4CDB8);
  @override
  Color get accent => const Color(0xFFB58900);
  @override
  Color get accentLight => const Color(0xFFF8F0D0);
  @override
  Color get star => const Color(0xFFCB4B16);
  @override
  Color get danger => const Color(0xFFDC322F);
  @override
  Color get dangerBg => const Color(0xFFFFF0EE);
  @override
  Color get tagWorkBg => const Color(0xFFE8F4F8);
  @override
  Color get tagWork => const Color(0xFF2AA198);
  @override
  Color get tagPersonalBg => const Color(0xFFFEF0E0);
  @override
  Color get tagPersonal => const Color(0xFFCB4B16);
  @override
  Color get tagIdeasBg => const Color(0xFFF0F8E8);
  @override
  Color get tagIdeas => const Color(0xFF859900);
  @override
  String get id => 'solarized';
  @override
  String get label => 'Solarized';
}

class _RosePineColors implements ChitpadColorScheme {
  const _RosePineColors();
  @override
  Color get bg => const Color(0xFF191724);
  @override
  Color get bg2 => const Color(0xFF1F1D2E);
  @override
  Color get bg3 => const Color(0xFF26233A);
  @override
  Color get card => const Color(0xFF1F1D2E);
  @override
  Color get card2 => const Color(0xFF26233A);
  @override
  Color get text => const Color(0xFFE0DEF4);
  @override
  Color get text2 => const Color(0xFF908CAA);
  @override
  Color get text3 => const Color(0xFF524F67);
  @override
  Color get border => const Color(0xFF393552);
  @override
  Color get accent => const Color(0xFFC4A7E7);
  @override
  Color get accentLight => const Color(0xFF2A1F3D);
  @override
  Color get star => const Color(0xFFF6C177);
  @override
  Color get danger => const Color(0xFFEB6F92);
  @override
  Color get dangerBg => const Color(0xFF2A1020);
  @override
  Color get tagWorkBg => const Color(0xFF1A2535);
  @override
  Color get tagWork => const Color(0xFF9CCFD8);
  @override
  Color get tagPersonalBg => const Color(0xFF2A1A28);
  @override
  Color get tagPersonal => const Color(0xFFEB6F92);
  @override
  Color get tagIdeasBg => const Color(0xFF1A2820);
  @override
  Color get tagIdeas => const Color(0xFF31748F);
  @override
  String get id => 'rosepine';
  @override
  String get label => 'Rosé Pine';
}

class _NordColors implements ChitpadColorScheme {
  const _NordColors();
  @override
  Color get bg => const Color(0xFFECEFF4);
  @override
  Color get bg2 => const Color(0xFFE5E9F0);
  @override
  Color get bg3 => const Color(0xFFD8DEE9);
  @override
  Color get card => const Color(0xFFFFFFFF);
  @override
  Color get card2 => const Color(0xFFECEFF4);
  @override
  Color get text => const Color(0xFF2E3440);
  @override
  Color get text2 => const Color(0xFF4C566A);
  @override
  Color get text3 => const Color(0xFF9AA0AE);
  @override
  Color get border => const Color(0xFFD0D6E0);
  @override
  Color get accent => const Color(0xFF5E81AC);
  @override
  Color get accentLight => const Color(0xFFDCE5F0);
  @override
  Color get star => const Color(0xFFEBCB8B);
  @override
  Color get danger => const Color(0xFFBF616A);
  @override
  Color get dangerBg => const Color(0xFFFCE8E8);
  @override
  Color get tagWorkBg => const Color(0xFFDCE8F5);
  @override
  Color get tagWork => const Color(0xFF5E81AC);
  @override
  Color get tagPersonalBg => const Color(0xFFFDF0D8);
  @override
  Color get tagPersonal => const Color(0xFFD08770);
  @override
  Color get tagIdeasBg => const Color(0xFFE4F0E8);
  @override
  Color get tagIdeas => const Color(0xFFA3BE8C);
  @override
  String get id => 'nord';
  @override
  String get label => 'Nord';
}

class _CatppuccinColors implements ChitpadColorScheme {
  const _CatppuccinColors();
  @override
  Color get bg => const Color(0xFF1E1E2E);
  @override
  Color get bg2 => const Color(0xFF181825);
  @override
  Color get bg3 => const Color(0xFF313244);
  @override
  Color get card => const Color(0xFF1E1E2E);
  @override
  Color get card2 => const Color(0xFF313244);
  @override
  Color get text => const Color(0xFFCDD6F4);
  @override
  Color get text2 => const Color(0xFFA6ADC8);
  @override
  Color get text3 => const Color(0xFF585B70);
  @override
  Color get border => const Color(0xFF45475A);
  @override
  Color get accent => const Color(0xFFCBA6F7);
  @override
  Color get accentLight => const Color(0xFF2A1F40);
  @override
  Color get star => const Color(0xFFF9E2AF);
  @override
  Color get danger => const Color(0xFFF38BA8);
  @override
  Color get dangerBg => const Color(0xFF2A0F18);
  @override
  Color get tagWorkBg => const Color(0xFF1A2535);
  @override
  Color get tagWork => const Color(0xFF89DCEB);
  @override
  Color get tagPersonalBg => const Color(0xFF2A1520);
  @override
  Color get tagPersonal => const Color(0xFFF38BA8);
  @override
  Color get tagIdeasBg => const Color(0xFF1A2820);
  @override
  Color get tagIdeas => const Color(0xFFA6E3A1);
  @override
  String get id => 'catppuccin';
  @override
  String get label => 'Catppuccin';
}
