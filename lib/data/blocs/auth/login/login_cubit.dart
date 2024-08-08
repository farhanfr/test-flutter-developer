import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flutter_developer_enterkomputer/data/repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  /// Melakukan instansi pada class AuthRepository()
  final AuthRepository authRepo = AuthRepository();

  /// Fungsi untuk melakukan login
  void login({
    required String username,
    required String password,
  }) async {
    /// mengubah state menjadi LoginLoading
    emit(LoginLoading());
    try {
      /// menjalankan fungsi login
      await authRepo.login(username, password);
      /// mengubah state menjadi LoginSuccess jika fungsi login berhasil
      emit(LoginSuccess());
    } catch (e) {
      /// mengubah state menjadi LoginFailure jika fungsi login gagal
      emit(LoginFailure(e.toString()));
    }
  }
}
