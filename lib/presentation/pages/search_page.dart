import 'package:chatqu/app/app.dart';
import 'package:chatqu/domain/domain.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearch(context),
            const SizedBox(height: 24),
            BlocBuilder<SearchUserByUsernameCubit, SearchUserByUsernameState>(
                builder: (_, state) {
              if (state is SearchUserByUsernameLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.blackColor),
                );
              } else if (state is SearchUserByUsernameLoaded) {
                return state.user.username != '' && state.user.username != null
                    ? _buildUser(context, state.user)
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
            })
          ],
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 95,
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.blackColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: SizedBox(
              child: TextField(
                autofocus: true,
                onSubmitted: (value) {
                  context
                      .read<SearchUserByUsernameCubit>()
                      .searchUsername(value);
                },
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
                cursorColor: AppColors.greenColor,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Cari Pengguna',
                  hintStyle: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greyTextColor,
                  ),
                  contentPadding: const EdgeInsets.only(right: 8, left: 16),
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minHeight: 24,
                    minWidth: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildUser(BuildContext context, UserEntity user) => Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: BlocBuilder<CurrentUserIdCubit, CurrentUserIdState>(
          builder: (_, stateCurrentUserId) {
            if (stateCurrentUserId is CurrentUserIdLoaded) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    NamedRoutes.chatScreen,
                    arguments: user.toMap(),
                  );
                  context
                      .read<GetChatMessagesCubit>()
                      .checkChatExist(user.userId!);
                  context
                      .read<GetUserDataCubit>()
                      .getUser(stateCurrentUserId.userId);
                },
                child: CardChatItem(
                  user: user,
                  isSearchUser: true,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      );
}
