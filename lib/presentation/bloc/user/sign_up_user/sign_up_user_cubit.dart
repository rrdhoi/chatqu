import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'sign_up_user_state.dart';

class SignUpUserCubit extends Cubit<SignUpUserState> {
  final SignUpUserUseCase _signUpUser;

  SignUpUserCubit(this._signUpUser) : super(SignUpUserInitial());

  void signUpUser(UserEntity userEntity, String password) async {
    emit(SignUpUserLoading());
    final result = await _signUpUser.execute(userEntity, password);
    result.fold(
      (failure) => emit(SignUpUserError(failure.message)),
      (message) => emit(SignUpUserLoaded(message)),
    );
  }
}
