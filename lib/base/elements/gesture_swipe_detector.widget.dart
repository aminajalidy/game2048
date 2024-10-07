import 'package:flutter/material.dart';

class GestureSwipeDetector extends StatelessWidget {
  static const double minMainDisplacement = 30;
  static const double maxCrossRatio = 0.75;
  static const double minVelocity = 300;

  final Widget child;

  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;

  const GestureSwipeDetector({
    super.key,
    required this.child,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onSwipeLeft,
    this.onSwipeRight,
  });

  @override
  Widget build(BuildContext context) {
    DragStartDetails? panStartDetails;
    DragUpdateDetails? panUpdateDetails;

    return GestureDetector(
      onTapDown: (_) => panUpdateDetails = null,
      behavior: HitTestBehavior.opaque,
      child: child,
      onPanStart: (startDetails) => panStartDetails = startDetails,
      onPanUpdate: (updateDetails) => panUpdateDetails = updateDetails,
      onPanEnd: (endDetails) {
        if (panStartDetails == null || panUpdateDetails == null) return;

        double dx = panUpdateDetails!.globalPosition.dx -
            panStartDetails!.globalPosition.dx;
        double dy = panUpdateDetails!.globalPosition.dy -
            panStartDetails!.globalPosition.dy;

        int panDurationMilliseconds =
            panUpdateDetails!.sourceTimeStamp!.inMilliseconds -
                panStartDetails!.sourceTimeStamp!.inMilliseconds;

        double mainDis, crossDis, mainVel;
        bool isHorizontalMainAxis = dx.abs() > dy.abs();

        if (isHorizontalMainAxis) {
          mainDis = dx.abs();
          crossDis = dy.abs();
        } else {
          mainDis = dy.abs();
          crossDis = dx.abs();
        }

        mainVel = 1000 * mainDis / panDurationMilliseconds;

        if (mainDis < minMainDisplacement) {
          debugPrint(
              "SWIPE DEBUG | Displacement too short. Real: $mainDis - Min: $minMainDisplacement");
          return;
        }
        if (crossDis > maxCrossRatio * mainDis) {
          debugPrint(
              "SWIPE DEBUG | Cross axis displacement bigger than limit. Real: $crossDis - Limit: ${mainDis * maxCrossRatio}");
          return;
        }
        if (mainVel < minVelocity) {
          debugPrint(
              "SWIPE DEBUG | Swipe velocity too slow. Real: $mainVel - Min: $minVelocity");
          return;
        }

        // dy < 0 => UP -- dx > 0 => RIGHT
        if (isHorizontalMainAxis) {
          if (dx > 0)
            onSwipeRight?.call();
          else
            onSwipeLeft?.call();
        } else {
          if (dy < 0)
            onSwipeUp?.call();
          else
            onSwipeDown?.call();
        }
      },
    );
  }
}
