import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataState());

  final AuthRepository authRepo = AuthRepository();
  // final ShippingRepository shippingRepo = ShippingRepository();

  void setData({User? user}) {
    emit(UserDataState(
      user: user,
    ));
  }

  void userLogout() {
    authRepo.logout();
    setData(
      user: null,
    );
    emit(UserDataNoAuth());
  }

  Future<void> appStarted() async {
    emit(UserDataInitial());
    try {
      final bool hasToken = authRepo.hasSession();
      Future.delayed(Duration(milliseconds: 0, seconds: 3), () async {
        if (hasToken == true) {
          print("MY SESSION ID : ${authRepo.getSession()}");
          loadUser();
        } else {
          emit(UserDataNoAuth());
          // setData(user: null, countCart: null);
        }
      });
    } catch (e) {
      print("APP STARTED ERROR : ${e.toString()}");
      emit(UserDataFailure(e.toString()));
    }
  }

  Future<void> loadUser() async {
    Future.delayed(Duration(milliseconds: 0, seconds: 2), () async {
      try {
        final FetchUserDataResponse userResponse =
            await authRepo.fetchProfileUser();
        // final CountCartResponse countCartResponse =
        //     await _cartRepository.countCart();

        debugPrint("ISI USER RESPONSE $userResponse");

        setData(
          user: userResponse.data,
        );
      } catch (error) {
        print("LOAD USER ERROR : ${error.toString()}");
        emit(UserDataFailure(error.toString()));
      }
    });
  }
}
