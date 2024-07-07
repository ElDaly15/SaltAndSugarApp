import 'package:flutter/material.dart';

class CustomHortizantalDivider extends StatelessWidget {
  const CustomHortizantalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey,
      endIndent: 100,
      indent: 100,
    );
  }
}
