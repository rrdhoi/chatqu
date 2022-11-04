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
  String signInUser = '';

  @override
  void initState() {
    context.read<CurrentUserIdCubit>().getCurrentUserId();
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      setState(() => showLogo = true);
      Future.delayed(const Duration(seconds: 2)).then(
        (value) {
          if (signInUser != '') {
            context.read<CurrentUserIdCubit>().getCurrentUserId();
            context.read<GetAllChatCubit>().getAllChat();
            context.read<GetUserDataCubit>().getUser(signInUser);
            Navigator.pushReplacementNamed(context, NamedRoutes.homeScreen);
          } else {
            Navigator.pushReplacementNamed(context, NamedRoutes.loginScreen);
          }
        },
      );
    });
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
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  left: showLogo ? width * 0.515 : width * 0.5 - 120,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    AssetsPath.imgSmLogo,
                    height: 90,
                  ),
                ),
                Positioned(
                  right: width * 0.5 - 60,
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
          )),
    );
  }
}
