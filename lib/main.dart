import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:succeedemy/features/auth/services/auth_service.dart';
import 'package:succeedemy/introduction_screen.dart';
import 'package:succeedemy/provider/user_provider.dart';
import 'package:succeedemy/routes.dart';
import 'package:succeedemy/utils/bottom_bar.dart';
import 'package:succeedemy/utils/global_variables.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => (UserProvider()),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  void initializeApp() async {
    await authService.getUserData(context);
    setState(() {
      Timer(const Duration(seconds: 2), () => isLoading = false);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Succeedemy',
        theme: ThemeData(
            colorScheme: const ColorScheme.light(primary: Colors.green),
            useMaterial3: true),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: isLoading
            ? Container(
                color: Colors.white,
                child: Image.asset(logo),
              )
            : context.watch<UserProvider>().user.token.isNotEmpty
                ? Provider.of<UserProvider>(context).user.type == 'student'
                    ? const BottomBar()
                    : Container()
                : const IntrdouctionScreen());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () => Navigator.pushNamed(context, IntrdouctionScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset(logo),
    );
  }
}
