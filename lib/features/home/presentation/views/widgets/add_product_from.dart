import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saltandsugar/core/widgets/CustomTextField.dart';
import 'package:saltandsugar/features/home/presentation/manager/add_product_cubit/add_product_cubit.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
final formKeyf = GlobalKey<FormState>();
String? productName;
String? Price;
String? image;

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formKeyf,
      child: Column(
        children: [
          CustomTextField(
              mainText: 'Product Name',
              onChange: (value) {
                productName = value;
              },
              textInputType: TextInputType.name,
              obscure: false),
          CustomTextField(
              textInputType: TextInputType.number,
              mainText: 'Price',
              onChange: (value) {
                Price = value;
              },
              obscure: false),
          CustomTextField(
              textInputType: TextInputType.name,
              mainText: 'Image',
              onChange: (value) {
                image = value;
              },
              obscure: false),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: Size(50, 40),
            ),
            onPressed: () {
              if (formKeyf.currentState != null &&
                  formKeyf.currentState!.validate()) {
                BlocProvider.of<AddProductCubit>(context).addProduct(
                    product: productName!, price: Price!, image: image!);
                Navigator.pop(context);
              } else {
                setState(() {
                  autovalidateMode = AutovalidateMode.always;
                });
              }
            },
            child: Text(
              'Add Product',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy-Bold',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
