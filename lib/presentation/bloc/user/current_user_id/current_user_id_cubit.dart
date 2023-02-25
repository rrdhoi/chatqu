import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'current_user_id_state.dart';

class CurrentUserIdCubit extends Cubit<CurrentUserIdState> {
  final CurrentUserIdUseCase currentUserIdUseCase;

  CurrentUserIdCubit(this.currentUserIdUseCase) : super(CurrentUserIdInitial());

  void getCurrentUserId() {
    emit(CurrentUserIdLoading());
    final result = currentUserIdUseCase.execute();
    result.fold(
      (failure) => emit(CurrentUserIdError(failure.message)),
      (streamUser) =>
          streamUser.listen((status) => emit(CurrentUserIdLoaded(status))),
    );
  }
}
