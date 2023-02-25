import 'package:chatqu/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_friend_state.dart';

class AddFriendCubit extends Cubit<AddFriendState> {
  final AddFriendUseCase addFriendUseCase;

  AddFriendCubit(this.addFriendUseCase) : super(AddFriendInitial());

  void addFriend(UserEntity myUser, UserEntity otherUser) async {
    emit(AddFriendLoading());
    final result = await addFriendUseCase.execute(myUser, otherUser);
    result.fold(
      (l) => emit(AddFriendFailure(l.message)),
      (r) => emit(AddFriendSuccess(r)),
    );
  }
}
