import 'package:chatqu/app/configs/colors.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:chatqu/presentation/widgets/button_confirm.dart';
import 'package:flutter/material.dart';

class FriendRequestActionButton extends StatelessWidget {
  final UserEntity myUser;
  final List<UserEntity> otherUsers;
  final int index;

  const FriendRequestActionButton(
      {required this.myUser,
      required this.otherUsers,
      required this.index,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConfirmButton(
          title: "Accept",
          onPressed: () => context
              .read<AcceptFriendCubit>()
              .acceptFriend(myUser, otherUsers[index], true),
          backgroundColor: AppColors.greenColor,
        ),
        const SizedBox(width: 8),
        ConfirmButton(
          title: "Decline",
          onPressed: () => context
              .read<AcceptFriendCubit>()
              .acceptFriend(myUser, otherUsers[index], false),
          backgroundColor: AppColors.redColor,
        ),
      ],
    );
  }
}
