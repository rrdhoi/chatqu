import 'package:chatqu/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  final GetUserDataUseCase getUserData;

  GetUserDataCubit(
    this.getUserData,
  ) : super(GetUserDataInitial());

  void getUser(String userId) async {
    emit(GetUserDataLoading());
    final result = await getUserData.execute(userId);
    result.fold(
      (failure) => emit(GetUserDataError(failure.message)),
      (user) => emit(GetUserDataLoaded(user)),
    );
  }
}
