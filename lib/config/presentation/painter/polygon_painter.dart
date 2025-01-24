import 'dart:math';

import '../../../core/util/barrel.dart';

class PolygonGenerator extends CustomPainter {
  const PolygonGenerator({required this.color, required this.sides});
  final Color color;
  final int sides;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY) * 0.8;

    final path = Path();

    for (int i = 0; i < sides; i++) {
      double angle = (2 * pi * i) / sides;
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PriorityShape extends ConsumerWidget {
  const PriorityShape({super.key, required this.color, required this.sides});

  final Color color;
  final int sides;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: SizedBox(
        width: 18,
        height: 18,
        child: PolygonPaint(
          painter: PolygonGenerator(color: color, sides: sides),
          // size: ,
        ),
      ),
    );
  }
}

class PolygonPaint extends CustomPaint {
  const PolygonPaint({super.key, super.size, super.painter});
}
