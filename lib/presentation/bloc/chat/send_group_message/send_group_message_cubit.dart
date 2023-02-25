import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'send_group_message_state.dart';

class SendGroupMessageCubit extends Cubit<SendGroupMessageState> {
  final SendGroupMessageUseCase _sendGroupMessageUseCase;

  SendGroupMessageCubit(this._sendGroupMessageUseCase)
      : super(SendGroupMessageInitial());

  void sendGroupMessage(String groupChatId, MessageEntity message) async {
    emit(SendGroupMessageLoading());
    final result = await _sendGroupMessageUseCase.execute(groupChatId, message);
    result.fold(
      (failure) => emit(SendGroupMessageError(failure.message)),
      (successMessage) => emit(SendGroupMessageSuccess(successMessage)),
    );
  }
}
