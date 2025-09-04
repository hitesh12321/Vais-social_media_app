import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/features/auth/presentation/pages/Authpage.dart';
import 'package:social_app/ui_helper/uihelper.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  Future<void> forgetMethod(String email) async {
    try {
      if (email.isEmpty) {
        Uihelper.customnsackbar(context, "Please Enter An Email");
        return;
      } else {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        if (mounted) {
          forgetAlertBox(context, "Password Reset Email Sent", () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AuthPage()),
            );
          });
        }
      }
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "user-not-found") {
        Uihelper.customAlerBox(context, "User Not Found");
      } else if (ex.code == "invalid-email") {
        Uihelper.customAlerBox(context, "Invalid Email");
      } else {
        Uihelper.customAlerBox(context, "Something Went Wrong");
      }
    }
  }

  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Uihelper.customTextField(
            emailController,
            "Email",
            Icons.email,
            false,
          ),

          SizedBox(height: 20),

          Uihelper.customButton(() {
            forgetMethod(emailController.text);
          }, "Confirm"),

          SizedBox(height: 17),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back To Login", style: TextStyle(fontSize: 22)),
          ),
        ],
      ),
    );
  }

  forgetAlertBox(BuildContext context, String text, VoidCallback onPressedOK) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                if (onPressedOK != null) {
                  onPressedOK();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
