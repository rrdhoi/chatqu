import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'search_user_by_username_state.dart';

class SearchUserByUsernameCubit extends Cubit<SearchUserByUsernameState> {
  final SearchUserByUsernameUseCase searchUserByUsername;

  SearchUserByUsernameCubit(this.searchUserByUsername)
      : super(SearchUserByUsernameInitial());

  void searchUsername(String username) async {
    emit(SearchUserByUsernameLoading());
    final result = await searchUserByUsername.execute(username);
    result.fold(
      (failure) => emit(SearchUserByUsernameError(failure.message)),
      (user) => emit(SearchUserByUsernameLoaded(user)),
    );
  }
}
