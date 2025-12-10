import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingRightBlob extends StatelessWidget {
  final AnimationController controller;
  final double size;
  final Color color;
  const FloatingRightBlob({super.key, required this.controller, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final dy = math.sin(controller.value * 2 * math.pi) * 8;
        return Transform.translate(
            offset: Offset(0, dy),
            child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(size / 2),
                  // blur like glass
                  boxShadow: [BoxShadow(color: color.withOpacity(0.8), blurRadius: 40.r, spreadRadius: 6.r)],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size / 2),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      heightFactor: 0.7,
                      child: Image.asset(
                        opacity: const AlwaysStoppedAnimation<double>(0.5),
                        'assets/profile/hologram.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
            )
        );
      },
    );
  }
}