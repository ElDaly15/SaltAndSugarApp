import 'package:flutter/material.dart';
import 'package:saltandsugar/core/model/order_model.dart';

class OrderContainerItem extends StatelessWidget {
  const OrderContainerItem({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 100,
        width: double.infinity,
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
        child: Row(
          children: [
            Image.network(
              orderModel.image,
              height: 100,
              width: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      orderModel.productName,
                      style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: 18),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Total Price :${orderModel.price} ',
                      style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: 16),
                    ),
                  ],
                ),
                Text(
                  'Quantity : ${orderModel.Quantity}',
                  style: TextStyle(fontFamily: 'Gilroy-Bold', fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
