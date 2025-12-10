import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassAvatar extends StatelessWidget {
  final double size;
  final String initials;
  const GlassAvatar({super.key, required this.size, required this.initials});

  @override
  Widget build(BuildContext context) {
    // This component currently only appears in the desktop view, so hardcoded values are mostly fine,
    // but using .r for radius and border is safer.
    return Container(
      width: size + 12,
      height: size + 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((size + 12) / 2),
        gradient: LinearGradient(colors: [Colors.white.withOpacity(0.06), Colors.white.withOpacity(0.02)]),
        border: Border.all(color: Colors.white10, width: 1.5.r),
      ),
      child: Center(
        child: CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.deepPurple.shade400,
          child: Text(initials, style: TextStyle(fontSize: 16.r, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}