import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:succeedemy/features/auth/screens/signin_screen.dart';
import 'package:succeedemy/features/auth/screens/signup_screen.dart';
import 'package:succeedemy/utils/global_variables.dart';

class IntrdouctionScreen extends StatefulWidget {
  static const String routeName = '/introduction-screen';
  const IntrdouctionScreen({super.key});

  @override
  State<IntrdouctionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntrdouctionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: introductionData.map((e) {
          String? icon = e['icon'];
          return PageViewModel(
            title: e['title'],
            body: e['body'],
            image: Center(
              child: icon == null
                  ? Image.asset(
                      logo,
                      height: 200,
                    )
                  : Image.asset(
                      'assets/images/$icon',
                      height: 200,
                    ),
            ),
            decoration: const PageDecoration(
              titleTextStyle:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0),
              bodyTextStyle: TextStyle(fontSize: 20.0),
            ),
          );
        }).toList(),
        showSkipButton: true,
        skip: const Icon(Icons.skip_next),
        next: const Text("Next"),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w700)),
        onDone: () {
          Navigator.pushNamed(context, SignUpScreen.routeName);
        },
        onSkip: () {
          Navigator.pushNamed(context, SignInScreen.routeName);
        },
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).colorScheme.secondary,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }
}
