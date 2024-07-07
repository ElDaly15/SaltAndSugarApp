import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saltandsugar/core/model/product_model.dart';
import 'package:saltandsugar/features/Product_Info/presentation/views/product_info_view.dart';

class CustomItemContainer extends StatelessWidget {
  const CustomItemContainer(
      {super.key, required this.productModel, required this.email});
  final ProductModel productModel;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              productModel.productName,
              style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: 17),
            ),
            Spacer(
              flex: 1,
            ),
            Row(
              children: [
                Text(
                  '\$${productModel.price}',
                  style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: 18),
                ),
                Spacer(
                  flex: 1,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(50, 40),
                  ),
                  onPressed: () {
                    Get.to(ProductInfoView(
                      email: email,
                      productModel: productModel,
                    ));
                  },
                  child: Text(
                    'Order Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gilroy-Bold',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
