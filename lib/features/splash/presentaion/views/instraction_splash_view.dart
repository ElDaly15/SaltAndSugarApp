import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandsugar/features/Login/presentation/views/Login_view.dart';
import 'package:saltandsugar/features/Register/presentaion/views/register_view.dart';
import 'package:saltandsugar/features/splash/presentaion/data/model/splash_model.dart';
import 'package:saltandsugar/features/splash/presentaion/views/widgets/custom_instraction_field.dart';

class InstractionSplashView extends StatefulWidget {
  const InstractionSplashView({super.key});

  @override
  _InstractionSplashViewState createState() => _InstractionSplashViewState();
}

class _InstractionSplashViewState extends State<InstractionSplashView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _timer?.cancel();
      _startTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentPage < 2) {
        // Assuming you have 3 pages (0, 1, 2)
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      } else {
        _timer?.cancel(); // Stop the timer when reaching the last page
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          CustomInstractionField(
            splashModel: SplashModel(
              image: 'assets/images/pos_res_1.png',
              title: 'Welcome To Salt&Sugar Resturant',
              subTitle:
                  'Our Restaurant is Qualified As Best Restaurant at 2023',
              index: _currentPage == 0 ? 0 : -1,
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          CustomInstractionField(
            splashModel: SplashModel(
              image: 'assets/images/e1.png',
              title: 'Order and Online Menu Now',
              subTitle:
                  'For Ordering billing and tracking in now 10x easier , From last Update',
              index: _currentPage == 1 ? 1 : -1,
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          CustomInstractionField(
            splashModel: SplashModel(
              image: 'assets/images/e2.png',
              title: 'Billing and Payment',
              subTitle:
                  'For Our Customers , Now You Can Pay Without Casher Only With the app from your chair',
              index: _currentPage == 2 ? 2 : -1,
              onPressed: () {
                Get.to(LoginView(),
                    duration: Duration(milliseconds: 250),
                    transition: Transition.rightToLeftWithFade);
              },
            ),
          ),
        ],
      ),
    );
  }
}
