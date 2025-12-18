import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widget/home_page.dart';

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
          home: PortfolioHome(),
        );
      },
    );
  }
}