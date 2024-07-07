import 'package:flutter/material.dart';
import 'package:saltandsugar/features/splash/presentaion/data/model/splash_model.dart';

class CustomInstractionField extends StatelessWidget {
  const CustomInstractionField({super.key, required this.splashModel});
  final SplashModel splashModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.white, // Background color
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              SizedBox(
                width: 200,
                child: Text(
                  splashModel.title,
                  style: TextStyle(fontSize: 18, fontFamily: 'Gilroy-Bold'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 380,
                child: Text(
                  splashModel.subTitle,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(100, 40),
                      ),
                      onPressed: splashModel.onPressed,
                      child: const Icon(
                        Icons.double_arrow_sharp,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index == splashModel.index
                                ? Colors.black
                                : Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    splashModel.image, // Replace with your image asset path
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
