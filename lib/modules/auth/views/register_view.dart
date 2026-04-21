import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/providers/app_providers.dart';
import '../../../app/widgets/fox_mascot.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tc = ref.watch(themeProvider);
    final controller = ref.watch(authProvider);
    final colors = tc.colors;

    return Scaffold(
      backgroundColor: colors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios, size: 16, color: colors.text2),
                    const SizedBox(width: 4),
                    Text(
                      'Back',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: colors.text2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Fox mascot reacts to password strength
              Center(
                child: Builder(
                  builder: (_) {
                    FoxMood mood;
                    if (controller.regLoading) {
                      mood = FoxMood.thinking;
                    } else if (controller.regPasswordStrength >= 3) {
                      mood = FoxMood.happy;
                    } else if (controller.regPasswordStrength == 0) {
                      mood = FoxMood.idle;
                    } else {
                      mood = FoxMood.thinking;
                    }
                    return FoxMascot(size: 85, mood: mood, showShadow: true);
                  },
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'Create account',
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: colors.text,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Join Chitpad and start writing',
                style: GoogleFonts.nunito(fontSize: 13, color: colors.text2),
              ),
              const SizedBox(height: 22),

              // Username
              _label('USERNAME', colors.text3),
              const SizedBox(height: 6),
              TextField(
                onChanged: controller.setRegUsername,
                style: GoogleFonts.nunito(fontSize: 14, color: colors.text),
                decoration: InputDecoration(
                  hintText: '@yourname',
                  errorText: controller.regUsernameError.isEmpty
                      ? null
                      : controller.regUsernameError,
                ),
              ),
              const SizedBox(height: 14),

              // Email
              _label('EMAIL', colors.text3),
              const SizedBox(height: 6),
              TextField(
                onChanged: controller.setRegEmail,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.nunito(fontSize: 14, color: colors.text),
                decoration: InputDecoration(
                  hintText: 'you@example.com',
                  errorText: controller.regEmailError.isEmpty
                      ? null
                      : controller.regEmailError,
                ),
              ),
              const SizedBox(height: 14),

              // Password
              _label('PASSWORD', colors.text3),
              const SizedBox(height: 6),
              TextField(
                onChanged: controller.setRegPassword,
                obscureText: !controller.regShowPassword,
                style: GoogleFonts.nunito(fontSize: 14, color: colors.text),
                decoration: InputDecoration(
                  hintText: '••••••••',
                  errorText: controller.regPasswordError.isEmpty
                      ? null
                      : controller.regPasswordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.regShowPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: colors.text3,
                      size: 20,
                    ),
                    onPressed: controller.toggleRegShowPassword,
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // Password strength bar
              Builder(
                builder: (_) {
                  final strength = controller.regPasswordStrength;
                  final pct = strength / 4;
                  Color barColor;
                  switch (strength) {
                    case 1:
                      barColor = colors.danger;
                      break;
                    case 2:
                      barColor = colors.star;
                      break;
                    case 3:
                      barColor = const Color(0xFFF59E0B);
                      break;
                    case 4:
                      barColor = colors.tagIdeas;
                      break;
                    default:
                      barColor = colors.border;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: pct,
                          backgroundColor: colors.border,
                          valueColor: AlwaysStoppedAnimation(barColor),
                          minHeight: 4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.passwordStrengthLabel,
                        style: GoogleFonts.dmMono(
                          fontSize: 11,
                          color: strength > 0 ? barColor : colors.text3,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // Create account button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.regLoading
                      ? null
                      : controller.doRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: controller.regLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Create account',
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 18),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: colors.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or',
                      style: GoogleFonts.dmMono(
                        fontSize: 12,
                        color: colors.text3,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: colors.border)),
                ],
              ),
              const SizedBox(height: 18),

              // Google button
              SizedBox(
                width: double.infinity,
                height: 46,
                child: OutlinedButton.icon(
                  onPressed: controller.doGoogleLogin,
                  icon: const Icon(Icons.g_mobiledata, size: 22),
                  label: Text(
                    'Continue with Google',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: colors.text,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colors.border, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Sign in link
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.nunito(
                        fontSize: 13,
                        color: colors.text2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        'Sign in',
                        style: GoogleFonts.nunito(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: colors.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.dmMono(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.7,
      ),
    );
  }
}
