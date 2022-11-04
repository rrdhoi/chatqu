import 'package:bloc/bloc.dart';
import 'package:chatqu/domain/domain.dart';

part 'sign_out_user_state.dart';

class SignOutUserCubit extends Cubit<SignOutUserState> {
  SignOutUserUseCase signOutUserUseCase;

  SignOutUserCubit(this.signOutUserUseCase) : super(SignOutUserInitial());

  void signOutUser() async {
    emit(SignOutUserLoading());
    final result = await signOutUserUseCase.execute();
    result.fold(
      (failure) => emit(SignOutUserError(failure.message)),
      (message) => emit(SignOutUserLoaded(message)),
    );
  }
}
