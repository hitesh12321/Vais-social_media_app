import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/ui_helper/uihelper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void _logout() {
    context.read<AuthCubit>().logout(); // ← Use the same cubit instance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HomePage"),

            SizedBox(height: 20),

            Uihelper.customButton(() async {
              _logout();
            }, "logout"),
          ],
        ),
      ),
    );
  }
}
