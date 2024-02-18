import 'package:flutter/material.dart';
import 'package:succeedemy/features/auth/screens/signin_screen.dart';
import 'package:succeedemy/features/home/widgets/notes_screen.dart';
import 'package:succeedemy/features/home/widgets/subjects_screen.dart';
import 'package:succeedemy/introduction_screen.dart';
import 'package:succeedemy/features/auth/screens/signup_screen.dart';
import 'package:succeedemy/utils/bottom_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case IntrdouctionScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const IntrdouctionScreen());
    case SignInScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignInScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(builder: (context) => const BottomBar());
    case SubjectScreen.routeName:
      var args = routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => SubjectScreen(
              subject: args['subject']!, studentClass: args['studentClass']!));
    case NotesScreen.routeName:
      return MaterialPageRoute(builder: (context) => const NotesScreen());
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(child: Text('Screen doesn\'t exist!')),
              ));
  }
}
