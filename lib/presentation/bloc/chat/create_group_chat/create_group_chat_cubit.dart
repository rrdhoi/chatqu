import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';

part 'create_group_chat_state.dart';

class CreateGroupChatCubit extends Cubit<CreateGroupChatState> {
  final CreateGroupChatUseCase _createGroupUseCase;

  CreateGroupChatCubit(this._createGroupUseCase)
      : super(CreateGroupChatInitial());

  void createGroupChat(
      List<UserEntity> members, File imageFile, String groupName) async {
    final groupMembers =
        members.map((user) => MemberEntity.fromUserEntity(user)).toList();

    emit(CreateGroupChatLoading());
    final result =
        await _createGroupUseCase.execute(groupMembers, imageFile, groupName);

    result.fold(
      (failure) => emit(CreateGroupChatError(failure.message)),
      (chats) => emit(CreateGroupChatSuccess(chats)),
    );
  }
}
