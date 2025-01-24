import 'package:flutter/material.dart';

class AlertDialogModel {
  const AlertDialogModel({
    required this.title,
    required this.presentation,
    required this.buttons,
  });

  final Widget title;
  final Widget presentation;
  final Map<String, bool> buttons;
}

extension ShowDialog on AlertDialogModel {
  void present(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          contentPadding: EdgeInsets.zero,
          
          title: title,
          titleTextStyle: const TextStyle(fontSize: 12),
          content: presentation,
          actions: buttons.entries
              .map((e) =>
                  TextButton(onPressed: () {}, child: const Text('Button')))
              .toList(),
        );
      },
    );
  }
}
