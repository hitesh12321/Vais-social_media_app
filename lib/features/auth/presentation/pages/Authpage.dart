import 'package:flutter/material.dart';
import 'package:social_app/features/auth/presentation/pages/signin.dart';
import 'package:social_app/features/auth/presentation/pages/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showSigninPage = true;

  void togglePages() {
    setState(() {
      showSigninPage = !showSigninPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSigninPage) {
      return const Signin();
    } else {
      return const Signup();
    }
  }
}
