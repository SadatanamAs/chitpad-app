import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/providers/app_providers.dart';
import '../../../app/widgets/chitpad_logo.dart';
import '../../../app/widgets/fox_mascot.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

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
              const SizedBox(height: 4),
              ChitpadLogo(size: 38, accentColor: colors.accent),
              const SizedBox(height: 28),

              // Fox mascot greeting
              Center(
                child: FoxMascot(
                  size: 90,
                  mood: controller.loginLoading
                      ? FoxMood.thinking
                      : FoxMood.waving,
                  showShadow: true,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Welcome back',
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: colors.text,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Sign in to continue to your notes',
                style: GoogleFonts.nunito(fontSize: 13, color: colors.text2),
              ),
              const SizedBox(height: 22),

              // Email field
              _FieldLabel(label: 'EMAIL', color: colors.text3),
              const SizedBox(height: 6),
              TextField(
                onChanged: controller.setLoginEmail,
                style: GoogleFonts.nunito(fontSize: 14, color: colors.text),
                decoration: InputDecoration(
                  hintText: 'you@example.com',
                  errorText: controller.loginEmailError.isEmpty
                      ? null
                      : controller.loginEmailError,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),

              // Password field
              _FieldLabel(label: 'PASSWORD', color: colors.text3),
              const SizedBox(height: 6),
              TextField(
                onChanged: controller.setLoginPassword,
                obscureText: !controller.loginShowPassword,
                style: GoogleFonts.nunito(fontSize: 14, color: colors.text),
                decoration: InputDecoration(
                  hintText: '••••••••',
                  errorText: controller.loginPasswordError.isEmpty
                      ? null
                      : controller.loginPasswordError,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.loginShowPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: colors.text3,
                      size: 20,
                    ),
                    onPressed: controller.toggleLoginShowPassword,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                  child: Text(
                    'Forgot password?',
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: colors.accent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Sign in button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.loginLoading
                      ? null
                      : controller.doLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: controller.loginLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Sign in',
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
                      'or continue with',
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
                  icon: Image.network(
                    'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
                    width: 18,
                    height: 18,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.g_mobiledata, size: 22),
                  ),
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

              // Sign up link
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.nunito(
                        fontSize: 13,
                        color: colors.text2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.register),
                      child: Text(
                        'Sign up',
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
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final Color color;
  const _FieldLabel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.dmMono(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.7,
      ),
    );
  }
}
