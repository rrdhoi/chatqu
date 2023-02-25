import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'accept_friend_state.dart';

class AcceptFriendCubit extends Cubit<AcceptFriendState> {
  final AcceptFriendUseCase acceptFriendUseCase;

  AcceptFriendCubit(this.acceptFriendUseCase) : super(AcceptFriendInitial());

  void acceptFriend(
      UserEntity myUser, UserEntity otherUser, bool isAccepted) async {
    emit(AcceptFriendLoading());
    final result =
        await acceptFriendUseCase.execute(myUser, otherUser, isAccepted);
    result.fold(
      (l) => emit(AcceptFriendFailure(l.message)),
      (r) => emit(AcceptFriendSuccess(r)),
    );
  }
}
