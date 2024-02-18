import 'package:flutter/material.dart';
import 'package:succeedemy/features/auth/screens/signin_screen.dart';
import 'package:succeedemy/features/auth/services/auth_service.dart';
import 'package:succeedemy/utils/global_variables.dart';
import 'package:succeedemy/features/auth/widgets/custom_button.dart';
import 'package:succeedemy/features/auth/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signupKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? selectedClass;
  final AuthService authService = AuthService();

  void signupUser() {
    authService.signupUser(
        context: context,
        name: _nameController.text,
        mobile: _mobileController.text,
        email: _emailController.text,
        dob: DateTime.parse(_dobController.text),
        studentClass: selectedClass!,
        password: _passwordController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _dobController.dispose();
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
              Center(
                child: Image.asset(
                  logo,
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Sign UP',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _signupKey,
                  child: Column(children: [
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Name',
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _mobileController,
                      hintText: 'Mobile',
                      textInputType: TextInputType.phone,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      dropdownColor: Colors.grey[100],
                      menuMaxHeight: 200,
                      icon: const Icon(Icons.arrow_drop_down, size: 24),
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Class",
                        border: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(context)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(context)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(context)),
                        filled: true,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      isExpanded: true,
                      value: selectedClass,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select class';
                        }
                        return null;
                      },
                      items: classes.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _dobController,
                      hintText: "Date of Birth",
                      textInputType: TextInputType.datetime,
                      isDob: true,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      textInputType: TextInputType.visiblePassword,
                      isPass: true,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: 'Sign UP',
                      onTap: () {
                        if (_signupKey.currentState!.validate()) {
                          signupUser();
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
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                    child: const Text('SignIN',
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
