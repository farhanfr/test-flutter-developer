part of 'user_data_cubit.dart';

class UserDataState extends Equatable {
  const UserDataState({ this.user});

  final User? user;

  @override
  List<Object?> get props => [user];
}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataNoAuth extends UserDataState {}

class UserDataFailure extends UserDataState {
  UserDataFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}