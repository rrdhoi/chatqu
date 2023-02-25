import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'get_friend_request_state.dart';

class GetFriendRequestCubit extends Cubit<GetFriendRequestState> {
  final GetFriendRequestsUseCase getFriendRequestsUseCase;

  GetFriendRequestCubit(this.getFriendRequestsUseCase)
      : super(GetFriendRequestInitial());

  void getFriendRequests(String myUser) {
    emit(GetFriendRequestLoading());
    final result = getFriendRequestsUseCase.execute(myUser);
    result.fold(
      (failure) => emit(GetFriendRequestFailure(failure.message)),
      (chats) {
        chats.listen((users) => emit(GetFriendRequestSuccess(users)));
      },
    );
  }
}
