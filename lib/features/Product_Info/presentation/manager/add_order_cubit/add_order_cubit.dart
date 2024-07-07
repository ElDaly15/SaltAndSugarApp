import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit() : super(AddOrderInitial());
  CollectionReference OrderDetails =
      FirebaseFirestore.instance.collection('Orders');

  addOrder(
      {required String name,
      required String address,
      required int quantity,
      required String mobileNum,
      required String email,
      required String ProductName,
      required String Price,
      required String image}) {
    try {
      emit(AddOrderLoading());
      OrderDetails.add({
        'name': name,
        'address': address,
        'Quanitiy': quantity,
        'MobileNumber': mobileNum,
        'email': email,
        'ProductName': ProductName,
        'Price': Price,
        'imageOfProuct': image
      });
      emit(AddOrderSuccess());
    } catch (e) {
      emit(AddOrderFailed());
    }
  }
}
