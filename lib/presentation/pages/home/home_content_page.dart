import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/domain/entities/chat_arguments.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:chatqu/presentation/widgets/header_screen.dart';

import '../../widgets/text_error_message.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({Key? key}) : super(key: key);

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchHeader(
              title: "Pesan",
              hintSearchText: "Cari obrolan",
              onSearchTap: () =>
                  Navigator.pushNamed(context, NamedRoutes.searchChatScreen),
            ),
            _buildChatList(context)
          ],
        ),
      ),
    );
  }

  Expanded _buildChatList(BuildContext context) {
    return Expanded(
      child: BlocBuilder<GetAllChatCubit, GetAllChatState>(
        builder: (_, state) {
          if (state is GetAllChatLoaded) {
            final chats = state.chats;
            return (chats.isEmpty)
                ? const TextErrorMessage(
                    errorMessage: "Mulai obrolan dengan\nteman anda")
                : BlocBuilder<GetUserDataCubit, GetUserDataState>(
                    builder: (_, myUserState) {
                      if (myUserState is GetUserDataLoaded) {
                        return _buildChatListContent(
                          chats,
                          context,
                          myUserState.user,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
          } else if (state is GetAllChatError) {
            return TextErrorMessage(
              errorMessage: (state.message.contains("type 'Null'"))
                  ? "Mulai obrolan dengan\nteman anda"
                  : "Terjadi kesalaha coba lagi",
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildChatListContent(
      List<ChatEntity> chats, BuildContext context, UserEntity myUser) {
    return ListView.builder(
      itemCount: chats.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) {
        return _buildChatItem(
            context, chats[index].recentMessage!, chats[index], myUser);
      },
    );
  }

  Widget _buildChatItem(BuildContext context, RecentMessageEntity recentMessage,
      ChatEntity chatData, UserEntity currentUser) {
    final chatPartner = chatData.memberData
        .firstWhere((user) => user.userId != currentUser.userId);
    final isGroup = chatData.groupData != null;

    return GestureDetector(
      onTap: () async => _onChatItemTapped(
          context, currentUser, chatData, isGroup, chatPartner),
      child: (isGroup)
          ? CardChatItem(
              title: chatData.groupData!.groupName!,
              image: chatData.groupData!.groupPicture,
              message: recentMessage,
            )
          : CardChatItem(
              title: chatPartner.name!,
              image: chatPartner.imageProfile,
              message: recentMessage,
            ),
    );
  }

  void _onChatItemTapped(BuildContext context, UserEntity currentUser,
      ChatEntity chatData, bool isGroup, MemberEntity chatPartner) async {
    if (isGroup) {
      context
          .read<GetGroupChatMessagesCubit>()
          .getGroupChatMessages(chatData.chatId!);

      final groupChatArguments = GroupChatArguments(
        groupChatId: chatData.chatId!,
        currentUserId: currentUser.userId!,
        groupName: chatData.groupData!.groupName!,
        groupMembersList: chatData.memberData,
      );

      Navigator.pushNamed(context, NamedRoutes.groupChatScreen,
          arguments: groupChatArguments);
    } else {
      context.read<GetChatMessagesCubit>().getChatMessages(chatData.chatId!);

      final personalChatArguments = PersonalChatArguments(
        myUser: MemberEntity(
          name: currentUser.name,
          userId: currentUser.userId,
          imageProfile: currentUser.imageProfile,
        ),
        otherUser: chatPartner,
      );

      Navigator.pushNamed(context, NamedRoutes.personalChatScreen,
          arguments: personalChatArguments);
    }
  }
}
