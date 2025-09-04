import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:social_app/features/auth/presentation/pages/forgetpwpage.dart';
import 'package:social_app/features/auth/presentation/pages/homepage.dart';
import 'package:social_app/features/auth/presentation/pages/register.dart';
import 'package:social_app/ui_helper/uihelper.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Navigate to home page when authenticated
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        } else if (state is AuthFailed) {
          // Show error message
          Uihelper.customnsackbar(context, state.error.toString());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Icon(
                Icons.lock_open_rounded,
                size: 70,
                color: Theme.of(context).primaryColor,
              ),
              Text("Welcome Back!", style: TextStyle(fontSize: 20)),
              SizedBox(height: 50),
              Uihelper.customTextField(
                emailController,
                "Email",
                Icons.email_rounded,
                false,
              ),
              SizedBox(height: 20),
              Uihelper.customTextField(
                passwordController,
                "Password",
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
                    loginMethod(emailController.text, passwordController.text);
                  }, "Login");
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not A Member?", style: TextStyle(fontSize: 18)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: Text(
                      'Register Now!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Uihelper.customButton(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgetPasswordScreen(),
                  ),
                );
              }, "Forget Password"),
            ],
          ),
        ),
      ),
    );
  }

  void loginMethod(email, pw) {
    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && pw.isNotEmpty) {
      authCubit.login(email, pw);
    } else {
      Uihelper.customnsackbar(context, "Please enter email and password");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
