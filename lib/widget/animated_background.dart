import 'dart:math' as math;

import 'package:flutter/material.dart';


class AnimatedGradientBG extends StatefulWidget {
  @override
  State<AnimatedGradientBG> createState() => AnimatedGradientBGState();
}

class AnimatedGradientBGState extends State<AnimatedGradientBG> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _anim;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    _anim = Tween<double>(begin: 0, end: math.pi * 2).animate(CurvedAnimation(parent: _c, curve: Curves.linear));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        final angle = _anim.value;
        return Transform.rotate(
          angle: angle / 12,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0B0B0F), Color(0xFF0F1724)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        );
      },
    );
  }
}