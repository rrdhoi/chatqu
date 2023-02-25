import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/widgets/card_row_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardChatItem extends StatelessWidget {
  final RecentMessageEntity? message;
  final bool isBackgroundWhite;
  final String? image;
  final String title;

  const CardChatItem({
    required this.title,
    required this.image,
    this.message,
    this.isBackgroundWhite = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sendAt = (message?.sendAt != null)
        ? DateFormat('HH.mm').format(message!.sendAt!.toDate())
        : "";

    return CardRowItem(
      image: image,
      title: title,
      subTitle: message?.message,
      isBackgroundWhite: isBackgroundWhite,
      rightCornerWidget: Text(
        sendAt,
        textAlign: TextAlign.start,
        style: GoogleFonts.quicksand(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.greyTextColor,
        ),
      ),
    );
  }
}
