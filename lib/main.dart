import 'dart:math' as math;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Mobile-first base design size (e.g., iPhone 11/12/13 Pro Max width)
      designSize: const Size(400, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          title: 'Sadakatul Ajam Md. Shakil',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF0B0B0F),
            textTheme: GoogleFonts.spaceGroteskTextTheme(
              ThemeData.dark().textTheme,
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color(0xFF6BE0F9),
              primary: const Color(0xFF7C4DFF),
            ),
          ),
          home: const PortfolioHome(),
        );
      },
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _floatingController;
  bool _isAppBarPinned = false;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat(reverse: true);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // We keep these hardcoded because the expandedHeight depends on isNarrow,
    // and we don't want the threshold to scale weirdly between web and mobile.
    final isNarrow = MediaQuery.of(context).size.width < 900;
    final dynamicThreshold = (isNarrow ? 420 : 520) - kToolbarHeight;

    if (_scrollController.offset > dynamicThreshold) {
      if (!_isAppBarPinned) {
        setState(() {
          _isAppBarPinned = true;
        });
      }
    } else {
      if (_isAppBarPinned) {
        setState(() {
          _isAppBarPinned = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  void _scrollTo(double offset) {
    _scrollController.animateTo(offset,
        duration: const Duration(milliseconds: 700), curve: Curves.easeInOut);
  }

  final String email = "sadakatulshakil@gmail.com";
  final String github = "https://github.com/sadakatulshakil";
  final String linkedIn = "https://www.linkedin.com/in/sadakatulshakil/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            // SliverAppBar with parallax hero
            SliverAppBar(
              pinned: true,
              // Keep height hardcoded so it doesn't get too big on desktop
              expandedHeight: isNarrow ? 420 : 520,
              backgroundColor: _isAppBarPinned ? const Color(0xFF0B0B0F) : Colors.transparent,
              elevation: _isAppBarPinned ? 4.0 : 0.0,
              flexibleSpace: LayoutBuilder(builder: (context, box) {
                return FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Animated gradient background
                      Positioned.fill(
                          child: Lottie.asset('assets/json/background.json',
                              width: double.infinity, fit: BoxFit.cover
                          )
                      ),

                      // Parallax blurred shapes (floating blobs)
                      Positioned(
                        // Scale positions on mobile, keep fixed on desktop
                        top: isNarrow ? 40.h : 60,
                        left: isNarrow ? 20.w : 80,
                        child: _FloatingBlob(
                            controller: _floatingController,
                            size: isNarrow ? 120.r : 200, // Scale size on mobile only
                            color: const Color(0xFF6BE0F9).withOpacity(0.18)),
                      ),
                      Positioned(
                        top: isNarrow ? 80.h : 140,
                        right: isNarrow ? 20.w : 50,
                        child: _FloatingRightBlob(
                            controller: _floatingController,
                            size: isNarrow ? 100.r : 180,
                            color: const Color(0xFF7C4DFF).withOpacity(0.18)),
                      ),

                      // Main hero content
                      Positioned.fill(
                        child: Align(
                          alignment: isNarrow ? Alignment.center : Alignment.centerLeft,
                          child: Padding(
                            // Apply scaling padding only when narrow
                            padding: EdgeInsets.symmetric(
                                horizontal: isNarrow ? 20.w : 80,
                                vertical: isNarrow ? 20.h : 60
                            ),
                            child: ConstrainedBox(
                              // Keep max width hardcoded for web constraint
                              constraints: BoxConstraints(maxWidth: isNarrow ? double.infinity : 1200),
                              child: Row(
                                mainAxisAlignment: isNarrow ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left: Text
                                  Expanded(
                                    flex: isNarrow ? 0 : 6,
                                    child: Column(
                                      crossAxisAlignment: isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Scale font sizes on mobile
                                        Text("Hi, I’m", style: TextStyle(fontSize: isNarrow ? 16.r : 18, color: Colors.white.withOpacity(0.9))),
                                        SizedBox(height: 6.h),
                                        Text("Sadakatul Ajam Md. Shakil",
                                            style: TextStyle(fontSize: isNarrow ? 28.r : 44, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                                        SizedBox(height: 12.h),
                                        DefaultTextStyle(
                                          style: TextStyle(fontSize: isNarrow ? 14.r : 20, color: Colors.white70),
                                          child: AnimatedTextKit(
                                            repeatForever: true,
                                            pause: const Duration(milliseconds: 900),
                                            animatedTexts: [
                                              TyperAnimatedText('Flutter Mobile App Developer'),
                                              TyperAnimatedText('GetX • Firebase • REST APIs'),
                                              TyperAnimatedText('Interactive Apps • Clean Code'),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        Wrap(
                                          spacing: 12.w,
                                          runSpacing: 12.h,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () => _openUrl(github),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.black,
                                                // Use REdgeInsets for proportional padding
                                                padding: REdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                              ),
                                              child: const Text("View GitHub"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () => _openMail(email),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black87,
                                                foregroundColor: Colors.white,
                                                side: BorderSide(color: Colors.white.withOpacity(0.2)),
                                                padding: REdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                              ),
                                              child: const Text("Contact Me"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Right: Floating avatar & cards (hidden on narrow)
                                  if (!isNarrow) const Spacer(),
                                  if (!isNarrow)
                                    Expanded(
                                      flex: 4,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        // These are desktop-only elements, keep hardcoded sizes to prevent over-scaling
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Positioned(
                                              right: 0,
                                              top: 10,
                                              child: Transform.rotate(
                                                angle: -0.06,
                                                child: const _PreviewCard(
                                                  title: "Tottho Apa",
                                                  icon: "assets/icons/totthoapa.png",
                                                  url: "https://play.google.com/store/apps/details?id=com.laalsobuj.totthoapa",
                                                  subtitle: "Sales representative app",
                                                  width: 320,
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              right: 0,
                                              top: 140,
                                              child: Transform.rotate(
                                                angle: 0,
                                                child: const _PreviewCard(
                                                  title: "Landslide Inventory",
                                                  icon: "assets/icons/landslide.png",
                                                  url: "https://play.google.com/store/apps/details?id=com.rimes.lanslide_report",
                                                  subtitle: "Landslide Reporting App",
                                                  width: 320,
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              right: 0,
                                              top: 270,
                                              child: Transform.rotate(
                                                angle: 0.06,
                                                child: const _PreviewCard(
                                                  title: "WZPDCL",
                                                  icon: "assets/icons/wzpdcl.png",
                                                  url: "https://play.google.com/store/search?q=wzpdcl&c=apps",
                                                  subtitle: "Electricity Bill Management",
                                                  width: 320,
                                                ),
                                              ),
                                            ),

                                            // Avatar with glass ring
                                            const Positioned(
                                              left: -100,
                                              top: 100,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  _GlassAvatar(size: 140, initials: "5+ years\nExperience"),
                                                  SizedBox(height: 12),
                                                  Text("Flutter Developer", style: TextStyle(color: Colors.white70)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              // AppBar content (nav)
              title: _isAppBarPinned
                  ?Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sadakatul Ajam Md. Shakil',
                      style: TextStyle(fontSize: 18.r, // Scaled font
                          color: Colors.white)
                  ),
                  DefaultTextStyle(
                    style: TextStyle(fontSize: 15.r, fontWeight: FontWeight.bold, color: const Color(0xFF7C4DFF).withOpacity(.9)),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      pause: const Duration(milliseconds: 900),
                      animatedTexts: [
                        TyperAnimatedText('Flutter Mobile App Developer'),
                        TyperAnimatedText('GetX • Firebase • REST APIs'),
                        TyperAnimatedText('Interactive Apps • Clean Code'),
                      ],
                    ),
                  ),
                ],
              )
                  : null,
              actions: [
                if (!isNarrow) ...[
                  // Desktop Nav Buttons - using REdgeInsets for slight scaling
                  TextButton(onPressed: () => _scrollTo(520), child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: const Text("About", style: TextStyle(color: Colors.white),),
                      ))),
                  TextButton(onPressed: () => _scrollTo(980), child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: const Text("Skills", style: TextStyle(color: Colors.white)),
                      ))),
                  TextButton(onPressed: () => _scrollTo(1400), child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: const Text("Projects", style: TextStyle(color: Colors.white)),
                      ))),
                  TextButton(onPressed: () => _scrollTo(2200), child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: const Text("Contact", style: TextStyle(color: Colors.white)),
                      ))),
                ] else
                  PopupMenuButton<int>(
                    color: Colors.white,
                    icon: const Icon(Icons.menu, color: Colors.white),
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 1, child: Text("About")),
                      const PopupMenuItem(value: 2, child: Text("Skills")),
                      const PopupMenuItem(value: 3, child: Text("Projects")),
                      const PopupMenuItem(value: 4, child: Text("Contact")),
                    ],
                    onSelected: (v) {
                      // Note: These offsets might need slight adjustments depending on exact scaled heights
                      if (v == 1) _scrollTo(520);
                      if (v == 2) _scrollTo(980);
                      if (v == 3) _scrollTo(1400);
                      if (v == 4) _scrollTo(2200);
                    },
                  )
              ],
            ),

            // About section
            SliverToBoxAdapter(child: SizedBox(height: 40.h)),
            SliverToBoxAdapter(
              child: _SectionWrapper(title: "About", child: _AboutContent()),
            ),

            // Skills section
            SliverToBoxAdapter(child: _SectionWrapper(title: "Skills", child: _SkillsContent())),

            // Projects section
            SliverToBoxAdapter(child: _SectionWrapper(title: "Projects", child: _ProjectsContent())),

            // Contact section
            SliverToBoxAdapter(child: _SectionWrapper(title: "Contact", child: _ContactContent(email: email, github: github, linkedIn: linkedIn))),

            // Footer
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Center(child: Text("© ${DateTime.now().year} Sadakatul Ajam Md. Shakil")),
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {}
  }

  Future<void> _openMail(String mail) async {
    final uri = Uri(scheme: 'mailto', path: mail);
    if (!await launchUrl(uri)) {}
  }
}


/// Floating translucent blob
class _FloatingBlob extends StatelessWidget {
  final AnimationController controller;
  final double size;
  final Color color;
  const _FloatingBlob({super.key, required this.controller, required this.size, required this.color});

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
                // blur like glass - using .r for radius effects
                boxShadow: [BoxShadow(color: color.withOpacity(0.8), blurRadius: 40.r, spreadRadius: 6.r)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size / 2),
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/profile/profile.png',fit: BoxFit.cover)),
              ),
            )
        );
      },
    );
  }
}

class _FloatingRightBlob extends StatelessWidget {
  final AnimationController controller;
  final double size;
  final Color color;
  const _FloatingRightBlob({super.key, required this.controller, required this.size, required this.color});

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

/// Glass-style circular avatar
class _GlassAvatar extends StatelessWidget {
  final double size;
  final String initials;
  const _GlassAvatar({super.key, required this.size, required this.initials});

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

/// Project Preview Card used in hero
class _PreviewCard extends StatelessWidget {
  final String title;
  final String icon;
  final String url;
  final String subtitle;
  final double width;
  const _PreviewCard({
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

/// Section wrapper with title
class _SectionWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionWrapper({super.key, required this.title, required this.child});

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

/// About content widget
class _AboutContent extends StatefulWidget {
  const _AboutContent({super.key});

  @override
  State<_AboutContent> createState() => _AboutContentState();
}

class _AboutContentState extends State<_AboutContent> {
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

/// Skills content widget (chips + progress)
class _SkillsContent extends StatelessWidget {
  const _SkillsContent({super.key});


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

/// Projects content widget
class _ProjectsContent extends StatelessWidget {
  const _ProjectsContent({super.key});

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

/// Contact content widget
class _ContactContent extends StatelessWidget {
  final String email;
  final String github;
  final String linkedIn;
  const _ContactContent({super.key, required this.email, required this.github, required this.linkedIn});

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