import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:saltandsugar/core/model/product_model.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  addProduct(
      {required String product, required String price, required String image}) {
    products.add({'productName': product, 'price': price, 'Image': image});
  }

  void displayProduct() {
    var stream = products.snapshots().listen((data) {
      emit(AddProductLoading());
      try {
        List<ProductModel> productList = [];
        for (int i = 0; i < data.docs.length; i++) {
          productList.add(ProductModel.formJson(data.docs[i].data()));
        }
        emit(AddProductSuccess(products: productList));
      } catch (e) {
        emit(AddProductFail());
      }
    });
  }
}
