import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/providers/app_providers.dart';
import '../../../app/widgets/fox_mascot.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({super.key});

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
              const SizedBox(height: 24),

              Center(
                child: FoxMascot(
                  size: 100,
                  mood: controller.forgotSent ? FoxMood.happy : FoxMood.sad,
                  showShadow: true,
                ),
              ),
              const SizedBox(height: 18),

              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colors.accentLight,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: colors.accent,
                  size: 26,
                ),
              ),
              const SizedBox(height: 18),

              Text(
                'Forgot password?',
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: colors.text,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "No worries — enter your email and we'll send you a reset link.",
                style: GoogleFonts.nunito(fontSize: 13, color: colors.text2),
              ),
              const SizedBox(height: 22),

              Text(
                'EMAIL ADDRESS',
                style: GoogleFonts.dmMono(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: colors.text3,
                  letterSpacing: 0.7,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                onChanged: controller.setForgotEmail,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.nunito(fontSize: 14, color: colors.text),
                decoration: InputDecoration(
                  hintText: 'you@example.com',
                  errorText: controller.forgotEmailError.isEmpty
                      ? null
                      : controller.forgotEmailError,
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.forgotLoading
                      ? null
                      : controller.doForgot,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: controller.forgotLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Send reset link',
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),

              // Success message
              if (controller.forgotSent) ...[
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.tagIdeasBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text('📬', style: TextStyle(fontSize: 22)),
                      const SizedBox(height: 6),
                      Text(
                        'Check your inbox!',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: colors.tagIdeas,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'We sent a reset link to your email',
                        style: GoogleFonts.nunito(
                          fontSize: 12.5,
                          color: colors.text2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 18),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Remember your password? ',
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
            ],
          ),
        ),
      ),
    );
  }
}
