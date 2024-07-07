import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saltandsugar/core/model/product_model.dart';
import 'package:saltandsugar/features/home/presentation/manager/add_product_cubit/add_product_cubit.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/custom_stack_item.dart';

class GridViewBuilderItem extends StatelessWidget {
  const GridViewBuilderItem({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        if (state is AddProductSuccess) {
          return Expanded(
            child: GridView.builder(
              itemCount: state.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 55,
                  crossAxisSpacing: 30),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomStackForItem(
                    email: email,
                    productModel: state.products[index],
                  ),
                );
              },
            ),
          );
        } else if (state is AddProductFail) {
          return Text('Error');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
