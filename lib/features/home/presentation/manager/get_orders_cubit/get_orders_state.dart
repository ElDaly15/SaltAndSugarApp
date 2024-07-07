part of 'get_orders_cubit.dart';

@immutable
sealed class GetOrdersState {}

final class GetOrdersInitial extends GetOrdersState {}

final class GetOrdersSuccess extends GetOrdersState {}

final class GetOrdersFailed extends GetOrdersState {}

final class GetOrdersLoading extends GetOrdersState {}
