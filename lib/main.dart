import 'dart:async';

import 'package:chatqu/app/app.dart';
import 'package:chatqu/app/di/injection.dart' as di;
import 'package:chatqu/firebase_options.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:chatqu/routes.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      di.init();
      runApp(const MyApp());
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );

  /*if (kDebugMode) {
    try {
      FirebaseFirestore.instance.settings = const Settings(
        host: '10.0.2.2:8080',
        sslEnabled: false,
        persistenceEnabled: false,
      );
      await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
      await FirebaseStorage.instance.useStorageEmulator('10.0.2.2', 9199);
    } catch (e) {
      print(e);
    }
  }*/
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // friend
        BlocProvider(create: (_) => di.locator<GetAllFriendsCubit>()),
        BlocProvider(create: (_) => di.locator<GetOwnRequestCubit>()),
        BlocProvider(create: (_) => di.locator<AcceptFriendCubit>()),
        BlocProvider(create: (_) => di.locator<GetFriendRequestCubit>()),
        BlocProvider(create: (_) => di.locator<AddFriendCubit>()),
        // user
        BlocProvider(create: (_) => di.locator<SignUpUserCubit>()),
        BlocProvider(create: (_) => di.locator<SignInUserCubit>()),
        BlocProvider(create: (_) => di.locator<SignOutUserCubit>()),
        BlocProvider(create: (_) => di.locator<SearchUserByUsernameCubit>()),
        BlocProvider(create: (_) => di.locator<GetUserDataCubit>()),
        // chat
        BlocProvider(create: (_) => di.locator<SendGroupMessageCubit>()),
        BlocProvider(create: (_) => di.locator<GetGroupChatMessagesCubit>()),
        BlocProvider(create: (_) => di.locator<CreateGroupChatCubit>()),
        BlocProvider(create: (_) => di.locator<GetAllChatCubit>()),
        BlocProvider(create: (_) => di.locator<SendMessageCubit>()),
        BlocProvider(create: (_) => di.locator<GetChatMessagesCubit>()),
        BlocProvider(create: (_) => di.locator<CurrentUserIdCubit>()),
        // files
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
        onGenerateRoute: (RouteSettings settings) => routes(settings),
      ),
    );
  }
}
