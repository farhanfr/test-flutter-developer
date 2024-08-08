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

  /// Fungsi untuk melakukan mengisi state user yang digunakan untuk mengambil data user
  void setDataUser({User? user}) {
    emit(UserDataState(
      user: user,
    ));
  }

  /// Fungsi untuk melakukan remove sessionId dan mengkosongkan state UserData
  void userLogout() {
    authRepo.logout();
    setDataUser(
      user: null,
    );
    emit(UserDataNoAuth());
  }

  /// Fungsi yang dijalankan saat user membuka aplikasi
  /// dilakukan cek session user, jika ada, load data user
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

  /// Fungsi yang dijalankan untuk melakukan load data user saat user memiliki session
  Future<void> loadUser() async {
    Future.delayed(Duration(milliseconds: 0, seconds: 2), () async {
      try {
        final FetchUserDataResponse userResponse =
            await authRepo.fetchProfileUser();
        setDataUser(
          user: userResponse.data,
        );
      } catch (error) {
        emit(UserDataFailure(error.toString()));
      }
    });
  }
}
