import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
// import '../../theme/insets.dart';
import '../../widgets/gap.dart';

class BottomSheetModel {
  final Widget presentation;
  Text? description;
  final String title;

  BottomSheetModel({
    required this.presentation,
    required this.title,
    this.description,
  });
}

class ButtonOptions extends Equatable {
  final String text;
  final void Function() onPressed;

  const ButtonOptions({required this.text, required this.onPressed});

  @override
  List<Object?> get props => [text, onPressed];
}

extension Present on BottomSheetModel {
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
                const Gap(height: 16),
                Flexible(child: SingleChildScrollView(child: presentation)),
              ],
            ),
          );
        });
  }
}
