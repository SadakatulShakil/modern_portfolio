import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutContent extends StatefulWidget {
  const AboutContent({super.key});

  @override
  State<AboutContent> createState() => AboutContentState();
}

class AboutContentState extends State<AboutContent> {
  bool _isExpanded = false;

  final String fullDescription = "I’m Sadakatul Ajam Md. Shakil, a dedicated and detail-oriented Flutter developer from Bangladesh. I specialize in building modern, high-performance applications with clean architecture, scalable state management, and polished UI/UX experiences."
      " Having a strong academic foundation—BSc in CSE from the State University of Bangladesh, SSC from Pirgachha J.N. High School (2012), and HSC from Carmichael College, Rangpur (2014)—I’ve become a continuous learner who thrives on turning ideas into elegant, production-ready digital solutions. My work reflects precision, reliability, and a passion for creating meaningful technology.";

  final String academicDetails =
      "\n\nHaving a strong academic foundation—Msc in CSE from Jagannath University, BSc in CSE from the State University of Bangladesh, SSC from Pirgachha J.N. High School (2012), and HSC from Carmichael College, Rangpur (2014)—I’ve become a continuous learner who thrives on turning ideas into elegant, production-ready digital solutions. My work reflects precision, reliability, and a passion for creating meaningful technology.";

  final String basicDescription =
      "I’m Sadakatul Ajam Md. Shakil, a dedicated and detail-oriented Flutter developer from Bangladesh. I specialize in building modern, high-performance applications with clean architecture, scalable state management, and polished UI/UX experiences.";

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 900;

    String currentDescription;
    bool showToggle = false;

    if (isNarrow) {
      currentDescription = basicDescription + (_isExpanded ? academicDetails : '');
      showToggle = true;
    } else {
      currentDescription = fullDescription;
      showToggle = false;
    }

    return Center(
      child: ConstrainedBox(
        // Hardcoded max width for web constraint
        constraints: const BoxConstraints(maxWidth: 1000),
        child: isNarrow
            ? AnimatedSize(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: Column(
            children: _buildContent(context, isNarrow, currentDescription, showToggle),
          ),
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildContent(context, isNarrow, currentDescription, showToggle),
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, bool isNarrow, String description, bool showToggle) {
    return [
      Expanded(
        flex: isNarrow ? 0 : 1,
        child: Column(
          children: [
            SizedBox(height: 6.h),
            CircleAvatar(radius: 64.r, backgroundColor: Colors.deepPurple,
                child: Text("SA", style: TextStyle(fontSize: 36.r, fontWeight: FontWeight.bold))),
            SizedBox(height: 12.h),
            isNarrow
                ? const Text("Flutter Developer • Problem Solver • 5+ Years Experience", style: TextStyle(color: Colors.white70), textAlign: TextAlign.center,)
                : const Text("Flutter Developer • Problem Solver", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),

      if (!isNarrow) SizedBox(width: 24.w),

      Expanded(
        flex: isNarrow ? 0 : 2,
        child: Padding(
          // Adaptive padding based on narrow state
          padding: EdgeInsets.symmetric(horizontal: isNarrow ? 0 : 24.w, vertical: isNarrow ? 20.h : 0),
          child: Column(
            crossAxisAlignment: isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                description,
                textAlign: isNarrow ? TextAlign.start : TextAlign.left,
                style: TextStyle(fontSize: 16.r, height: 1.5),
              ),

              if (showToggle) ...[
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: REdgeInsets.all(12),
                    side: const BorderSide(color: Colors.white30),
                    minimumSize: Size(50.w, 30.h),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _isExpanded ? 'See Less' : 'See More',
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20.r,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    ];
  }
}