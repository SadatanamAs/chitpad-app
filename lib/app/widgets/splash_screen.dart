import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routes/app_routes.dart';
import 'fox_mascot.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _breatheController;
  late AnimationController _glowController;
  late AnimationController _dotsController;

  // Staggered slide-up + fade for each element
  late Animation<double> _mascotSlide;
  late Animation<double> _mascotFade;
  late Animation<double> _titleSlide;
  late Animation<double> _titleFade;
  late Animation<double> _taglineSlide;
  late Animation<double> _taglineFade;

  // Glow ring
  late Animation<double> _glowScale;
  late Animation<double> _glowOpacity;

  // Dots
  late Animation<double> _dot1;
  late Animation<double> _dot2;
  late Animation<double> _dot3;

  @override
  void initState() {
    super.initState();

    // Entrance: 900ms total
    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    // Breathe: 1800ms repeating
    _breatheController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);

    // Glow ring: 1200ms repeating
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    // Dots: 1000ms repeating
    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    // Staggered animations using Interval
    _mascotSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _mascotFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _titleSlide = Tween<double>(begin: 20, end: 0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.25, 0.7, curve: Curves.easeOut),
      ),
    );
    _titleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.25, 0.7, curve: Curves.easeOut),
      ),
    );

    _taglineSlide = Tween<double>(begin: 16, end: 0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.45, 0.9, curve: Curves.easeOut),
      ),
    );
    _taglineFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.45, 0.9, curve: Curves.easeOut),
      ),
    );

    // Glow ring
    _glowScale = Tween<double>(begin: 0.8, end: 1.3).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    _glowOpacity = Tween<double>(begin: 0.6, end: 0.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Dots — staggered sine wave
    _dot1 = Tween<double>(begin: 0.3, end: 1.0).animate(_dotsController);
    _dot2 = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _dotsController,
        curve: const Interval(0.33, 1.0),
      ),
    );
    _dot3 = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _dotsController,
        curve: const Interval(0.66, 1.0),
      ),
    );

    _entranceController.forward();

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _breatheController.dispose();
    _glowController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B3BE8),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _entranceController,
            _breatheController,
            _glowController,
            _dotsController,
          ]),
          builder: (context, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glow ring + mascot
                SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Expanding glow ring
                      Opacity(
                        opacity: _glowOpacity.value,
                        child: Transform.scale(
                          scale: _glowScale.value,
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Mascot with breathe + entrance slide
                      Transform.translate(
                        offset: Offset(0, _mascotSlide.value),
                        child: Opacity(
                          opacity: _mascotFade.value,
                          child: Transform.scale(
                            scale:
                                1.0 + (_breatheController.value * 0.04 - 0.02),
                            child: const FoxMascot(
                              size: 110,
                              mood: FoxMood.happy,
                              showShadow: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Title with entrance slide + fade
                Transform.translate(
                  offset: Offset(0, _titleSlide.value),
                  child: Opacity(
                    opacity: _titleFade.value,
                    child: Text(
                      'Chitpad',
                      style: GoogleFonts.nunito(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Tagline with entrance slide + fade
                Transform.translate(
                  offset: Offset(0, _taglineSlide.value),
                  child: Opacity(
                    opacity: _taglineFade.value,
                    child: Text(
                      'your thoughts, beautifully kept',
                      style: GoogleFonts.dmMono(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Animated dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _dot(0, _dot1.value),
                    const SizedBox(width: 8),
                    _dot(1, _dot2.value),
                    const SizedBox(width: 8),
                    _dot(2, _dot3.value),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _dot(int index, double scale) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.5 + (scale - 0.3) * 0.3),
        ),
      ),
    );
  }
}
