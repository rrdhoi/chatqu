import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'get_all_friends_state.dart';

class GetAllFriendsCubit extends Cubit<GetAllFriendsState> {
  final GetAllFriendsUseCase getAllFriendsUseCase;

  GetAllFriendsCubit(this.getAllFriendsUseCase) : super(GetAllFriendsInitial());

  void getAllFriends(String myUser) {
    emit(GetAllFriendsLoading());
    final result = getAllFriendsUseCase.execute(myUser);
    result.fold(
      (failure) => emit(GetAllFriendsFailure(failure.message)),
      (chats) {
        chats.listen((users) => emit(GetAllFriendsSuccess(users)));
      },
    );
  }
}
