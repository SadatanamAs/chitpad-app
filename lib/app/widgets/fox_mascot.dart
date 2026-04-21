import 'package:flutter/material.dart';

enum FoxMood { happy, thinking, sleepy, curious, sad, waving, idle }

class FoxMascot extends StatelessWidget {
  final double size;
  final FoxMood mood;
  final bool showShadow;

  const FoxMascot({
    super.key,
    required this.size,
    this.mood = FoxMood.happy,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _FoxPainter(mood: mood, showShadow: showShadow),
      ),
    );
  }
}

class _FoxPainter extends CustomPainter {
  final FoxMood mood;
  final bool showShadow;

  _FoxPainter({required this.mood, required this.showShadow});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    // Shadow
    if (showShadow) {
      final shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx, h * 0.88),
          width: w * 0.55,
          height: h * 0.12,
        ),
        shadowPaint,
      );
    }

    // Head
    final headPaint = Paint()..color = const Color(0xFFFF7A30);
    final headRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, h * 0.46),
        width: w * 0.82,
        height: h * 0.68,
      ),
      Radius.circular(w * 0.3),
    );
    canvas.drawRRect(headRect, headPaint);

    // Ears
    final earPaint = Paint()..color = const Color(0xFFFF7A30);

    final leftEar = Path()
      ..moveTo(w * 0.18, h * 0.28)
      ..lineTo(w * 0.32, h * 0.06)
      ..lineTo(w * 0.46, h * 0.28)
      ..close();
    canvas.drawPath(leftEar, earPaint);

    final rightEar = Path()
      ..moveTo(w * 0.54, h * 0.28)
      ..lineTo(w * 0.68, h * 0.06)
      ..lineTo(w * 0.82, h * 0.28)
      ..close();
    canvas.drawPath(rightEar, earPaint);

    // Inner ears
    final innerPaint = Paint()..color = const Color(0xFFFFCFA8);
    final leftInner = Path()
      ..moveTo(w * 0.22, h * 0.27)
      ..lineTo(w * 0.32, h * 0.12)
      ..lineTo(w * 0.42, h * 0.27)
      ..close();
    canvas.drawPath(leftInner, innerPaint);

    final rightInner = Path()
      ..moveTo(w * 0.58, h * 0.27)
      ..lineTo(w * 0.68, h * 0.12)
      ..lineTo(w * 0.78, h * 0.27)
      ..close();
    canvas.drawPath(rightInner, innerPaint);

    // Face white patch
    final facePaint = Paint()..color = Colors.white;
    final faceRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, h * 0.56),
        width: w * 0.5,
        height: h * 0.36,
      ),
      Radius.circular(w * 0.25),
    );
    canvas.drawRRect(faceRect, facePaint);

    // Eyes
    final eyeWhitePaint = Paint()..color = Colors.white;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.34, h * 0.38),
        width: w * 0.16,
        height: w * 0.16,
      ),
      eyeWhitePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.66, h * 0.38),
        width: w * 0.16,
        height: w * 0.16,
      ),
      eyeWhitePaint,
    );

    // Pupils
    final pupilPaint = Paint()..color = const Color(0xFF2D2D2D);
    final blinkOffset = mood == FoxMood.sleepy ? h * 0.02 : 0.0;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.36, h * 0.40 + blinkOffset),
        width: w * 0.09,
        height: mood == FoxMood.sleepy ? w * 0.04 : w * 0.09,
      ),
      pupilPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.64, h * 0.40 + blinkOffset),
        width: w * 0.09,
        height: mood == FoxMood.sleepy ? w * 0.04 : w * 0.09,
      ),
      pupilPaint,
    );

    // Eye shine
    final shinePaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(w * 0.33, h * 0.37), w * 0.025, shinePaint);
    canvas.drawCircle(Offset(w * 0.61, h * 0.37), w * 0.025, shinePaint);

    // Nose
    final nosePaint = Paint()..color = const Color(0xFF3D2D2D);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, h * 0.54),
        width: w * 0.1,
        height: w * 0.07,
      ),
      nosePaint,
    );

    // Mouth — varies by mood
    final mouthPaint = Paint()
      ..color = const Color(0xFF3D2D2D)
      ..strokeWidth = w * 0.025
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (mood == FoxMood.happy || mood == FoxMood.curious) {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(cx, h * 0.58),
          width: w * 0.18,
          height: h * 0.1,
        ),
        0.1,
        3.0,
        false,
        mouthPaint,
      );
    } else if (mood == FoxMood.thinking) {
      canvas.drawLine(
        Offset(cx - w * 0.04, h * 0.59),
        Offset(cx + w * 0.06, h * 0.58),
        mouthPaint,
      );
    } else if (mood == FoxMood.sad) {
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(cx, h * 0.62),
          width: w * 0.14,
          height: h * 0.08,
        ),
        2.5,
        2.0,
        false,
        mouthPaint,
      );
    } else if (mood == FoxMood.waving) {
      canvas.drawLine(
        Offset(cx - w * 0.03, h * 0.59),
        Offset(cx + w * 0.03, h * 0.59),
        mouthPaint,
      );
    } else if (mood == FoxMood.idle) {
      canvas.drawLine(
        Offset(cx - w * 0.04, h * 0.59),
        Offset(cx + w * 0.04, h * 0.59),
        mouthPaint,
      );
    } else {
      // Sleepy — straight line
      canvas.drawLine(
        Offset(cx - w * 0.04, h * 0.59),
        Offset(cx + w * 0.04, h * 0.59),
        mouthPaint,
      );
    }

    // Cheek blush (happy/curious)
    if (mood == FoxMood.happy || mood == FoxMood.curious) {
      final blushPaint = Paint()
        ..color = const Color(0xFFFF9A8A).withValues(alpha: 0.35);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(w * 0.22, h * 0.52),
          width: w * 0.12,
          height: w * 0.07,
        ),
        blushPaint,
      );
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(w * 0.78, h * 0.52),
          width: w * 0.12,
          height: w * 0.07,
        ),
        blushPaint,
      );
    }

    // Eyebrows for curious/thinking/sad
    if (mood == FoxMood.curious ||
        mood == FoxMood.thinking ||
        mood == FoxMood.sad) {
      final browPaint = Paint()
        ..color = const Color(0xFFFF7A30)
        ..strokeWidth = w * 0.025
        ..strokeCap = StrokeCap.round;
      if (mood == FoxMood.sad) {
        // Sad brows — angled down at outer edges
        canvas.drawLine(
          Offset(w * 0.26, h * 0.27),
          Offset(w * 0.38, h * 0.31),
          browPaint,
        );
        canvas.drawLine(
          Offset(w * 0.62, h * 0.31),
          Offset(w * 0.74, h * 0.27),
          browPaint,
        );
      } else {
        canvas.drawLine(
          Offset(w * 0.26, h * 0.30),
          Offset(w * 0.38, h * 0.27),
          browPaint,
        );
        canvas.drawLine(
          Offset(w * 0.62, h * 0.27),
          Offset(w * 0.74, h * 0.30),
          browPaint,
        );
      }
    }

    // Waving paw
    if (mood == FoxMood.waving) {
      final pawPaint = Paint()..color = const Color(0xFFFFCFA8);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(w * 0.82, h * 0.62),
          width: w * 0.18,
          height: w * 0.14,
        ),
        pawPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FoxPainter oldDelegate) =>
      oldDelegate.mood != mood || oldDelegate.showShadow != showShadow;
}
