import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/enum.dart';
import '../controllers/drawing_controller/drawing_controller.dart';

class DrawingPainter extends CustomPainter {
  final CustomDrawingController controller;

  DrawingPainter(this.controller) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    for (var action in controller.value) {
      Paint paint =
          Paint()
            ..color = action.color
            ..strokeWidth = action.strokeWidth
            ..strokeCap = StrokeCap.butt
            ..style = PaintingStyle.stroke;

      if (action.shape == PaintingTools.freeHand) {
        for (int i = 0; i < action.points.length - 1; i++) {
          canvas.drawLine(action.points[i], action.points[i + 1], paint);
        }
      } else if (action.shape == PaintingTools.rectangle &&
          action.points.length == 2) {
        RRect rect = RRect.fromRectAndRadius(
          Rect.fromPoints(action.points[0], action.points[1]),
          const Radius.circular(8),
        );
        canvas.drawRRect(rect, paint);
      } else if (action.shape == PaintingTools.circle &&
          action.points.length == 2) {
        double radius = (action.points[0] - action.points[1]).distance / 2;
        Offset center = Offset(
          (action.points[0].dx + action.points[1].dx) / 2,
          (action.points[0].dy + action.points[1].dy) / 2,
        );
        canvas.drawCircle(center, radius, paint);
      } else if (action.shape == PaintingTools.arrow &&
          action.points.length == 2) {
        // Get start and end points
        Offset start = action.points[0];
        Offset end = action.points[1];

        // Draw the arrow shaft (main line)
        canvas.drawLine(start, end, paint);

        // Calculate the direction vector
        const double arrowLength = 20.0; // Length of arrowhead lines
        const double angle = 30.0; // Angle of arrowhead (in degrees)
        const double radians =
            angle * (3.14159265359 / 180.0); // Convert angle to radians

        // Calculate the vector from end to start
        Offset direction =
            Offset(start.dx - end.dx, start.dy - end.dy).normalize();

        // Calculate arrowhead points
        Offset arrowPoint1 =
            end +
            Offset(
              direction.dx * arrowLength * cos(radians) -
                  direction.dy * arrowLength * sin(radians),
              direction.dx * arrowLength * sin(radians) +
                  direction.dy * arrowLength * cos(radians),
            );
        Offset arrowPoint2 =
            end +
            Offset(
              direction.dx * arrowLength * cos(-radians) -
                  direction.dy * arrowLength * sin(-radians),
              direction.dx * arrowLength * sin(-radians) +
                  direction.dy * arrowLength * cos(-radians),
            );

        // Draw the arrowhead
        canvas.drawLine(end, arrowPoint1, paint);
        canvas.drawLine(end, arrowPoint2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

extension on Offset {
  Offset normalize() {
    double length = distance;
    return length > 0 ? this / length : this;
  }
}
