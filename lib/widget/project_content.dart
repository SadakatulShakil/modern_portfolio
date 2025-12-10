import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsContent extends StatelessWidget {
  const ProjectsContent({super.key});

  final List<Map<String, String>> projects = const [
    {"title": "Landslide Inventory App",
      "desc": "Flutter Interactive Landslide Reporting App — GetX + REST API",
      "url": "https://play.google.com/store/apps/details?id=com.rimes.lanslide_report",
      'cover_photo': 'assets/images/landslide.png'
    },
    {"title": "Laalsobuj e-commerce App",
      "desc": "Flutter e-commerce app with Custom backend — Provider + REST API",
      "url": "https://play.google.com/store/apps/details?id=com.laalsobuj.user",
      'cover_photo': 'assets/images/laal_sobuj.jpg'
    },
    {"title": "WZPDCL App",
      "desc": "Electricity bill management app with Custom backend — Provider + REST API",
      "url": "https://play.google.com/store/search?q=wzpdcl+app&c=apps",
      'cover_photo': 'assets/images/wzpdcl.jpg'
    },
    {"title": "Tottho Apa",
      "desc": "Sales representative admin app with Custom backend — Provider + REST API",
      "url": "https://play.google.com/store/apps/details?id=com.laalsobuj.totthoapa",
      'cover_photo': 'assets/images/totthoapa.jpg'
    },
    {"title": "BAMIS App",
      "desc": "Flutter app for displaying BAMIS data as GAdvisory — GetX + REST API",
      "url": "https://play.google.com/store/search?q=bamis&c=apps",
      'cover_photo': 'assets/images/bamis.png'
    },
    {"title": "EMS App",
      "desc": "Flutter app for Employee management — Provider + REST API",
      "url": "https://github.com/SadakatulShakil/EMS-System",
      'cover_photo': 'assets/images/ems.jpeg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;
    return isNarrow?
    // Mobile View: Heavily adapted
    GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: REdgeInsets.all(8.0),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.85, // Adjusted aspect ratio for mobile
      ),
      itemBuilder: (context, index) {
        final p = projects[index];
        return GestureDetector(
          onTap: () {
            final uri = Uri.parse(p['url']!);
            launchUrl(uri);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: REdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.asset(p['cover_photo']!, fit: BoxFit.cover, height: 80.h, width: double.infinity,)),
                SizedBox(height: 8.h),
                Text(p["title"]!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.r), maxLines: 1, overflow: TextOverflow.ellipsis,),
                SizedBox(height: 4.h),
                Expanded(child: Text(p["desc"]!, style: TextStyle(color: Colors.white70,fontSize: 10.r), maxLines: 3, overflow: TextOverflow.ellipsis,)),
                SizedBox(height: 6.h),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text("View", style: TextStyle(color: const Color(0xFF7C4DFF), fontSize: 10.r))]),
              ]),
            ),
          ),
        );
      },
    )
        :
    // Desktop View: Mostly hardcoded constraints
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: projects.map((p) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  final uri = Uri.parse(p['url']!);
                  launchUrl(uri);
                },
                child: Container(
                  width: 340, // Hardcoded width for desktop card
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.white10),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 18.r, offset: const Offset(0, 8))],
                  ),
                  child: Padding(
                    padding: REdgeInsets.all(18),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                          height: 160, // Hardcoded height for desktop image
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple.shade400,
                              borderRadius: BorderRadius.circular(12.r)
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.asset(p['cover_photo']!, fit: BoxFit.cover))
                      ),
                      const SizedBox(height: 12),
                      Text(p["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 6),
                      Text(p["desc"]!, style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 12),
                      const Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text("View", style: TextStyle(color: Color(0xFF7C4DFF)))]),
                    ]),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}