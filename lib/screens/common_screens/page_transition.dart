import 'package:flutter/material.dart';

class PageTransitionScreen extends StatefulWidget {
  final Widget nextPage;
  final Color primaryColor;
  final String message;
  final Duration waitDuration;

  const PageTransitionScreen({
    super.key,
    required this.nextPage,
    required this.primaryColor,
    this.message = 'Loading...',
    this.waitDuration = const Duration(milliseconds: 650),
  });

  @override
  State<PageTransitionScreen> createState() => _PageTransitionScreenState();
}

class _PageTransitionScreenState extends State<PageTransitionScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(widget.waitDuration, () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget.nextPage,
          transitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.14),
              ),
              child: const Icon(
                Icons.volunteer_activism_rounded,
                size: 62,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 26),
            const SizedBox(
              width: 34,
              height: 34,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
