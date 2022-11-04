import 'package:chatqu/app/app.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home-page';
  final Widget content;

  const HomePage({required this.content, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool sideBarActive = false;
  late AnimationController rotationController;

  @override
  void initState() {
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SafeArea(
        child: Stack(
          children: [_buildDrawer(), _buildPage(), _buildButtonDrawer()],
        ),
      ),
    );
  }

  Widget _buildButtonDrawer() => Positioned(
        left: MediaQuery.of(context).size.width - 50,
        top: 30,
        width: 30,
        height: 30,
        child: (sideBarActive)
            ? IconButton(
                onPressed: closeSideBar,
                padding: const EdgeInsets.only(right: 16),
                icon: const Icon(
                  Icons.close,
                  color: AppColors.blackColor,
                  size: 30,
                ),
              )
            : InkWell(
                onTap: openSideBar,
                child: Container(
                  margin: const EdgeInsets.all(17),
                  height: 30,
                  width: 30,
                ),
              ),
      );

  Widget _buildDrawer() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.only(left: 24),
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(60)),
                  color: AppColors.whiteColor,
                ),
                child: BlocBuilder<GetUserDataCubit, GetUserDataState>(
                  builder: (_, state) {
                    if (state is GetUserDataLoaded) {
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: state.user.imageProfile == ''
                                    ? Image.asset(
                                        AssetsPath.icProfile,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        fit: BoxFit.cover,
                                        state.user.imageProfile!,
                                      ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.user.name!,
                                    style: GoogleFonts.quicksand(
                                      color: AppColors.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Sedang Skripsi!",
                                    style: GoogleFonts.quicksand(
                                      color: AppColors.greyColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                navigatorTitle("Beranda", true),
                navigatorTitle("Profil", false),
                navigatorTitle("Tentang Kami", false),
              ],
            ),
          ),
          Container(
            width: 120,
            margin: const EdgeInsets.only(left: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                context.read<SignOutUserCubit>().signOutUser();
              },
              child: BlocListener<SignOutUserCubit, SignOutUserState>(
                listener: (_, state) {
                  if (state is SignOutUserLoaded) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, NamedRoutes.loginScreen, (route) => false);
                  } else if (state is SignOutUserError) {
                    debugPrint(state.message);
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        color: AppColors.blackColor,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Keluar",
                        style: GoogleFonts.quicksand(
                          color: AppColors.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 70),
        ],
      );

  Widget _buildPage() => AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        left: (sideBarActive) ? MediaQuery.of(context).size.width * 0.6 : 0,
        top: (sideBarActive) ? MediaQuery.of(context).size.height * 0.16 : 0,
        height: (sideBarActive)
            ? MediaQuery.of(context).size.height * 0.7
            : MediaQuery.of(context).size.height,
        width: (sideBarActive)
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.width,
        child: AnimatedRotation(
          turns: (sideBarActive) ? -0.05 : 0,
          duration: const Duration(milliseconds: 300),
          child: ClipRRect(
            borderRadius: sideBarActive
                ? const BorderRadius.all(Radius.circular(24))
                : const BorderRadius.all(Radius.circular(0)),
            child: widget.content,
          ),
        ),
      );

  Row navigatorTitle(String name, bool isSelected) {
    return Row(
      children: [
        (isSelected)
            ? Container(
                width: 5,
                height: 30,
                margin: const EdgeInsets.only(right: 10),
                color: AppColors.greenColor,
              )
            : Container(
                width: 5,
                height: 30,
                margin: const EdgeInsets.only(right: 10),
              ),
        const SizedBox(
          width: 10,
          height: 55,
        ),
        Text(
          name,
          style: GoogleFonts.quicksand(
            color: AppColors.blackColor,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void closeSideBar() {
    sideBarActive = false;
    setState(() {});
  }

  void openSideBar() {
    sideBarActive = true;
    setState(() {});
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }
}
