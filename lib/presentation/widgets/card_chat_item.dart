import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardChatItem extends StatelessWidget {
  final UserEntity user;
  final RecentMessageEntity? message;
  final bool isSearchUser;

  const CardChatItem({
    required this.user,
    this.message,
    this.isSearchUser = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sendAt = '';
    if (message?.sendAt != null) {
      final date = DateTime.parse(message?.sendAt as String);
      sendAt = '${date.hour}.${date.minute}';
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: 84,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 30),
            decoration: isSearchUser
                ? BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1.5,
                      color: AppColors.backgroundOutlineColor,
                    ),
                  ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: user.imageProfile == ''
                      ? Image.asset(AssetsPath.icProfile)
                      : FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration(milliseconds: 100),
                          fadeOutDuration: const Duration(milliseconds: 100),
                          placeholder: AssetsPath.icProfile,
                          image: user.imageProfile!,
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      user.name ?? '',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      message?.message ?? user.username ?? '',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message?.sendAt == null ? '' : sendAt,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
