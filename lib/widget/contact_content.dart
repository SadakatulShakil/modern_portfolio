import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactContent extends StatelessWidget {
  final String email;
  final String github;
  final String linkedIn;
  const ContactContent({super.key, required this.email, required this.github, required this.linkedIn});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {}
  }

  Future<void> _mail(String to) async {
    final uri = Uri(scheme: 'mailto', path: to);
    if (!await launchUrl(uri)) {}
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(children: [
          SizedBox(height: 6.h),
          Text("I’m available for freelance & full-time (Remote + On-site) roles. Let’s build something great together.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.r)
          ),
          SizedBox(height: 20.h),
          Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _mail(email),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
                    padding: REdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: const Text("Email Me"),
                ),
                ElevatedButton(
                  onPressed: () => _open(github),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
                    padding: REdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: const Text("GitHub"),
                ),
                ElevatedButton(
                  onPressed: () => _open(linkedIn),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.2)),
                    padding: REdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: const Text("LinkedIn"),
                ),
              ]),
        ]),
      ),
    );
  }
}