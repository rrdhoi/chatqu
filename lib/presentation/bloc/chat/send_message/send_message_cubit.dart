import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessageUseCase sendMessageUseCase;
  SendMessageCubit(this.sendMessageUseCase) : super(SendMessageInitial());

  void sendMessage(MessageEntity message, MemberEntity userReceiver,
      MemberEntity myUser) async {
    emit(SendMessageLoading());
    final result =
        await sendMessageUseCase.execute(message, userReceiver, myUser);
    result.fold(
      (failure) => emit(SendMessageError(failure.message)),
      (isSuccess) => emit(SendMessageSuccess(isSuccess)),
    );
  }
}
