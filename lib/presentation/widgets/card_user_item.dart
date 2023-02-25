import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:flutter/material.dart';

import 'card_row_item.dart';

class CardUserItem extends StatelessWidget {
  final UserEntity user;
  final bool isAdded;
  final bool isFriend;
  final Function() onAddFriend;

  const CardUserItem({
    required this.user,
    required this.isAdded,
    this.isFriend = false,
    required this.onAddFriend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardRowItem(
      image: user.imageProfile,
      title: user.name ?? '',
      subTitle: user.username,
      isBackgroundWhite: true,
      rightCornerWidget: (isAdded || isFriend)
          ? OutlinedButton(
              onPressed: null,
              style: OutlinedButton.styleFrom(
                primary: AppColors.backgroundOutlineColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isFriend ? "Friends" : "Added",
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyColor,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onAddFriend,
              style: ElevatedButton.styleFrom(
                  primary: AppColors.greenColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Text(
                "Add",
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
    );
  }
}
