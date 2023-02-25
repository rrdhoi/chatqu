import 'package:chatqu/app/app.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool showLogo = false;
  String? signInUser;

  @override
  void initState() {
    context.read<CurrentUserIdCubit>().getCurrentUserId();
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => setState(() => showLogo = true));
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        if (signInUser != null && mounted) {
          _splashScreenBlocSinkInput(signInUser!);
          Navigator.pushReplacementNamed(context, NamedRoutes.homeScreen);
        } else if (mounted) {
          Navigator.pushReplacementNamed(context, NamedRoutes.loginScreen);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      body: BlocListener<CurrentUserIdCubit, CurrentUserIdState>(
        listener: (context, state) {
          if (state is CurrentUserIdLoaded) {
            setState(() => signInUser = state.userId);
          } else if (state is CurrentUserIdError) {
            CustomSnackBar.snackBar(context, "Terjadi kesalaha coba lagi");
          }
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  width: width * 0.8,
                  "assets/images/top-bg-splash.png",
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  width: width * 0.7,
                  "assets/images/bot_bg_splash.png",
                ),
              ),
              AnimatedPositioned(
                left: showLogo ? width * 0.575 : width * 0.5 - 120,
                duration: const Duration(milliseconds: 500),
                child: Image.asset(
                  AssetsPath.imgSmLogo,
                  height: 90,
                ),
              ),
              Positioned(
                right: width * 0.5 - 35,
                child: AnimatedOpacity(
                  curve: Curves.easeInOut,
                  opacity: showLogo ? 1 : 0,
                  duration: const Duration(milliseconds: 1350),
                  child: Image.asset(
                    AssetsPath.imgTextChat,
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _splashScreenBlocSinkInput(String signInUser) {
    context.read<GetUserDataCubit>().getUser(signInUser);
    context.read<GetOwnRequestCubit>().getOwnRequests(signInUser);
    context.read<GetFriendRequestCubit>().getFriendRequests(signInUser);
    context.read<GetAllFriendsCubit>().getAllFriends(signInUser);
    context.read<GetAllChatCubit>().getAllChat(signInUser);
  }
}
