import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saltandsugar/core/model/order_model.dart';
import 'package:saltandsugar/features/home/presentation/manager/get_orders_cubit/get_orders_cubit.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/custom_app_bar_profile.dart';
import 'package:saltandsugar/features/home/presentation/views/widgets/order_container_item.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key, required this.email});
  final String email;

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetOrdersCubit>(context).getOrders(email: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          CustomAppBarForProfile(),
          BlocBuilder<GetOrdersCubit, GetOrdersState>(
            builder: (context, state) {
              List<OrderModel> order =
                  BlocProvider.of<GetOrdersCubit>(context).orders;
              if (state is GetOrdersSuccess) {
                if (order.isEmpty) {
                  return Center(child: Text('No Orders Available Now ...'));
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: order.length,
                        itemBuilder: (context, index) {
                          return OrderContainerItem(
                            orderModel: order[index],
                          );
                        }),
                  );
                }
              } else if (state is GetOrdersLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text('An Error Occurred'));
              }
            },
          )
        ],
      ),
    );
  }
}
