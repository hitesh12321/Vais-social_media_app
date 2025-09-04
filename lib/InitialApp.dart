import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/auth/data/firebase_auth_repo.dart';

import 'package:social_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:social_app/features/auth/presentation/pages/Authpage.dart';
import 'package:social_app/features/auth/presentation/pages/homepage.dart';

import 'package:social_app/themes/light_mode.dart';

class Initial extends StatefulWidget {
  const Initial({super.key});

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  final authRepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Lightmode,
       
home: BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is Authenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } else if (state is AuthFailed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error.toString())),
      );
    }
  },
  child: BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
      print("State::::: $state");
      
      if (state is AuthLoading || state is AuthInitial) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (state is Authenticated) {
        return const Homepage();
      } else {
        return const AuthPage();
      }
    },
  ),
),  ),
    );
  }
}
