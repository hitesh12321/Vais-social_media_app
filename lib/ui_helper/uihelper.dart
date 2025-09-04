import 'package:flutter/material.dart';

class Uihelper {
  static customTextField(
    TextEditingController controller,
    String hintText,
    IconData iconData,

    bool toHIde,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        obscureText: toHIde,
      ),
    );
  }

  static customButton(VoidCallback onPressed, String text) {
    return SizedBox(
      height: 60,
      width: 180,

      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 20)),
      ),
    );
  }

  static customAlerBox(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static customnsackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
