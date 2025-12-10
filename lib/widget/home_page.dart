import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/widget/preview_card.dart';
import 'package:portfolio/widget/project_content.dart';
import 'package:portfolio/widget/section_warper.dart';
import 'package:portfolio/widget/skill_content.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_content.dart';
import 'contact_content.dart';
import 'floating_image_blob.dart';
import 'floating_right_bolb.dart';
import 'glass_avatar.dart';

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

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {}
  }

  Future<void> _openMail(String mail) async {
    final uri = Uri(scheme: 'mailto', path: mail);
    if (!await launchUrl(uri)) {}
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
                        child: FloatingBlob(
                            controller: _floatingController,
                            size: isNarrow ? 120.r : 200, // Scale size on mobile only
                            color: const Color(0xFF6BE0F9).withOpacity(0.18)),
                      ),
                      Positioned(
                        top: isNarrow ? 80.h : 140,
                        right: isNarrow ? 20.w : 50,
                        child: FloatingRightBlob(
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
                                                child: const PreviewCard(
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
                                                child: const PreviewCard(
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
                                                child: const PreviewCard(
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
                                                  GlassAvatar(size: 140, initials: "5+ years\nExperience"),
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
              child: SectionWrapper(title: "About", child: AboutContent()),
            ),

            // Skills section
            SliverToBoxAdapter(child: SectionWrapper(title: "Skills", child: SkillsContent())),

            // Projects section
            SliverToBoxAdapter(child: SectionWrapper(title: "Projects", child: ProjectsContent())),

            // Contact section
            SliverToBoxAdapter(child: SectionWrapper(title: "Contact", child: ContactContent(email: email, github: github, linkedIn: linkedIn))),

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
}