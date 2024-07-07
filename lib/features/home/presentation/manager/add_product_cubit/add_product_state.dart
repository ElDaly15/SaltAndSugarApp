part of 'add_product_cubit.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}

final class AddProductSuccess extends AddProductState {
  final List<ProductModel> products;

  AddProductSuccess({required this.products});
}

final class AddProductLoading extends AddProductState {}

final class AddProductFail extends AddProductState {}
