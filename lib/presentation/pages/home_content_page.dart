import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildHeader(context),
            Expanded(
              child: BlocBuilder<GetAllChatCubit, GetAllChatState>(
                builder: (_, state) {
                  if (state is GetAllChatLoaded) {
                    return StreamBuilder<List<ChatEntity>>(
                        stream: state.chats,
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            final chats = snapshot.data!;
                            final usersIdChat = List<String>.generate(
                                chats.length,
                                (index) => chats[index].members.first!);

                            context
                                .read<GetUsersListCubit>()
                                .getUsersList(usersIdChat);

                            return BlocBuilder<GetUsersListCubit,
                                GetUsersListState>(builder: (_, userState) {
                              if (userState is GetUsersListLoaded) {
                                List<UserEntity> sortUsersByChat = [];
                                for (var chat in chats) {
                                  for (var user in userState.usersList) {
                                    if (chat.members.first! == user.userId) {
                                      sortUsersByChat.add(user);
                                    }
                                  }
                                }

                                return BlocBuilder<CurrentUserIdCubit,
                                    CurrentUserIdState>(
                                  builder: (_, stateCurrentUser) {
                                    if (stateCurrentUser
                                        is CurrentUserIdLoaded) {
                                      return ListView.builder(
                                        itemCount: chats.length,
                                        itemBuilder: (_, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<GetChatMessagesCubit>()
                                                  .getChatMessages(
                                                      chats[index].chatId!);
                                              context
                                                  .read<GetUserDataCubit>()
                                                  .getUser(
                                                      stateCurrentUser.userId);
                                              Navigator.pushNamed(context,
                                                  NamedRoutes.chatScreen,
                                                  arguments:
                                                      sortUsersByChat[index]
                                                          .toMap());
                                            },
                                            child: CardChatItem(
                                              user: sortUsersByChat[index],
                                              message:
                                                  chats[index].recentMessage,
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            });
                          } else {
                            return const SizedBox();
                          }
                        });
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) => [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pesan",
              textAlign: TextAlign.start,
              style: GoogleFonts.quicksand(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),
            Image.asset(AssetsPath.icCategory, width: 24, height: 24),
          ],
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, NamedRoutes.searchScreen),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cari Pengguna",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greyTextColor,
                  ),
                ),
                Image.asset(AssetsPath.icSearch, width: 24, height: 24),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ];
}
