import 'package:chatqu/data/data.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'sign_in_user_state.dart';

class SignInUserCubit extends Cubit<SignInUserState> {
  final SignInUserUseCase _signInUser;
  SignInUserCubit(this._signInUser) : super(SignInUserInitial());

  void signInUser(String email, String password) async {
    emit(SignInUserLoading());
    final result = await _signInUser.execute(email, password);
    result.fold(
      (failure) => emit(SignInUserError(failure.message)),
      (user) => emit(SignInUserLoaded(user)),
    );
  }
}
