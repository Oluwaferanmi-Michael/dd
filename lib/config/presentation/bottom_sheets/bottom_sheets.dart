import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BottomSheet {
  final Widget presentation;
  final String title;
  final List<ButtonOptions> buttons;

  BottomSheet(
      {required this.presentation, required this.title, required this.buttons});

  Future<void> present(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(title),
                presentation,
                Row(
                  children: [
                    ...buttons.map((e) {
                  return TextButton(
                    style: e == buttons.first ? const ButtonStyle() : const ButtonStyle(),
                      onPressed: (e.onPressed), child: Text(e.text));
                })
                ]
                )
                
              ],
            ),
          );
        });
  }
}

class ButtonOptions extends Equatable{
  final String text;
  final void Function() onPressed;

  const ButtonOptions({required this.text, required this.onPressed});
  
  @override
  List<Object?> get props => [text, onPressed];
}
