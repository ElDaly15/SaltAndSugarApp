import 'package:flutter/material.dart';
import 'package:saltandsugar/core/model/product_model.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/custom_item_container.dart';

class CustomStackForItem extends StatelessWidget {
  const CustomStackForItem(
      {super.key, required this.productModel, required this.email});
  final ProductModel productModel;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomItemContainer(
          email: email,
          productModel: productModel,
        ),
        Positioned(
          right: 5,
          bottom: 70,
          child: Image.network(productModel.image),
          height: 120,
          width: 120,
        ),
      ],
    );
  }
}
