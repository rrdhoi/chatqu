import 'package:chatqu/app/app.dart';
import 'package:chatqu/app/di/injection.dart' as di;
import 'package:chatqu/firebase_options.dart';
import 'package:chatqu/presentation/pages/splash_screen_page.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // user
        BlocProvider(create: (_) => di.locator<SignUpUserCubit>()),
        BlocProvider(create: (_) => di.locator<SignInUserCubit>()),
        BlocProvider(create: (_) => di.locator<SignOutUserCubit>()),
        BlocProvider(create: (_) => di.locator<SearchUserByUsernameCubit>()),
        BlocProvider(create: (_) => di.locator<GetUserDataCubit>()),
        BlocProvider(create: (_) => di.locator<GetUsersListCubit>()),
        // chat
        BlocProvider(create: (_) => di.locator<GetAllChatCubit>()),
        BlocProvider(create: (_) => di.locator<SendMessageCubit>()),
        BlocProvider(create: (_) => di.locator<GetChatMessagesCubit>()),
        BlocProvider(create: (_) => di.locator<CurrentUserIdCubit>()),
        //files
        BlocProvider(create: (_) => di.locator<UploadImageProfileCubit>()),
      ],
      child: MaterialApp(
        title: 'Chatqu App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.whiteColor,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeTransitionBuilder(),
            TargetPlatform.android: FadeTransitionBuilder(),
          }),
        ),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case NamedRoutes.homeScreen:
              return MaterialPageRoute(
                builder: (context) => const HomePage(
                  content: HomeContentPage(),
                ),
              );
            case NamedRoutes.detailChatScreen:
              return MaterialPageRoute(
                builder: (_) => const DetailChatPage(),
                settings: settings,
              );
            case NamedRoutes.loginScreen:
              return MaterialPageRoute(
                builder: (context) => const LoginPage(),
              );
            case NamedRoutes.registerScreen:
              return MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              );
            case NamedRoutes.searchScreen:
              return MaterialPageRoute(
                builder: (context) => const SearchPage(),
              );
            case NamedRoutes.chatScreen:
              return MaterialPageRoute(
                builder: (context) => const ChatPage(),
                settings: settings,
              );
            case NamedRoutes.addImageProfileScreen:
              return MaterialPageRoute(
                builder: (context) => const AddImageProfilePage(),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder: (context) {
                  context.read<CurrentUserIdCubit>().getCurrentUserId();
                  return const SplashScreenPage();
                },
              );
          }
        },
      ),
    );
  }
}
