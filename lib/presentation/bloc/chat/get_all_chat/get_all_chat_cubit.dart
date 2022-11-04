import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'get_all_chat_state.dart';

class GetAllChatCubit extends Cubit<GetAllChatState> {
  final GetAllChatUseCase getAllChatUseCase;
  GetAllChatCubit(this.getAllChatUseCase) : super(GetAllChatInitial());

  void getAllChat() {
    emit(GetAllChatLoading());
    final result = getAllChatUseCase.execute();
    result.fold(
      (failure) => emit(GetAllChatError(failure.message)),
      (chats) => emit(GetAllChatLoaded(chats)),
    );
  }
}
