import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar_search.dart';

class SearchChatPage extends StatefulWidget {
  const SearchChatPage({Key? key}) : super(key: key);

  @override
  State<SearchChatPage> createState() => _SearchChatPageState();
}

class _SearchChatPageState extends State<SearchChatPage> {
  String? searchQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarSearch(
        hintSearchText: "Cari obrolan",
        onChanged: (value) => setState(() => searchQuery = value),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: BlocBuilder<GetAllChatCubit, GetAllChatState>(
            builder: (_, state) {
              if (state is GetAllChatLoaded) {
                return BlocBuilder<GetUserDataCubit, GetUserDataState>(
                  builder: (_, myUserState) {
                    if (myUserState is GetUserDataLoaded) {
                      final chats = state.chats;
                      final myUser = myUserState.user;
                      return _buildChatList(context, myUser, chats);
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              } else if (state is GetAllChatLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blackColor,
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  ListView _buildChatList(
      BuildContext context, UserEntity myUser, List<ChatEntity> chats) {
    return ListView.builder(
        itemCount: chats.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          ChatEntity chat = chats[index];
          final otherUser = chat.memberData
              .firstWhere((otherUser) => otherUser.userId != myUser.userId);

          // Filter the chats based on search value
          if (otherUser.name!.toLowerCase().contains(searchQuery ?? "")) {
            return _buildChatItem(context, chat.recentMessage!, chat, myUser);
          }
          return const SizedBox();
        });
  }

  Widget _buildChatItem(BuildContext context, RecentMessageEntity message,
      ChatEntity chat, UserEntity myUser) {
    final otherUser = chat.memberData
        .firstWhere((otherUser) => otherUser.userId != myUser.userId);
    return GestureDetector(
      onTap: () {
        context.read<GetChatMessagesCubit>().getChatMessages(chat.chatId!);
        Navigator.pushNamed(context, NamedRoutes.personalChatScreen,
            arguments: {
              "my_user": MemberEntity.fromUserEntity(myUser).toMap(),
              "other_user": otherUser.toMap()
            });
      },
      child: CardChatItem(
        title: otherUser.name!,
        image: otherUser.imageProfile!,
        message: message,
        isBackgroundWhite: true,
      ),
    );
  }
}
