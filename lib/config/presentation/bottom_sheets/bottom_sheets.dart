import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
// import '../../theme/insets.dart';
import '../../widgets/gap.dart';

class BottomSheet {
  final Widget presentation;
  final String title;
  final List<ButtonOptions> buttons;

  BottomSheet(
      {required this.presentation, required this.title, required this.buttons});

  Future<void> present(BuildContext context) async {
    return showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        isDismissible: true,
        elevation: 4,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
                16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.sticky_note_2_outlined,
                      color: AppColors.purple,
                    ),
                    const Gap(width: 16),
                    Text(title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ))
                  ],
                ),
                const Gap(height: 24),
                Flexible(child: presentation),
                const Gap(height: 24),
                Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(width: 1)),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      const Gap(width: 12),
                      ...buttons.map((e) {
                        return Expanded(
                          flex: 2,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: AppColors.seed),
                            onPressed: e.onPressed,
                            child: Text(
                              e.text,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      })
                    ])
              ],
            ),
          );
        });
  }
}

class ButtonOptions extends Equatable {
  final String text;
  final void Function() onPressed;

  const ButtonOptions({required this.text, required this.onPressed});

  @override
  List<Object?> get props => [text, onPressed];
}
