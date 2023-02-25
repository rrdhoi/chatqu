import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'get_chat_messages_state.dart';

class GetChatMessagesCubit extends Cubit<GetChatMessagesState> {
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final RetrieveChatUseCase _retrieveChatUseCase;

  GetChatMessagesCubit(this._getChatMessagesUseCase, this._retrieveChatUseCase)
      : super(GetChatMessagesInitial());

  void getChatMessages(String chatId) async {
    emit(GetChatMessagesLoading());
    final result = _getChatMessagesUseCase.execute(chatId);
    result.fold(
        (failure) => emit(GetChatMessagesErrorOrEmpty(failure.message)),
        (stream) =>
            stream.listen((messages) => emit(GetChatMessagesLoaded(messages))));
  }

  void retrieveChat(String otherUserId, String myUserId) async {
    emit(GetChatMessagesLoading());
    final result = await _retrieveChatUseCase.execute(otherUserId, myUserId);
    result.fold(
      (failure) => emit(GetChatMessagesErrorOrEmpty(failure.message)),
      (chat) => getChatMessages(chat.chatId ?? ''),
    );
  }
}
