import 'package:flutter/material.dart';

class NavigatorListTile extends StatelessWidget {
  final String text;

  final IconData icon;
  final void Function()? onTap;
  const NavigatorListTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onTap: onTap,
        leading: Icon(icon),
        title: Text(text, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
