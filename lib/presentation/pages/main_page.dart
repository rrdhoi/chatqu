import 'package:chatqu/app/app.dart';
import 'package:chatqu/presentation/pages/friends/friends_page.dart';
import 'package:chatqu/presentation/pages/home/side_bar_navigation.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/home-page';
  final Widget content;

  const MainPage({required this.content, Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  bool sideBarActive = false;
  late AnimationController rotationController;
  int _currentIndex = 0;

  @override
  void initState() {
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    super.initState();
  }

  void _onSelectedPage(int index) {
    setState(() => _currentIndex = index);
    closeSideBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: BlocBuilder<GetUserDataCubit, GetUserDataState>(
        builder: (context, state) {
          if (state is GetUserDataLoaded) {
            final List<Widget> pages = [
              const HomeContentPage(),
              FriendsPage(myUser: state.user)
            ];

            return SafeArea(
              child: Stack(
                children: [
                  _buildDrawer(),
                  _buildPage(pages),
                  _buildButtonDrawer()
                ],
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
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.only(left: 24, top: 24),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: AppColors.whiteColor,
                    ),
                    borderRadius: BorderRadius.circular(16)),
                child: BlocBuilder<GetUserDataCubit, GetUserDataState>(
                  builder: (_, state) {
                    if (state is GetUserDataLoaded) {
                      return SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: state.user.imageProfile == null
                              ? Image.asset(
                                  AssetsPath.icProfile,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  fit: BoxFit.cover,
                                  state.user.imageProfile!,
                                ),
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
              child: SideBarNavigation(
            onTap: _onSelectedPage,
            currentIndex: _currentIndex,
            items: [
              SideBarItem(title: "Beranda"),
              SideBarItem(title: "Teman"),
            ],
          )),
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
          const SizedBox(height: 94),
        ],
      );

  Widget _buildPage(List<Widget> pages) => AnimatedPositioned(
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
            child: pages.elementAt(_currentIndex),
          ),
        ),
      );

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
