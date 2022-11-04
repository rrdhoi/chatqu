import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'get_users_list_state.dart';

class GetUsersListCubit extends Cubit<GetUsersListState> {
  final GetUsersListUseCase _getUsersListUseCase;

  GetUsersListCubit(this._getUsersListUseCase) : super(GetUsersListInitial());

  void getUsersList(List<String> usersId) async {
    emit(GetUsersListLoading());
    final result = await _getUsersListUseCase.execute(usersId);
    result.fold(
      (failure) => emit(GetUsersListError(failure.message)),
      (users) => emit(GetUsersListLoaded(users)),
    );
  }
}
