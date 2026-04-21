import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Chitpad logo with fox-ear notepad motif.
class ChitpadLogo extends StatelessWidget {
  final double size;
  final Color? accentColor;
  final bool showText;
  final bool compact;

  const ChitpadLogo({
    super.key,
    this.size = 48,
    this.accentColor,
    this.showText = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(size * 0.28),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CustomPaint(painter: _LogoPainter(accent: accent)),
        ),
        if (showText) ...[
          SizedBox(width: compact ? 8 : 12),
          Text(
            'Chitpad',
            style: GoogleFonts.nunito(
              fontSize: size * 0.48,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ],
    );
  }
}

class _LogoPainter extends CustomPainter {
  final Color accent;

  _LogoPainter({required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final whitePaint = Paint()..color = Colors.white.withValues(alpha: 0.95);

    // Notepad body - centered more naturally
    final padRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.22, w * 0.25, w * 0.56, h * 0.58),
      Radius.circular(w * 0.08),
    );
    canvas.drawRRect(padRect, whitePaint);

    // Fox ears on the notepad - more curved and organic
    final leftEar = Path();
    leftEar.moveTo(w * 0.22, w * 0.35);
    leftEar.quadraticBezierTo(w * 0.12, w * 0.05, w * 0.42, w * 0.25);
    leftEar.close();
    canvas.drawPath(leftEar, whitePaint);

    final rightEar = Path();
    rightEar.moveTo(w * 0.78, w * 0.35);
    rightEar.quadraticBezierTo(w * 0.88, w * 0.05, w * 0.58, w * 0.25);
    rightEar.close();
    canvas.drawPath(rightEar, whitePaint);

    // Inner ears (pinkish tint)
    final pinkPaint = Paint()
      ..color = const Color(0xFFFF9FB0).withValues(alpha: 0.5);
    final leftInner = Path();
    leftInner.moveTo(w * 0.26, w * 0.35);
    leftInner.quadraticBezierTo(w * 0.2, w * 0.15, w * 0.38, w * 0.28);
    leftInner.close();
    canvas.drawPath(leftInner, pinkPaint);

    final rightInner = Path();
    rightInner.moveTo(w * 0.74, w * 0.35);
    rightInner.quadraticBezierTo(w * 0.8, w * 0.15, w * 0.62, w * 0.28);
    rightInner.close();
    canvas.drawPath(rightInner, pinkPaint);

    final linePaint = Paint()
      ..color = accent.withValues(alpha: 0.4)
      ..strokeWidth = w * 0.03
      ..strokeCap = StrokeCap.round;

    // Notepad lines
    canvas.drawLine(
      Offset(w * 0.35, h * 0.45),
      Offset(w * 0.65, h * 0.45),
      linePaint,
    );
    canvas.drawLine(
      Offset(w * 0.35, h * 0.55),
      Offset(w * 0.65, h * 0.55),
      linePaint,
    );
    canvas.drawLine(
      Offset(w * 0.35, h * 0.65),
      Offset(w * 0.52, h * 0.65),
      linePaint,
    );

    // Small plus icon - adjusted position and style
    final plusCenter = Offset(w * 0.74, h * 0.74);
    final plusR = w * 0.11;
    canvas.drawCircle(plusCenter, plusR, whitePaint);

    final plusStroke = Paint()
      ..color = accent
      ..strokeWidth = w * 0.03
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(plusCenter.dx - plusR * 0.45, plusCenter.dy),
      Offset(plusCenter.dx + plusR * 0.45, plusCenter.dy),
      plusStroke,
    );
    canvas.drawLine(
      Offset(plusCenter.dx, plusCenter.dy - plusR * 0.45),
      Offset(plusCenter.dx, plusCenter.dy + plusR * 0.45),
      plusStroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Splash-screen version: large centered logo with tagline
class ChitpadSplashLogo extends StatelessWidget {
  final Color accent;
  const ChitpadSplashLogo({super.key, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(26),
          ),
          child: CustomPaint(painter: _LogoPainter(accent: accent)),
        ),
        const SizedBox(height: 20),
        Text(
          'Chitpad',
          style: GoogleFonts.nunito(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'your thoughts, beautifully kept',
          style: GoogleFonts.dmMono(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.65),
          ),
        ),
      ],
    );
  }
}
