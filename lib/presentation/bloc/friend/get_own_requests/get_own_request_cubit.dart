import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'get_own_request_state.dart';

class GetOwnRequestCubit extends Cubit<GetOwnRequestState> {
  final GetOwnRequestsUseCase getOwnRequestsUseCase;

  GetOwnRequestCubit(this.getOwnRequestsUseCase)
      : super(GetOwnRequestInitial());

  void getOwnRequests(String myUser) async {
    emit(GetOwnRequestLoading());
    final result = await getOwnRequestsUseCase.execute(myUser);
    result.fold((failure) => emit(GetOwnRequestFailure(failure.message)),
        (users) => emit(GetOwnRequestSuccess(users)));
  }
}
