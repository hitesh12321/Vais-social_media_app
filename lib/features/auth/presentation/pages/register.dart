import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:social_app/features/auth/presentation/pages/homepage.dart';
import 'package:social_app/features/auth/presentation/pages/signin.dart';
import 'package:social_app/features/auth/presentation/UIiConponents/ui_helper/uihelper.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        } else if (state is AuthFailed) {
          Uihelper.customnsackbar(context, state.error.toString());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Icon(
                Icons.lock_rounded,
                size: 70,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                "Let's Create an Account for you",
                style: TextStyle(fontSize: 20),
              ),
              Uihelper.customTextField(
                nameController,
                "Username",
                Icons.near_me_rounded,
                false,
              ),
              Uihelper.customTextField(
                emailController,
                "Email",
                Icons.email_rounded,
                false,
              ),
              Uihelper.customTextField(
                passwordController,
                "Password",
                Icons.password_rounded,
                true,
              ),
              Uihelper.customTextField(
                checkPasswordController,
                " Confirm Password",
                Icons.password_rounded,
                true,
              ),
              SizedBox(height: 30),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator();
                  }
                  return Uihelper.customButton(() {
                    registerMethod();
                  }, "Register");
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member?", style: TextStyle(fontSize: 18)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signin()),
                      );
                    },
                    child: Text(
                      'Sign In !',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerMethod() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String checkPassword = checkPasswordController.text.trim();
    String name = nameController.text.trim();
    final bool isEmailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    final authCubit = context.read<AuthCubit>();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        checkPassword.isEmpty) {
      Uihelper.customnsackbar(context, "Please fill in all fields.");
      return;
    }
    if (password != checkPassword) {
      Uihelper.customnsackbar(context, "Passwords do not match.");
      return;
    }
    if (!isEmailValid) {
      Uihelper.customnsackbar(context, "Invalid email address.");
      return;
    }
    authCubit.register(name, email, password);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    checkPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}