import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/pages/friends/friend_request_action_button.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:chatqu/presentation/widgets/card_row_item.dart';
import 'package:chatqu/presentation/widgets/custom_app_bar.dart';

class FriendRequestPage extends StatelessWidget {
  const FriendRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Permintaan Pertemanan",
        onBackButtonPressed: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: BlocBuilder<GetUserDataCubit, GetUserDataState>(
          builder: (context, myUserState) {
            if (myUserState is GetUserDataLoaded) {
              return BlocBuilder<GetFriendRequestCubit, GetFriendRequestState>(
                builder: (context, requestState) {
                  if (requestState is GetFriendRequestSuccess) {
                    if (requestState.users.isEmpty) {
                      return Center(
                        child: Text(
                          "Belum ada permintaan\npertemanan!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                        ),
                      );
                    } else {
                      return _buildListOfUsers(
                        requestState.users,
                        myUserState.user,
                        context,
                      );
                    }
                  } else if (requestState is GetFriendRequestFailure) {
                    return Center(
                      child: Text(
                        "Terjadi kesalahan coba lagi!",
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blackColor,
                      ),
                    );
                  }
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  ListView _buildListOfUsers(
      List<UserEntity> otherUsers, UserEntity myUser, BuildContext context) {
    return ListView.builder(
      itemCount: otherUsers.length,
      padding: const EdgeInsets.only(bottom: 16),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) => CardRowItem(
        image: otherUsers[index].imageProfile,
        title: otherUsers[index].name!,
        subTitle: otherUsers[index].username,
        isBackgroundWhite: true,
        rightCornerWidget: FriendRequestActionButton(
          myUser: myUser,
          otherUsers: otherUsers,
          index: index,
        ),
      ),
    );
  }
}
