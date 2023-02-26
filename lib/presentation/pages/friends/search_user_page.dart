import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:chatqu/presentation/widgets/card_user_item.dart';
import 'package:chatqu/presentation/widgets/custom_app_bar_search.dart';

class SearchUserPage extends StatelessWidget {
  const SearchUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarSearch(
        hintSearchText: "Cari Pengguna",
        onSubmitted: (value) =>
            context.read<SearchUserByUsernameCubit>().searchUsername(value),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<GetUserDataCubit, GetUserDataState>(
        builder: (context, userState) {
          if (userState is GetUserDataLoaded) {
            final myUser = userState.user;
            return BlocBuilder<SearchUserByUsernameCubit,
                SearchUserByUsernameState>(builder: (_, state) {
              if (state is SearchUserByUsernameLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.blackColor),
                );
              } else if (state is SearchUserByUsernameLoaded) {
                final username = state.user.username;
                return (username != '' &&
                        username != null &&
                        username != myUser.username!)
                    ? _buildUser(context, state.user, myUser)
                    : SizedBox(
                        height: 84,
                        child: Center(
                          child: Text(
                            'Username tidak ditemukan',
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      );
              } else {
                return const SizedBox();
              }
            });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildUser(
          BuildContext context, UserEntity otherUser, UserEntity myUser) =>
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            BlocBuilder<GetOwnRequestCubit, GetOwnRequestState>(
              builder: (context, ownRequestState) {
                if (ownRequestState is GetOwnRequestSuccess) {
                  final bool isAdded =
                      ownRequestState.users.contains(otherUser);
                  return BlocBuilder<GetAllFriendsCubit, GetAllFriendsState>(
                    builder: (context, friendsState) {
                      if (friendsState is GetAllFriendsSuccess) {
                        final isFriends =
                            friendsState.users.contains(otherUser);
                        return CardUserItem(
                          user: otherUser,
                          isAdded: isAdded,
                          isFriend: isFriends,
                          onAddFriend: () {
                            context
                                .read<AddFriendCubit>()
                                .addFriend(myUser, otherUser);
                            context
                                .read<GetOwnRequestCubit>()
                                .getOwnRequests(myUser.userId!);
                          },
                        );
                      } else {
                        return CardUserItem(
                          user: otherUser,
                          isAdded: false,
                          onAddFriend: () {},
                        );
                      }
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      );
}
