import 'package:flutter/material.dart';
import 'package:succeedemy/features/auth/screens/signup_screen.dart';
import 'package:succeedemy/features/auth/services/auth_service.dart';
import 'package:succeedemy/features/auth/widgets/custom_button.dart';
import 'package:succeedemy/features/auth/widgets/custom_text_field.dart';
import 'package:succeedemy/utils/global_variables.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/signin-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _signinKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void signinUser() {
    authService.signinUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0).copyWith(top: 10),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  logo,
                  height: 100,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Sign IN',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _signinKey,
                  child: Column(children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      textInputType: TextInputType.visiblePassword,
                      isPass: true,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: 'Sign IN',
                      onTap: () {
                        if (_signinKey.currentState!.validate()) {
                          signinUser();
                        }
                      },
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: const Text('SignUP',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
