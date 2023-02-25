import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'get_group_chat_messages_state.dart';

class GetGroupChatMessagesCubit extends Cubit<GetGroupChatMessagesState> {
  final GetGroupChatMessagesUseCase _getGroupChatMessagesUseCase;

  GetGroupChatMessagesCubit(this._getGroupChatMessagesUseCase)
      : super(GetGroupChatMessagesInitial());

  void getGroupChatMessages(String chatId) async {
    emit(GetGroupChatMessagesLoading());
    final result = _getGroupChatMessagesUseCase.execute(chatId);
    result.fold(
      (failure) => emit(GetGroupChatMessagesError(failure.message)),
      (stream) => stream
          .listen((messages) => emit(GetGroupChatMessagesLoaded(messages))),
    );
  }
}
