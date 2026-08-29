import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoffecitoMascot extends StatelessWidget {
  final double width;
  final double height;
  final bool isMini;

  const CoffecitoMascot({
    super.key,
    this.width = 240,
    this.height = 240,
    this.isMini = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _CoffecitoMascotPainter(isMini: isMini),
      ),
    );
  }
}

class _CoffecitoMascotPainter extends CustomPainter {
  final bool isMini;

  _CoffecitoMascotPainter({required this.isMini});

  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = isMini ? 3.0 : 5.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 200;
    final scaleY = size.height / 200;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    if (isMini) {
      // ---------- MINI LOADING RUNNING MUG ----------
      // Mug Body
      final RRect miniMug = RRect.fromRectAndRadius(
        const Rect.fromLTWH(60, 60, 70, 65),
        const Radius.circular(10),
      );
      canvas.drawRRect(miniMug, whitePaint);

      // Handle on left
      final Path handlePath = Path()
        ..addOval(const Rect.fromLTWH(42, 70, 24, 30));
      canvas.drawPath(handlePath, outlinePaint);

      // Running Arms
      final Path leftArm = Path()
        ..moveTo(60, 85)
        ..quadraticBezierTo(45, 95, 35, 90);
      canvas.drawPath(leftArm, outlinePaint);

      final Path rightArm = Path()
        ..moveTo(130, 85)
        ..quadraticBezierTo(145, 95, 155, 90);
      canvas.drawPath(rightArm, outlinePaint);

      // Running Legs
      final Path leftLeg = Path()
        ..moveTo(75, 125)
        ..lineTo(60, 150)
        ..lineTo(45, 150);
      canvas.drawPath(leftLeg, outlinePaint);

      final Path rightLeg = Path()
        ..moveTo(115, 125)
        ..lineTo(135, 145)
        ..lineTo(150, 160);
      canvas.drawPath(rightLeg, outlinePaint);

    } else {
      // ---------- FULL SPLASH HERO RUNNING COFFECITO MASCOT ----------
      // 1. Giant Coffee Mug Body with organic wavy top
      final Path mugPath = Path()
        ..moveTo(45, 35)
        ..quadraticBezierTo(100, 25, 155, 35)
        ..quadraticBezierTo(165, 75, 160, 115)
        ..quadraticBezierTo(100, 125, 40, 115)
        ..quadraticBezierTo(35, 75, 45, 35)
        ..close();
      canvas.drawPath(mugPath, whitePaint);

      // Left Handle on the Mug
      final Path handle = Path()
        ..moveTo(42, 55)
        ..cubicTo(20, 55, 20, 90, 42, 90);
      final Paint thickOutline = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 14
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(handle, thickOutline);

      final Path handleInner = Path()
        ..moveTo(42, 60)
        ..cubicTo(28, 60, 28, 85, 42, 85);
      final Paint innerBlue = Paint()
        ..color = const Color(0xFF1E90FF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6;
      canvas.drawPath(handleInner, innerBlue);

      // "COFFECITO" Text on the Mug Body
      final textSpan = TextSpan(
        text: 'COFFECITO',
        style: GoogleFonts.sora(
          color: const Color(0xFF195ABE),
          fontSize: 15,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(100 - textPainter.width / 2, 70 - textPainter.height / 2));

      // 2. Character Body under the Mug (Head, Eyes, Nose)
      // Head/Body outline & fill
      final Path characterHead = Path()
        ..moveTo(80, 120)
        ..cubicTo(70, 140, 70, 160, 95, 165)
        ..cubicTo(125, 165, 130, 140, 125, 120)
        ..close();
      canvas.drawPath(characterHead, whitePaint);

      // Eyes & Nose in Blue
      final Paint faceDetailPaint = Paint()
        ..color = const Color(0xFF195ABE)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(const Offset(92, 138), 3.5, faceDetailPaint);
      canvas.drawCircle(const Offset(110, 138), 3.5, faceDetailPaint);
      // Nose
      final Path nosePath = Path()
        ..moveTo(100, 142)
        ..lineTo(105, 146)
        ..lineTo(98, 148);
      canvas.drawPath(nosePath, faceDetailPaint);

      // 3. Character Arms holding the Giant Mug
      final Paint armPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      // Left Arm extending up to mug
      final Path armLeft = Path()
        ..moveTo(80, 148)
        ..lineTo(58, 130)
        ..lineTo(58, 115);
      canvas.drawPath(armLeft, armPaint);

      // Right Arm extending up to mug
      final Path armRight = Path()
        ..moveTo(118, 148)
        ..lineTo(142, 130)
        ..lineTo(142, 115);
      canvas.drawPath(armRight, armPaint);

      // 4. Character Running Legs with Shoes
      final Paint legPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round;

      // Left Running Leg
      final Path legLeft = Path()
        ..moveTo(85, 162)
        ..lineTo(60, 185)
        ..lineTo(45, 180);
      canvas.drawPath(legLeft, legPaint);

      // Left Shoe
      final Path shoeLeft = Path()
        ..addRRect(RRect.fromRectAndRadius(
          const Rect.fromLTWH(38, 174, 22, 14),
          const Radius.circular(5),
        ));
      canvas.drawPath(shoeLeft, whitePaint);

      // Right Running Leg
      final Path legRight = Path()
        ..moveTo(115, 162)
        ..lineTo(140, 182)
        ..lineTo(155, 175);
      canvas.drawPath(legRight, legPaint);

      // Right Shoe
      final Path shoeRight = Path()
        ..addRRect(RRect.fromRectAndRadius(
          const Rect.fromLTWH(148, 168, 22, 14),
          const Radius.circular(5),
        ));
      canvas.drawPath(shoeRight, whitePaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CoffecitoMascotPainter oldDelegate) => false;
}
