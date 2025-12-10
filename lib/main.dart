import 'dart:math' as math;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widget/animated_background.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
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
    // Check if the scroll offset is greater than the expanded height minus the collapsed height
    // The collapsed height of the SliverAppBar is typically kToolbarHeight (56.0)
    const double threshold = 520 - kToolbarHeight;

    // Use a dynamic threshold based on isNarrow for accuracy
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

  // Replace these with your real data
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
                        top: isNarrow ? 40 : 60,
                        left: isNarrow ? 20 : 80,
                        child: _FloatingBlob(controller: _floatingController, size: isNarrow ? 120 : 200, color: const Color(0xFF6BE0F9).withOpacity(0.18)),
                      ),
                      Positioned(
                        top: isNarrow ? 80 : 140,
                        right: isNarrow ? 20 : 50,
                        child: _FloatingRightBlob(controller: _floatingController, size: isNarrow ? 100 : 180, color: const Color(0xFF7C4DFF).withOpacity(0.18)),
                      ),

                      // Main hero content
                      Positioned.fill(
                        child: Align(
                          alignment: isNarrow ? Alignment.center : Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: isNarrow ? 20 : 80, vertical: isNarrow ? 20 : 60),
                            child: ConstrainedBox(
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
                                        Text("Hi, I’m", style: TextStyle(fontSize: isNarrow ? 16 : 18, color: Colors.white.withOpacity(0.9))),
                                        const SizedBox(height: 6),
                                        Text("Sadakatul Ajam Md. Shakil",
                                            style: TextStyle(fontSize: isNarrow ? 28 : 44, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                                        const SizedBox(height: 12),
                                        DefaultTextStyle(
                                          style: TextStyle(fontSize: isNarrow ? 14 : 20, color: Colors.white70),
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
                                        const SizedBox(height: 20),
                                        Wrap(
                                          spacing: 12,
                                          runSpacing: 12,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () => _openUrl(github),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.black,
                                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                              ),
                                              child: const Text("View GitHub"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () => _openMail(email),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black87,
                                                foregroundColor: Colors.white,
                                                side: BorderSide(color: Colors.white.withOpacity(0.2)),
                                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            // Floating project preview card
                                            Positioned(
                                              right: 0,
                                              top: 10,
                                              child: Transform.rotate(
                                                angle: -0.06,
                                                child: _PreviewCard(
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
                                                child: _PreviewCard(
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
                                                child: _PreviewCard(
                                                  title: "WZPDCL",
                                                  icon: "assets/icons/wzpdcl.png",
                                                  url: "https://play.google.com/store/search?q=wzpdcl&c=apps",
                                                  subtitle: "Electricity Bill Management",
                                                  width: 320,
                                                ),
                                              ),
                                            ),

                                            // Avatar with glass ring
                                            Positioned(
                                              left: -100,
                                              top: 100,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  _GlassAvatar(size: 140, initials: "5+ years\nExperience"),
                                                  const SizedBox(height: 12),
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
                          style: TextStyle(fontSize: 18,
                              color: Colors.white)
                      ),
                      DefaultTextStyle(
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF7C4DFF).withOpacity(.9)),
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
                  TextButton(onPressed: () => _scrollTo(520), child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                        child: const Text("About", style: TextStyle(color: Colors.white),),
                      ))),
                  TextButton(onPressed: () => _scrollTo(980), child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                    child: const Text("Skills", style: TextStyle(color: Colors.white)),
                  ))),
                  TextButton(onPressed: () => _scrollTo(1400), child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                              child: const Text("Projects", style: TextStyle(color: Colors.white)),
                                            ))),
                  TextButton(onPressed: () => _scrollTo(2200), child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
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
                      if (v == 1) _scrollTo(520);
                      if (v == 2) _scrollTo(980);
                      if (v == 3) _scrollTo(1400);
                      if (v == 4) _scrollTo(2200);
                    },
                  )
              ],
            ),

            // About section
            SliverToBoxAdapter(child: SizedBox(height: 40)),
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
                padding: const EdgeInsets.symmetric(vertical: 40),
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
  const _FloatingBlob({required this.controller, required this.size, required this.color});

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
              boxShadow: [BoxShadow(color: color.withOpacity(0.8), blurRadius: 40, spreadRadius: 6)],
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
  const _FloatingRightBlob({required this.controller, required this.size, required this.color});

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
                boxShadow: [BoxShadow(color: color.withOpacity(0.8), blurRadius: 40, spreadRadius: 6)],
              ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size / 2),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    // --- MODIFICATION HERE ---
                    child: FractionallySizedBox(
                      widthFactor: 0.7, // e.g., make the image 70% of the container width
                      heightFactor: 0.7, // e.g., make the image 70% of the container height
                      child: Image.asset(
                        opacity: const AlwaysStoppedAnimation<double>(0.5),
                        'assets/profile/hologram.png',
                        fit: BoxFit.contain, // Use BoxFit.contain to prevent cropping
                      ),
                    ),
                    // -------------------------
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
  const _GlassAvatar({required this.size, required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 12,
      height: size + 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((size + 12) / 2),
        gradient: LinearGradient(colors: [Colors.white.withOpacity(0.06), Colors.white.withOpacity(0.02)]),
        border: Border.all(color: Colors.white10, width: 1.5),
      ),
      child: Center(
        child: CircleAvatar(
          radius: size / 2,
          backgroundColor: Colors.deepPurple.shade400,
          child: Text(initials, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
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
    required this.title,
    required this.subtitle,
    required this.width,
    required this.icon,
    required  this.url});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (!await launchUrl(uri)) {}
        },
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.white.withOpacity(0.06), Colors.white.withOpacity(0.02)]),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20, offset: const Offset(0, 8))],
        ),
        child: Row(
          children: [
            Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade200, borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(icon, fit: BoxFit.contain),
                )
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 10),
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
  const _SectionWrapper({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 24),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

/// About content widget
class _AboutContent extends StatefulWidget {
  @override
  State<_AboutContent> createState() => _AboutContentState();
}

class _AboutContentState extends State<_AboutContent> {
  // 2. Add State variable to manage expansion
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

    // 3. Determine the text content based on state and width
    String currentDescription;
    bool showToggle = false;

    if (isNarrow) {
      // Narrow View: Truncate initially, expand on click
      currentDescription = basicDescription + (_isExpanded ? academicDetails : '');
      showToggle = true;
    } else {
      // Wide View: Always show full text
      currentDescription = fullDescription;
      showToggle = false;
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        // Use a Column when narrow, Row when wide
        child: isNarrow
            ? AnimatedSize(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              child: Column(
                        children: _buildContent(context, isNarrow, currentDescription, showToggle),
                      ),
            )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to top for better look
          children: _buildContent(context, isNarrow, currentDescription, showToggle),
        ),
      ),
    );
  }

  // Helper method to build the content list
  List<Widget> _buildContent(BuildContext context, bool isNarrow, String description, bool showToggle) {
    return [
      // Left/Top: Image / Avatar Section
      Expanded(
        flex: isNarrow ? 0 : 1, // Don't give fixed flex on narrow
        child: Column(
          children: [
            const SizedBox(height: 6),
            const CircleAvatar(radius: 64, backgroundColor: Colors.deepPurple,
                child: Text("SA", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold))),
            const SizedBox(height: 12),
            isNarrow
                ? Text("Flutter Developer • Problem Solver • 5+ Years Experience", style: TextStyle(color: Colors.white70))
                : Text("Flutter Developer • Problem Solver", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),

      // Spacer for wide view
      if (!isNarrow) const SizedBox(width: 24),

      // Right/Bottom: Description and Toggle Button
      Expanded(
        flex: isNarrow ? 0 : 2,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isNarrow ? 0 : 24, vertical: isNarrow ? 20 : 0),
          child: Column(
            crossAxisAlignment: isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                description,
                textAlign: isNarrow ? TextAlign.start : TextAlign.left,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),

              // Conditional Inline Toggle Button
              if (showToggle) ...[
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(12),
                    side: BorderSide(color: Colors.white30),
                    minimumSize: const Size(50, 30),
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
                        size: 20,
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
    GridView.builder(
      // IMPORTANT: GridView must be constrained in height if inside a Column/SingleChildScrollView
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
      padding: const EdgeInsets.all(8.0),
      itemCount: skills.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 2.4,
      ),
      itemBuilder: (context, index) {
        final s = skills[index];
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white10,
                ),
                child: LinearProgressIndicator(
                  value: s["level"],
                  minHeight: 8,
                  color: Colors.deepPurple.shade400,
                  backgroundColor: Colors.transparent,
                ),
              ),
              const SizedBox(height: 6),
              Text("${(s["level"] * 100).toInt()}%", style: const TextStyle(color: Colors.white70)),
            ],
          ),
        );
      },
    ):
    Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Wrap(
          spacing: 18,
          runSpacing: 18,
          alignment: WrapAlignment.start,
          children: skills.map((s) {
            return SizedBox(
              width: 300,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                color: Colors.white.withOpacity(0.05),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white10,
                      ),
                      child: LinearProgressIndicator(
                          value: s["level"],
                          minHeight: 8,
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
    GridView.builder(
      // IMPORTANT: GridView must be constrained in height if inside a Column/SingleChildScrollView
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
      padding: const EdgeInsets.all(8.0),
      itemCount: projects.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        final p = projects[index];
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset(p['cover_photo']!, fit: BoxFit.cover, height: 50,),
              const SizedBox(height: 6),
              Text(p["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 3),
              Text(p["desc"]!, style: const TextStyle(color: Colors.white70,fontSize: 10)),
              const SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text("View", style: TextStyle(color: Color(0xFF7C4DFF), fontSize: 8))]),
            ]),
          ),
        );
      },
    )
        :Center(
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
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white10),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 18, offset: const Offset(0, 8))],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                          height: 160,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple.shade400,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Image.asset(p['cover_photo']!, fit: BoxFit.cover)
                      ),
                      const SizedBox(height: 12),
                      Text(p["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 6),
                      Text(p["desc"]!, style: const TextStyle(color: Colors.white70)),
                      const SizedBox(height: 12),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text("View", style: TextStyle(color: Color(0xFF7C4DFF)))]),
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
  const _ContactContent({required this.email, required this.github, required this.linkedIn});

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
          const SizedBox(height: 6),
          const Text("I’m available for freelance & full-time (Remote + On-site) roles. Let’s build something great together.", textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Wrap(spacing: 12, children: [
            ElevatedButton(
              onPressed: () => _mail(email),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withOpacity(0.2)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Email Me"),
            ),
            ElevatedButton(
              onPressed: () => _open(github),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withOpacity(0.2)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("GitHub"),
            ),
            ElevatedButton(
              onPressed: () => _open(linkedIn),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withOpacity(0.2)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("LinkedIn"),
            ),
          ]),
        ]),
      ),
    );
  }
}
