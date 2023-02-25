import 'package:chatqu/presentation/pages/chat/group_chat_page.dart';
import 'package:chatqu/presentation/pages/friends/friend_requests_screen.dart';
import 'package:chatqu/presentation/presentation.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'presentation/pages/friends/search_user_page.dart';

MaterialPageRoute<dynamic> routes(RouteSettings settings) {
  switch (settings.name) {
    case NamedRoutes.homeScreen:
      return MaterialPageRoute(builder: (context) {
        return const MainPage(
          content: HomeContentPage(),
        );
      });
    case NamedRoutes.loginScreen:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
    case NamedRoutes.registerScreen:
      return MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      );
    case NamedRoutes.searchChatScreen:
      return MaterialPageRoute(
        builder: (context) => const SearchChatPage(),
      );
    case NamedRoutes.searchUserScreen:
      return MaterialPageRoute(
        builder: (context) => const SearchUserPage(),
      );
    case NamedRoutes.friendRequestsScreen:
      return MaterialPageRoute(
        builder: (context) => const FriendRequestPage(),
      );
    case NamedRoutes.personalChatScreen:
      return MaterialPageRoute(
        builder: (context) => const PersonalChatPage(),
        settings: settings,
      );
    case NamedRoutes.groupChatScreen:
      return MaterialPageRoute(
        builder: (context) => const GroupChatPage(),
        settings: settings,
      );
    case NamedRoutes.addImageProfileScreen:
      return MaterialPageRoute(
        builder: (context) => const AddImageProfilePage(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const SplashScreenPage(),
      );
  }
}
