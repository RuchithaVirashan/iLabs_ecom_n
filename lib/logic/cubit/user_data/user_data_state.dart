part of 'user_data_cubit.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

class UserDataError extends UserDataState {
  final String message;
  UserDataError({required this.message});
}
