import 'package:flutter/material.dart';
import 'dart:async';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _preloaderAnimation;
  late final Animation<double> _textSlideAnimation;
  late final Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
      ),
    );

    _textSlideAnimation = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );

    _preloaderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    Timer(const Duration(seconds: 6), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.easeInOutCubic;
            final tween = Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: curve),
            );
            final fadeAnimation = animation.drive(tween);

            return FadeTransition(
              opacity: fadeAnimation,
              child: Transform.scale(
                scale: Tween(begin: 1.1, end: 1.0)
                    .animate(animation)
                    .value,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003B73),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const Spacer(flex: 3),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/ireps_logo.png',
                      fit: BoxFit.fitHeight,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _textSlideAnimation.value),
                      child: Opacity(
                        opacity: _textFadeAnimation.value,
                        child: const Text(
                          'IREPS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'INDIAN RAILWAYS',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    letterSpacing: 1.5,
                  ),
                ),
                const Spacer(flex: 3),
                AnimatedBuilder(
                  animation: _preloaderAnimation,
                  builder: (context, child) {
                    return Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _preloaderAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF6B6B), Color(0xFFFFB746)],
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Efficiency',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4,
                        ),
                      ),
                      SizedBox(width: 7),
                      Text(
                        '•',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Transparency',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '•',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Ease of doing business',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}