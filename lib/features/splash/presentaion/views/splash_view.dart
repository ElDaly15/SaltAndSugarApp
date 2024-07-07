import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandsugar/core/constants/constants.dart';
import 'package:saltandsugar/features/splash/presentaion/views/instraction_splash_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<Offset>(
      begin: const Offset(0, 9),
      end: Offset(0, 6),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.to(InstractionSplashView(),
          transition: Transition.fadeIn, duration: Duration(milliseconds: 250));
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(kLogo),
          SlideTransition(
            position: animation,
            child: const Text(
              'Daly Development',
              style: TextStyle(fontFamily: 'Gilroy-Bold'),
            ),
          ),
        ],
      ),
    );
  }
}
