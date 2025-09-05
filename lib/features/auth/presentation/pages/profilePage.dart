import 'package:flutter/material.dart';
import 'package:social_app/features/auth/presentation/pages/homepage.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Homepage()),
            );
          },
          child: Text("Home Page"),
        ),
      ),
    );
  }
}
