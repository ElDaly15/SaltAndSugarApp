import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:saltandsugar/core/model/order_model.dart';

part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  GetOrdersCubit() : super(GetOrdersInitial());
  List<OrderModel> orders = [];

  void getOrders({required String email}) {
    try {
      orders.clear();
      emit(GetOrdersLoading());

      FirebaseFirestore.instance
          .collection('Orders')
          .where('email', isEqualTo: email)
          .snapshots()
          .listen((querySnapshot) {
        orders = querySnapshot.docs
            .map((doc) =>
                OrderModel.jsonData(doc.data() as Map<String, dynamic>))
            .toList();
        emit(GetOrdersSuccess());
      }, onError: (error) {
        emit(GetOrdersFailed());
      });
    } catch (e) {
      emit(GetOrdersFailed());
    }
  }
}
