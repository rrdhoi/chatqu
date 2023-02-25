import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'get_all_chat_state.dart';

class GetAllChatCubit extends Cubit<GetAllChatState> {
  final GetAllChatUseCase getAllChatUseCase;

  GetAllChatCubit(this.getAllChatUseCase) : super(GetAllChatInitial());

  void getAllChat(String myUserId) {
    emit(GetAllChatLoading());
    final result = getAllChatUseCase.execute(myUserId);
    result.fold(
      (failure) => emit(GetAllChatError(failure.message)),
      (chats) {
        chats
            .listen((chats) => emit(GetAllChatLoaded(chats)))
            .onError((e) => emit(GetAllChatError(e.toString())));
      },
    );
  }
}
