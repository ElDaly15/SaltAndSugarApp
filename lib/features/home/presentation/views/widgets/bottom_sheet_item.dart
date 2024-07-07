import 'package:flutter/material.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/add_product_from.dart';

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: 16,
          left: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: AddProduct(),
      ),
    );
  }
}
