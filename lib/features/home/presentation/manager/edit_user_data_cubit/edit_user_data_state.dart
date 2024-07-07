part of 'edit_user_data_cubit.dart';

@immutable
sealed class EditUserDataState {}

final class EditUserDataInitial extends EditUserDataState {}

final class EditUserDataLoading extends EditUserDataState {}

final class EditUserDataSuccess extends EditUserDataState {}

final class EditUserDataFailed extends EditUserDataState {}
