import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'get_chat_messages_state.dart';

class GetChatMessagesCubit extends Cubit<GetChatMessagesState> {
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final CheckChatExistUseCase _checkChatExistUseCase;

  GetChatMessagesCubit(
      this._getChatMessagesUseCase, this._checkChatExistUseCase)
      : super(GetChatMessagesInitial());

  void getChatMessages(String chatId) async {
    emit(GetChatMessagesLoading());
    final result = _getChatMessagesUseCase.execute(chatId);
    result.fold(
      (failure) => emit(GetChatMessagesError(failure.message)),
      (chats) => emit(GetChatMessagesLoaded(chats)),
    );
  }

  void checkChatExist(String otherUserId) async {
    emit(GetChatMessagesLoading());
    final result = await _checkChatExistUseCase.execute(otherUserId);
    result.fold(
      (failure) => emit(GetChatMessagesError(failure.message)),
      (chat) => getChatMessages(chat.chatId ?? ''),
    );
  }
}
