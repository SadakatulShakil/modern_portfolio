import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkillsContent extends StatelessWidget {
  const SkillsContent({super.key});


  final List<Map<String, dynamic>> skills = const [
    {"name": "Flutter", "level": 0.95},
    {"name": "Dart", "level": 0.92},
    {"name": "GetX", "level": 0.88},
    {"name": "Firebase", "level": 0.86},
    {"name": "UI/UX", "level": 0.8},
    {"name": "Google Maps", "level": 0.78},
  ];

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;
    return isNarrow?
    // Mobile View: Heavily adapted with screenutil
    GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: REdgeInsets.all(8.0),
      itemCount: skills.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1.9,
      ),
      itemBuilder: (context, index) {
        final s = skills[index];
        return Container(
          width: double.infinity,
          padding: REdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(s["name"]!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.r)),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Colors.white10,
                ),
                child: LinearProgressIndicator(
                  value: s["level"],
                  minHeight: 8.h,
                  color: Colors.deepPurple.shade400,
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 6.h),
              Text("${(s["level"] * 100).toInt()}%", style: TextStyle(color: Colors.white70, fontSize: 12.r)),
            ],
          ),
        );
      },
    ):
    // Desktop View: Mostly hardcoded constraints
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Wrap(
          spacing: 18, // Keep hardcoded for desktop
          runSpacing: 18,
          alignment: WrapAlignment.start,
          children: skills.map((s) {
            return SizedBox(
              width: 300, // Keep hardcoded width
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                color: Colors.white.withOpacity(0.05),
                child: Padding(
                  padding: REdgeInsets.all(14),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: Colors.white10,
                      ),
                      child: LinearProgressIndicator(
                        value: s["level"],
                        minHeight: 8, // Keep hardcoded for desktop
                        color: Colors.deepPurple.shade400,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("${(s["level"] * 100).toInt()}%", style: const TextStyle(color: Colors.white70)),
                  ]),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}