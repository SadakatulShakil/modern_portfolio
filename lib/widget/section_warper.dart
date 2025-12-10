import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  const SectionWrapper({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Using REdgeInsets for adaptive padding
      padding: REdgeInsets.symmetric(vertical: 44, horizontal: 24),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 28.r, fontWeight: FontWeight.bold)),
          SizedBox(height: 18.h),
          child,
        ],
      ),
    );
  }
}