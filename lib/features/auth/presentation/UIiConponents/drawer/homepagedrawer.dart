import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/features/auth/presentation/UIiConponents/ui_helper/navigatorlisttile.dart';
import 'package:social_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:social_app/features/auth/presentation/pages/profilePage.dart';
import 'package:social_app/features/auth/presentation/pages/signin.dart';

class Homepagedrawer extends StatefulWidget {
  const Homepagedrawer({super.key});

  @override
  State<Homepagedrawer> createState() => _HomepagedrawerState();
}

class _HomepagedrawerState extends State<Homepagedrawer> {
  void _logout() {
    context.read<AuthCubit>().logout(); // ← Use the same cubit instance
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,

      child: SafeArea(
        child: Column(
          children: [
            Icon(
              Icons.person_2_rounded,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 30),

            // home page.........................................
            NavigatorListTile(
              text: "P R O F I L E",
              icon: Icons.person_outlined,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Profilepage()),
                );
              },
            ),

            // user profile
            NavigatorListTile(
              text: "H O M E P A G E",
              icon: Icons.home_outlined,
              onTap: () {
                Navigator.pop(context);
              },
            ),

            //search tile.......................................
            NavigatorListTile(
              text: "S E A R C H",
              icon: Icons.search_outlined,
              onTap: () {},
            ),

            // setting tile..........................................
            NavigatorListTile(
              text: "S E T T I N G",
              icon: Icons.settings_outlined,
              onTap: () {},
            ),
            const Spacer(),
            // logout
            NavigatorListTile(
              text: "L O G O U T",
              icon: Icons.logout_outlined,
              onTap: () {
                Navigator.pop(context);
                _logout();
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
