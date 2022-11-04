import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessageUseCase sendMessageUseCase;
  SendMessageCubit(this.sendMessageUseCase) : super(SendMessageInitial());

  void sendMessage(MessageEntity message, String otherChatId) async {
    emit(SendMessageLoading());
    final result = await sendMessageUseCase.execute(message, otherChatId);
    result.fold(
      (failure) => emit(SendMessageError(failure.message)),
      (message) => emit(SendMessageLoaded(message)),
    );
  }
}
