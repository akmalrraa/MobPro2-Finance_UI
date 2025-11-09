import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // Multiple animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeInOut)),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.8, curve: Curves.elasticOut)),
    );

    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.7, curve: Curves.easeOut)),
    );

    _controller.forward();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
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
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image dengan overlay gelap
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/finance_bg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark Overlay untuk kontras teks
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // Background Pattern efek tambahan
          _buildBackgroundPattern(),

          Center(
            child: SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon Finance sebagai pengganti logo
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // App Name dengan Fade Animation
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: const Text(
                        'Finance Mate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                          shadows: [
                            Shadow(
                              blurRadius: 15,
                              color: Colors.black,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Tagline
                    FadeTransition(
                      opacity: _opacityAnimation,
                      child: const Text(
                        'Your Smart Financial Companion',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Animated Loading Indicator
                    _buildLoadingIndicator(),
                  ],
                ),
              ),
            ),
          ),

          // Version info di bottom
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: const Column(
                children: [
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '© 2025 Finance Mate. All rights reserved',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return IgnorePointer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.8,
            colors: [
              Color(0x15FFFFFF),
              Color(0x00000000),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          // Progress Bar dengan animasi
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[800]!.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: [
                    // Animated Progress
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 200 * _controller.value,
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF3498DB),
                            Color(0xFF2ECC71),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2ECC71).withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Loading Text dengan dots animasi
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final dots = '...'.substring(0, ((_controller.value * 4) % 4).floor());
              return Text(
                'Loading$dots',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.2,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}