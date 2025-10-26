import 'package:flutter/material.dart';

void showAlert(BuildContext context, String text, String actionText, Function cancelCallback, Function actionCallback) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () => cancelCallback(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => actionCallback(),
          child: Text(actionText),
        ),
      ],
    ), 
  );
}