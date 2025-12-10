import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviewCard extends StatelessWidget {
  final String title;
  final String icon;
  final String url;
  final String subtitle;
  final double width;
  const PreviewCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.width,
    required this.icon,
    required  this.url});

  @override
  Widget build(BuildContext context) {
    // This is primarily a desktop component. We use REdgeInsets for padding and .r for radius
    // to allow slight adaptation, but stick to hardcoded width/heights to prevent over-scaling.
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            final uri = Uri.parse(url);
            if (!await launchUrl(uri)) {}
          },
          child: Container(
            width: width,
            padding: REdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white.withOpacity(0.06), Colors.white.withOpacity(0.02)]),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white10),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20.r, offset: Offset(0, 8.h))],
            ),
            child: Row(
              children: [
                Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade200, borderRadius: BorderRadius.circular(12.r)
                    ),
                    child: Padding(
                      padding: REdgeInsets.all(12.0),
                      child: Image.asset(icon, fit: BoxFit.contain),
                    )
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.r)),
                    SizedBox(height: 6.h),
                    Text(subtitle, style: const TextStyle(color: Colors.white70)),
                    SizedBox(height: 10.h),
                    Align(alignment: Alignment.bottomLeft, child: Text("Preview", style: TextStyle(color: Colors.blue.shade200, fontWeight: FontWeight.w600))),
                  ]),
                ),
              ],
            ),
          ),
        )
    );
  }
}